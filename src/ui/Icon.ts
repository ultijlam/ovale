import { l } from "./Localization";
import { format } from "@wowts/string";
import { LuaObj, next, tostring, _G } from "@wowts/lua";
import {
    GetTime,
    PlaySoundFile,
    UIFrame,
    UIFontString,
    UITexture,
    UICooldown,
    UICheckButton,
    CreateFrame,
    GameTooltip,
    UIPosition,
} from "@wowts/wow-mock";
import { huge } from "@wowts/math";
import { NodeActionResult, AstIconNode } from "../engine/ast";
import { OvaleOptionsClass } from "./Options";
import { OvaleSpellBookClass } from "../states/SpellBook";
import { ActionType } from "../engine/best-action";
import { isNumber, isString } from "../tools/tools";
import { AceGUIWidgetCheckBox, AceGUIWidgetDropDown } from "@wowts/ace_gui-3.0";
import { LocalizationStrings } from "./localization/definition";
import { OvaleActionBarClass } from "../engine/action-bar";
const infinity = huge;
const cooldownThreshold = 0.1;

export interface IconParent {
    checkBoxWidget: LuaObj<AceGUIWidgetCheckBox>;
    listWidget: LuaObj<AceGUIWidgetDropDown>;
    iconsFrame: UIFrame;
    toggleOptions(): void;
    debugIcon(index: number): void;
}

export class OvaleIcon {
    actionHelp: string | undefined;
    actionId: number | string | undefined;
    actionType: ActionType | undefined;
    actionButton = false;
    namedParams: AstIconNode["rawNamedParams"] | undefined;
    positionalParams: AstIconNode["rawPositionalParams"] | undefined;
    texture: string | undefined;
    cooldownStart: undefined | number;
    cooldownEnd: undefined | number;
    lastSound: string | undefined;
    fontScale: undefined | number;
    value: number | undefined;
    help: keyof Required<LocalizationStrings> | undefined;
    shouldClick = false;
    cdShown = false;
    focusText: UIFontString;
    fontFlags: number;
    fontHeight: number;
    fontName: string;
    normalTexture: UITexture;
    cd: UICooldown;
    rangeIndicator: UIFontString;
    remains: UIFontString;
    shortcut: UIFontString;
    icon: UITexture;
    frame: UICheckButton;

    hasScriptControls() {
        return (
            next(this.parent.checkBoxWidget) != undefined ||
            next(this.parent.listWidget) != undefined
        );
    }

    constructor(
        private index: number,
        name: string,
        private parent: IconParent,
        secure: boolean,
        private ovaleOptions: OvaleOptionsClass,
        private ovaleSpellBook: OvaleSpellBookClass,
        private actionBar: OvaleActionBarClass
    ) {
        this.frame = CreateFrame(
            "CheckButton",
            name,
            parent.iconsFrame,
            (secure && "SecureActionButtonTemplate, ActionButtonTemplate") ||
                "ActionButtonTemplate"
        );
        const profile = this.ovaleOptions.db.profile;
        this.icon = _G[`${name}Icon`];
        this.shortcut = _G[`${name}HotKey`];
        this.remains = _G[`${name}Name`];
        this.rangeIndicator = _G[`${name}Count`];
        this.rangeIndicator.SetText(profile.apparence.targetText);
        this.cd = _G[`${name}Cooldown`];
        this.normalTexture = _G[`${name}NormalTexture`];
        const [fontName, fontHeight, fontFlags] = this.shortcut.GetFont();
        this.fontName = fontName;
        this.fontHeight = fontHeight;
        this.fontFlags = fontFlags;
        this.focusText = this.frame.CreateFontString(undefined, "OVERLAY");
        this.cdShown = true;
        this.shouldClick = false;
        this.help = undefined;
        this.value = undefined;
        this.fontScale = undefined;
        this.lastSound = undefined;
        this.cooldownEnd = undefined;
        this.cooldownStart = undefined;
        this.texture = undefined;
        this.positionalParams = undefined;
        this.namedParams = undefined;
        this.actionButton = false;
        this.actionType = undefined;
        this.actionId = undefined;
        this.actionHelp = undefined;
        this.frame.SetScript("OnMouseUp", this.onMouseUp);
        this.frame.SetScript("OnEnter", this.onEnter);
        this.frame.SetScript("OnLeave", this.onLeave);
        this.focusText.SetFontObject("GameFontNormalSmall");
        this.focusText.SetAllPoints(this.frame);
        this.focusText.SetTextColor(1, 1, 1);
        this.focusText.SetText(l["focus"]);
        this.frame.RegisterForClicks("AnyUp");
        if (profile.apparence.clickThru) {
            this.frame.EnableMouse(false);
        }
    }

    setValue(value: number | undefined, actionTexture: string | undefined) {
        this.icon.Show();
        this.icon.SetTexture(actionTexture);
        this.icon.SetAlpha(this.ovaleOptions.db.profile.apparence.alpha);
        this.cd.Hide();
        this.focusText.Hide();
        this.rangeIndicator.Hide();
        this.shortcut.Hide();
        if (value) {
            this.actionType = "value";
            this.actionHelp = undefined;
            this.value = value;
            if (value < 10) {
                this.remains.SetFormattedText("%.1f", value);
            } else if (value == infinity) {
                this.remains.SetFormattedText("inf");
            } else {
                this.remains.SetFormattedText("%d", value);
            }
            this.remains.Show();
        } else {
            this.remains.Hide();
        }
        this.frame.Show();
    }
    update(element: NodeActionResult, startTime?: number) {
        this.actionType = element.actionType;
        this.actionId = element.actionId;
        this.value = undefined;
        const now = GetTime();
        const profile = this.ovaleOptions.db.profile;
        if (startTime && element.actionTexture) {
            const cd = this.cd;
            let resetCooldown = false;
            if (startTime > now) {
                const duration = cd.GetCooldownDuration();
                if (
                    duration == 0 &&
                    this.texture == element.actionTexture &&
                    this.cooldownStart &&
                    this.cooldownEnd
                ) {
                    resetCooldown = true;
                }
                if (
                    this.texture != element.actionTexture ||
                    !this.cooldownStart ||
                    !this.cooldownEnd
                ) {
                    this.cooldownStart = now;
                    this.cooldownEnd = startTime;
                    resetCooldown = true;
                } else if (
                    startTime < this.cooldownEnd - cooldownThreshold ||
                    startTime > this.cooldownEnd + cooldownThreshold
                ) {
                    if (
                        startTime - this.cooldownEnd > 0.25 ||
                        startTime - this.cooldownEnd < -0.25
                    ) {
                        this.cooldownStart = now;
                    } else {
                        const oldCooldownProgressPercent =
                            (now - this.cooldownStart) /
                            (this.cooldownEnd - this.cooldownStart);
                        this.cooldownStart =
                            (now - oldCooldownProgressPercent * startTime) /
                            (1 - oldCooldownProgressPercent);
                    }
                    this.cooldownEnd = startTime;
                    resetCooldown = true;
                }
                this.texture = element.actionTexture;
            } else {
                this.cooldownStart = undefined;
                this.cooldownEnd = undefined;
            }
            if (
                this.cdShown &&
                profile.apparence.flashIcon &&
                this.cooldownStart &&
                this.cooldownEnd
            ) {
                const [start, ending] = [this.cooldownStart, this.cooldownEnd];
                const duration = ending - start;
                if (resetCooldown && duration > cooldownThreshold) {
                    cd.SetDrawEdge(false);
                    cd.SetSwipeColor(0, 0, 0, 0.8);
                    cd.SetCooldown(start, duration);
                }
                cd.Show();
            } else {
                cd.Hide();
            }
            this.icon.Show();
            this.icon.SetTexture(element.actionTexture);
            if (element.actionUsable) {
                this.icon.SetAlpha(1);
            } else {
                this.icon.SetAlpha(0.5);
            }

            const options = element.options;
            if (options) {
                if (
                    options.nored != 1 &&
                    element.actionResourceExtend &&
                    element.actionResourceExtend > 0
                ) {
                    this.icon.SetVertexColor(0.75, 0.2, 0.2);
                } else {
                    this.icon.SetVertexColor(1, 1, 1);
                }
                if (isString(options.help)) this.actionHelp = options.help;
                if (!(this.cooldownStart && this.cooldownEnd)) {
                    this.lastSound = undefined;
                }
                if (isString(options.sound) && !this.lastSound) {
                    let delay;
                    if (isNumber(options.soundtime)) delay = options.soundtime;
                    else delay = 0.5;
                    if (now >= startTime - delay) {
                        this.lastSound = options.sound;
                        PlaySoundFile(this.lastSound);
                    }
                }
            }

            const red = false; // TODO This value is not set anymore, find why
            if (!red && startTime > now && profile.apparence.highlightIcon) {
                const lag = 0.6;
                const newShouldClick = startTime < now + lag;
                if (this.shouldClick != newShouldClick) {
                    if (newShouldClick) {
                        this.frame.SetChecked(true);
                    } else {
                        this.frame.SetChecked(false);
                    }
                    this.shouldClick = newShouldClick;
                }
            } else if (this.shouldClick) {
                this.shouldClick = false;
                this.frame.SetChecked(false);
            }
            if (
                (profile.apparence.numeric ||
                    (this.namedParams &&
                        this.namedParams.text &&
                        this.namedParams.text.type === "string" &&
                        this.namedParams.text.value === "always")) &&
                startTime > now
            ) {
                this.remains.SetFormattedText("%.1f", startTime - now);
                this.remains.Show();
            } else {
                this.remains.Hide();
            }
            let showShortcut = false;
            if (profile.apparence.raccourcis && element.actionSlot) {
                const binding = this.actionBar.getBindings(element.actionSlot);
                if (binding) {
                    this.shortcut.SetText(binding);
                    showShortcut = true;
                }
            }
            if (showShortcut) {
                this.shortcut.Show();
            } else {
                this.shortcut.Hide();
            }
            if (element.actionInRange === undefined) {
                this.rangeIndicator.Hide();
            } else if (element.actionInRange) {
                this.rangeIndicator.SetVertexColor(0.6, 0.6, 0.6);
                this.rangeIndicator.Show();
            } else {
                this.rangeIndicator.SetVertexColor(1.0, 0.1, 0.1);
                this.rangeIndicator.Show();
            }
            if (options && options.text) {
                this.focusText.SetText(tostring(options.text));
                this.focusText.Show();
            } else if (
                element.actionTarget &&
                element.actionTarget != "target"
            ) {
                this.focusText.SetText(element.actionTarget);
                this.focusText.Show();
            } else {
                this.focusText.Hide();
            }
            this.frame.Show();
        } else {
            this.icon.Hide();
            this.rangeIndicator.Hide();
            this.shortcut.Hide();
            this.remains.Hide();
            this.focusText.Hide();
            if (profile.apparence.hideEmpty) {
                this.frame.Hide();
            } else {
                this.frame.Show();
            }
            if (this.shouldClick) {
                this.frame.SetChecked(false);
                this.shouldClick = false;
            }
        }
        return [startTime, element];
    }
    setHelp(help: string | undefined) {
        this.help = help as keyof Required<LocalizationStrings>;
    }
    setParams(
        positionalParams: AstIconNode["rawPositionalParams"],
        namedParams: AstIconNode["rawNamedParams"]
        // secure?: boolean
    ) {
        this.positionalParams = positionalParams;
        this.namedParams = namedParams;
        this.actionButton = false;
        // if (secure) {
        //     for (const [k, v] of kpairs(namedParams)) {
        //         let [index] = find(k, "spell");
        //         if (index) {
        //             let prefix = sub(k, 1, index - 1);
        //             let suffix = sub(k, index + 5);
        //             this.frame.SetAttribute(`${prefix}type${suffix}`, "spell");
        //             this.frame.SetAttribute(
        //                 "unit",
        //                 this.namedParams.target || "target"
        //             );
        //             this.frame.SetAttribute(
        //                 k,
        //                 this.ovaleSpellBook.GetSpellName(<number>v) ||
        //                     "Unknown spell"
        //             );
        //             this.actionButton = true;
        //         }
        //     }
        // }
    }
    setRemainsFont(color: { r: number; g: number; b: number }) {
        this.remains.SetTextColor(color.r, color.g, color.b, 1.0);
        this.remains.SetJustifyH("left");
        this.remains.SetPoint("BOTTOMLEFT", 2, 2);
    }
    setFontScale(scale: number) {
        this.fontScale = scale;
        this.remains.SetFont(
            this.fontName,
            this.fontHeight * this.fontScale,
            this.fontFlags
        );
        this.shortcut.SetFont(
            this.fontName,
            this.fontHeight * this.fontScale,
            this.fontFlags
        );
        this.rangeIndicator.SetFont(
            this.fontName,
            this.fontHeight * this.fontScale,
            this.fontFlags
        );
        this.focusText.SetFont(
            this.fontName,
            this.fontHeight * this.fontScale,
            this.fontFlags
        );
    }
    setRangeIndicator(text: string) {
        this.rangeIndicator.SetText(text);
    }
    onMouseUp = (
        _: unknown,
        button:
            | "LeftButton"
            | "RightButton"
            | "MiddleButton"
            | "Button4"
            | "Button5"
    ) => {
        if (!this.actionButton) {
            if (button === "LeftButton") this.parent.toggleOptions();
            else if (button === "MiddleButton") {
                this.parent.debugIcon(this.index);
            }
        }
        this.frame.SetChecked(true);
    };
    onEnter = () => {
        if (this.help || this.actionType || this.hasScriptControls()) {
            GameTooltip.SetOwner(this.frame, "ANCHOR_BOTTOMLEFT");
            if (this.help) {
                GameTooltip.SetText(l[this.help] || this.help);
            }
            if (this.actionType) {
                let actionHelp: string;
                if (this.actionHelp) {
                    actionHelp = this.actionHelp;
                } else {
                    if (this.actionType == "spell" && isNumber(this.actionId)) {
                        actionHelp =
                            this.ovaleSpellBook.getSpellName(this.actionId) ||
                            "Unknown spell";
                    } else if (
                        this.actionType == "value" &&
                        isNumber(this.value)
                    ) {
                        actionHelp =
                            (this.value < infinity && tostring(this.value)) ||
                            "infinity";
                    } else {
                        actionHelp = format(
                            "%s %s",
                            this.actionType,
                            tostring(this.actionId)
                        );
                    }
                }
                GameTooltip.AddLine(actionHelp, 0.5, 1, 0.75);
            }
            if (this.hasScriptControls()) {
                GameTooltip.AddLine(l["options_tooltip"], 1, 1, 1);
            }
            GameTooltip.Show();
        }
    };
    onLeave = () => {
        if (this.help || this.hasScriptControls()) {
            GameTooltip.Hide();
        }
    };
    setPoint(
        anchor: UIPosition,
        reference: UIFrame,
        refAnchor: UIPosition,
        x: number,
        y: number
    ) {
        this.frame.SetPoint(anchor, reference, refAnchor, x, y);
    }

    // eslint-disable-next-line @typescript-eslint/naming-convention
    Show() {
        this.frame.Show();
    }

    // eslint-disable-next-line @typescript-eslint/naming-convention
    Hide() {
        this.frame.Hide();
    }

    setScale(scale: number) {
        this.frame.SetScale(scale);
    }

    enableMouse(enabled: boolean) {
        this.frame.EnableMouse(enabled);
    }
}
