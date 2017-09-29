import { L } from "./Localization";
import { OvaleDebug } from "./Debug";
import { OvaleProfiler } from "./Profiler";
import { OvaleArtifact } from "./Artifact";
import { OvaleAST, Node } from "./AST";
import { OvaleCondition } from "./Condition";
import { OvaleCooldown } from "./Cooldown";
import { OvaleData } from "./Data";
import { OvaleEquipment } from "./Equipment";
import { OvalePaperDoll } from "./PaperDoll";
import { OvalePower } from "./Power";
import { OvaleScore } from "./Score";
import { OvaleScripts } from "./Scripts";
import { OvaleSpellBook } from "./SpellBook";
import { OvaleStance } from "./Stance";
import { RegisterPrinter, Ovale } from "./Ovale";
let OvaleCompileBase = Ovale.NewModule("OvaleCompile", "AceEvent-3.0");
export let OvaleCompile: OvaleCompileClass;
let _ipairs = ipairs;
let _pairs = pairs;
let _tonumber = tonumber;
let _tostring = tostring;
let _type = type;
let strfind = string.find;
let strmatch = string.match;
let strsub = string.sub;
let _wipe = wipe;
let API_GetSpellInfo = GetSpellInfo;
let self_compileOnStances = false;
let self_canEvaluate = false;
let self_requirePreload = {
    1: "OvaleEquipment",
    2: "OvaleSpellBook",
    3: "OvaleStance"
}
let self_serial = 0;
let self_timesEvaluated = 0;
let self_icon: LuaArray<Node> = {
}
let NUMBER_PATTERN = "^%-?%d+%.?%d*$";
const HasTalent = function(talentId) {
    if (OvaleSpellBook.IsKnownTalent(talentId)) {
        return OvaleSpellBook.GetTalentPoints(talentId) > 0;
    } else {
        OvaleCompile.Print("Warning: unknown talent ID '%s'", talentId);
        return false;
    }
}
const RequireValue = function(value) {
    let required = (strsub(_tostring(value), 1, 1) != "!");
    if (!required) {
        value = strsub(value, 2);
        if (strmatch(value, NUMBER_PATTERN)) {
            value = _tonumber(value);
        }
    }
    return [value, required];
}
const TestConditionLevel = function(value) {
    return OvalePaperDoll.level >= value;
}
const TestConditionMaxLevel = function(value) {
    return OvalePaperDoll.level <= value;
}
const TestConditionSpecialization = function(value) {
    let [spec, required] = RequireValue(value);
    let isSpec = OvalePaperDoll.IsSpecialization(spec);
    return (required && isSpec) || (!required && !isSpec);
}
const TestConditionStance = function(value) {
    self_compileOnStances = true;
    let [stance, required] = RequireValue(value);
    let isStance = OvaleStance.IsStance(stance);
    return (required && isStance) || (!required && !isStance);
}
const TestConditionSpell = function(value) {
    let [spell, required] = RequireValue(value);
    let hasSpell = OvaleSpellBook.IsKnownSpell(spell);
    return (required && hasSpell) || (!required && !hasSpell);
}
const TestConditionTalent = function(value) {
    let [talent, required] = RequireValue(value);
    let hasTalent = HasTalent(talent);
    return (required && hasTalent) || (!required && !hasTalent);
}
const TestConditionEquipped = function(value) {
    let [item, required] = RequireValue(value);
    let hasItemEquipped = OvaleEquipment.HasEquippedItem(item);
    return (required && hasItemEquipped) || (!required && !hasItemEquipped);
}
const TestConditionTrait = function(value) {
    let [trait, required] = RequireValue(value);
    let hasTrait = OvaleArtifact.HasTrait(trait);
    return (required && hasTrait) || (!required && !hasTrait);
}
let TEST_CONDITION_DISPATCH = {
    if_spell: TestConditionSpell,
    if_equipped: TestConditionEquipped,
    if_stance: TestConditionStance,
    level: TestConditionLevel,
    maxLevel: TestConditionMaxLevel,
    specialization: TestConditionSpecialization,
    talent: TestConditionTalent,
    trait: TestConditionTrait,
    pertrait: TestConditionTrait
}
const TestConditions = function(positionalParams, namedParams) {
    OvaleCompile.StartProfiling("OvaleCompile_TestConditions");
    let boolean = true;
    for (const [param, dispatch] of _pairs(TEST_CONDITION_DISPATCH)) {
        let value = namedParams[param];
        if (_type(value) == "table") {
            for (const [_, v] of _ipairs(value)) {
                boolean = dispatch(v);
                if (!boolean) {
                    break;
                }
            }
        } else if (value) {
            boolean = dispatch(value);
        }
        if (!boolean) {
            break;
        }
    }
    if (boolean && namedParams.itemset && namedParams.itemcount) {
        let equippedCount = OvaleEquipment.GetArmorSetCount(namedParams.itemset);
        boolean = (equippedCount >= namedParams.itemcount);
    }
    if (boolean && namedParams.checkbox) {
        const profile = Ovale.db.profile;
        for (const [_, checkbox] of _ipairs(namedParams.checkbox)) {
            let [name, required] = RequireValue(checkbox);
            const control = Ovale.checkBox[name] || {}
            control.triggerEvaluation = true;
            Ovale.checkBox[name] = control;
            let isChecked = profile.check[name];
            boolean = (required && isChecked) || (!required && !isChecked);
            if (!boolean) {
                break;
            }
        }
    }
    if (boolean && namedParams.listitem) {
        const profile = Ovale.db.profile;
        for (const [name, listitem] of _pairs(namedParams.listitem)) {
            let [item, required] = RequireValue(listitem);
            const control = Ovale.list[name] || { items: {}, default: undefined };
            control.triggerEvaluation = true;
            Ovale.list[name] = control;
            let isSelected = (profile.list[name] == item);
            boolean = (required && isSelected) || (!required && !isSelected);
            if (!boolean) {
                break;
            }
        }
    }
    OvaleCompile.StopProfiling("OvaleCompile_TestConditions");
    return boolean;
}
const EvaluateAddCheckBox = function(node) {
    let ok = true;
    let [name, positionalParams, namedParams] = [node.name, node.positionalParams, node.namedParams];
    if (TestConditions(positionalParams, namedParams)) {
        let checkBox = Ovale.checkBox[name]
        if (!checkBox) {
            self_serial = self_serial + 1;
            OvaleCompile.Debug("New checkbox '%s': advance age to %d.", name, self_serial);
        }
        checkBox = checkBox || {
        }
        checkBox.text = node.description.value;
        for (const [_, v] of _ipairs(positionalParams)) {
            if (v == "default") {
                checkBox.checked = true;
                break;
            }
        }
        Ovale.checkBox[name] = checkBox;
    }
    return ok;
}
const EvaluateAddIcon = function(node) {
    let ok = true;
    let [positionalParams, namedParams] = [node.positionalParams, node.namedParams];
    if (TestConditions(positionalParams, namedParams)) {
        self_icon[lualength(self_icon) + 1] = node;
    }
    return ok;
}
const EvaluateAddListItem = function(node) {
    let ok = true;
    let [name, item, positionalParams, namedParams] = [node.name, node.item, node.positionalParams, node.namedParams];
    if (TestConditions(positionalParams, namedParams)) {
        let list = Ovale.list[name]
        if (!(list && list.items && list.items[item])) {
            self_serial = self_serial + 1;
            OvaleCompile.Debug("New list '%s': advance age to %d.", name, self_serial);
        }
        list = list || {
            items: {
            },
            default: undefined
        }
        list.items[item] = node.description.value;
        for (const [_, v] of _ipairs(positionalParams)) {
            if (v == "default") {
                list.default = item;
                break;
            }
        }
        Ovale.list[name] = list;
    }
    return ok;
}
const EvaluateItemInfo = function(node) {
    let ok = true;
    let [itemId, positionalParams, namedParams] = [node.itemId, node.positionalParams, node.namedParams];
    if (itemId && TestConditions(positionalParams, namedParams)) {
        let ii = OvaleData.ItemInfo(itemId);
        for (const [k, v] of _pairs(namedParams)) {
            if (k == "proc") {
                let buff = _tonumber(namedParams.buff);
                if (buff) {
                    let name = "item_proc_" + namedParams.proc;
                    let list = OvaleData.buffSpellList[name] || {
                    }
                    list[buff] = true;
                    OvaleData.buffSpellList[name] = list;
                } else {
                    ok = false;
                    break;
                }
            } else if (!OvaleAST.PARAMETER_KEYWORD[k]) {
                ii[k] = v;
            }
        }
        OvaleData.itemInfo[itemId] = ii;
    }
    return ok;
}
const EvaluateItemRequire = function(node) {
    let ok = true;
    let [itemId, positionalParams, namedParams] = [node.itemId, node.positionalParams, node.namedParams];
    if (TestConditions(positionalParams, namedParams)) {
        let property = node.property;
        let count = 0;
        let ii = OvaleData.ItemInfo(itemId);
        let tbl = ii.require[property] || {
        }
        for (const [k, v] of _pairs(namedParams)) {
            if (!OvaleAST.PARAMETER_KEYWORD[k]) {
                tbl[k] = v;
                count = count + 1;
            }
        }
        if (count > 0) {
            ii.require[property] = tbl;
        }
    }
    return ok;
}
const EvaluateList = function(node) {
    let ok = true;
    let [name, positionalParams, namedParams] = [node.name, node.positionalParams, node.namedParams];
    let listDB;
    if (node.keyword == "ItemList") {
        listDB = "itemList";
    } else {
        listDB = "buffSpellList";
    }
    let list = OvaleData[listDB][name] || {
    }
    for (const [_, _id] of _pairs(positionalParams)) {
        let id = _tonumber(_id);
        if (id) {
            list[id] = true;
        } else {
            ok = false;
            break;
        }
    }
    OvaleData[listDB][name] = list;
    return ok;
}
const EvaluateScoreSpells = function(node) {
    let ok = true;
    let [positionalParams, namedParams] = [node.positionalParams, node.namedParams];
    for (const [_, _spellId] of _ipairs(positionalParams)) {
        let spellId = _tonumber(_spellId);
        if (spellId) {
            OvaleScore.AddSpell(_tonumber(spellId));
        } else {
            ok = false;
            break;
        }
    }
    return ok;
}
const EvaluateSpellAuraList = function(node) {
    let ok = true;
    let [spellId, positionalParams, namedParams] = [node.spellId, node.positionalParams, node.namedParams];
    if (!spellId) {
        OvaleCompile.Print("No spellId for name %s", node.name);
        return false;
    }
    if (TestConditions(positionalParams, namedParams)) {
        let keyword = node.keyword;
        let si = OvaleData.SpellInfo(spellId);
        let auraTable;
        if (strfind(keyword, "^SpellDamage")) {
            auraTable = si.aura.damage;
        } else if (strfind(keyword, "^SpellAddPet")) {
            auraTable = si.aura.pet;
        } else if (strfind(keyword, "^SpellAddTarget")) {
            auraTable = si.aura.target;
        } else {
            auraTable = si.aura.player;
        }
        let filter = strfind(node.keyword, "Debuff") && "HARMFUL" || "HELPFUL";
        let tbl = auraTable[filter] || {
        }
        let count = 0;
        for (const [k, v] of _pairs(namedParams)) {
            if (!OvaleAST.PARAMETER_KEYWORD[k]) {
                tbl[k] = v;
                count = count + 1;
            }
        }
        if (count > 0) {
            auraTable[filter] = tbl;
        }
    }
    return ok;
}
const EvaluateSpellInfo = function(node) {
    let addpower = {
    }
    for (const [powertype, _] of _pairs(OvalePower.POWER_INFO)) {
        let key = "add" + powertype;
        addpower[key] = powertype;
    }
    let ok = true;
    let [spellId, positionalParams, namedParams] = [node.spellId, node.positionalParams, node.namedParams];
    if (spellId && TestConditions(positionalParams, namedParams)) {
        let si = OvaleData.SpellInfo(spellId);
        for (const [k, v] of _pairs(namedParams)) {
            if (k == "addduration") {
                let value = _tonumber(v);
                if (value) {
                    let realValue = value;
                    if (namedParams.pertrait != undefined) {
                        realValue = value * OvaleArtifact.TraitRank(namedParams.pertrait);
                    }
                    let addDuration = si.addduration || 0;
                    si.addduration = addDuration + realValue;
                } else {
                    ok = false;
                    break;
                }
            } else if (k == "addcd") {
                let value = _tonumber(v);
                if (value) {
                    let addCd = si.addcd || 0;
                    si.addcd = addCd + value;
                } else {
                    ok = false;
                    break;
                }
            } else if (k == "addlist") {
                let list = OvaleData.buffSpellList[v] || {
                }
                list[spellId] = true;
                OvaleData.buffSpellList[v] = list;
            } else if (k == "dummy_replace") {
                let spellName = API_GetSpellInfo(v) || v;
                OvaleSpellBook.AddSpell(spellId, spellName);
            } else if (k == "learn" && v == 1) {
                let spellName = API_GetSpellInfo(spellId);
                OvaleSpellBook.AddSpell(spellId, spellName);
            } else if (k == "sharedcd") {
                si[k] = v;
                OvaleCooldown.AddSharedCooldown(v, spellId);
            } else if (addpower[k] != undefined) {
                let powertype = addpower[k];
                let value = _tonumber(v);
                if (value) {
                    let realValue = value;
                    if (namedParams.pertrait != undefined) {
                        realValue = value * OvaleArtifact.TraitRank(namedParams.pertrait);
                    }
                    let power = si[k] || 0;
                    si[k] = power + realValue;
                } else {
                    ok = false;
                    break;
                }
            } else if (!OvaleAST.PARAMETER_KEYWORD[k]) {
                si[k] = v;
            }
        }
    }
    return ok;
}
const EvaluateSpellRequire = function(node) {
    let ok = true;
    let [spellId, positionalParams, namedParams] = [node.spellId, node.positionalParams, node.namedParams];
    if (TestConditions(positionalParams, namedParams)) {
        let property = node.property;
        let count = 0;
        let si = OvaleData.SpellInfo(spellId);
        let tbl = si.require[property] || {
        }
        for (const [k, v] of _pairs(namedParams)) {
            if (!OvaleAST.PARAMETER_KEYWORD[k]) {
                tbl[k] = v;
                count = count + 1;
            }
        }
        if (count > 0) {
            si.require[property] = tbl;
        }
    }
    return ok;
}
const AddMissingVariantSpells = function(annotation) {
    if (annotation.functionReference) {
        for (const [_, node] of _ipairs<Node>(annotation.functionReference)) {
            let [positionalParams, namedParams] = [node.positionalParams, node.namedParams];
            let spellId = positionalParams[1];
            if (spellId && OvaleCondition.IsSpellBookCondition(node.func)) {
                if (!OvaleSpellBook.IsKnownSpell(spellId) && !OvaleCooldown.IsSharedCooldown(spellId)) {
                    let spellName;
                    if (_type(spellId) == "number") {
                        spellName = OvaleSpellBook.GetSpellName(spellId);
                    }
                    if (spellName) {
                        let name = API_GetSpellInfo(spellName);
                        if (spellName == name) {
                            OvaleCompile.Debug("Learning spell %s with ID %d.", spellName, spellId);
                            OvaleSpellBook.AddSpell(spellId, spellName);
                        }
                    } else {
                        let functionCall = node.name;
                        if (node.paramsAsString) {
                            functionCall = node.name + "(" + node.paramsAsString + ")";
                        }
                        OvaleCompile.Print("Unknown spell with ID %s used in %s.", spellId, functionCall);
                    }
                }
            }
        }
    }
}
const AddToBuffList = function(buffId, statName?, isStacking?) {
    if (statName) {
        for (const [_, useName] of _pairs(OvaleData.STAT_USE_NAMES)) {
            if (isStacking || !strfind(useName, "_stacking_")) {
                let name = useName + "_" + statName + "_buff";
                let list = OvaleData.buffSpellList[name] || {
                }
                list[buffId] = true;
                OvaleData.buffSpellList[name] = list;
                let shortStatName = OvaleData.STAT_SHORTNAME[statName];
                if (shortStatName) {
                    name = useName + "_" + shortStatName + "_buff";
                    list = OvaleData.buffSpellList[name] || {
                    }
                    list[buffId] = true;
                    OvaleData.buffSpellList[name] = list;
                }
                name = useName + "_any_buff";
                list = OvaleData.buffSpellList[name] || {
                }
                list[buffId] = true;
                OvaleData.buffSpellList[name] = list;
            }
        }
    } else {
        let si = OvaleData.spellInfo[buffId];
        isStacking = si && (si.stacking == 1 || si.max_stacks);
        if (si && si.stat) {
            let stat = si.stat;
            if (_type(stat) == "table") {
                for (const [_, name] of _ipairs(stat)) {
                    AddToBuffList(buffId, name, isStacking);
                }
            } else {
                AddToBuffList(buffId, stat, isStacking);
            }
        }
    }
}
let UpdateTrinketInfo = undefined;
{
    let trinket = {
    }
    UpdateTrinketInfo = function () {
        [trinket[1], trinket[2]] = OvaleEquipment.GetEquippedTrinkets();
        for (let i = 1; i <= 2; i += 1) {
            let itemId = trinket[i];
            let ii = itemId && OvaleData.ItemInfo(itemId);
            let buffId = ii && ii.buff;
            if (buffId) {
                if (_type(buffId) == "table") {
                    for (const [_, id] of _ipairs(buffId)) {
                        AddToBuffList(id);
                    }
                } else {
                    AddToBuffList(buffId);
                }
            }
        }
    }
}

class OvaleCompileClass extends RegisterPrinter(OvaleDebug.RegisterDebugging(OvaleProfiler.RegisterProfiling(OvaleCompileBase))) {
    serial = undefined;
    ast = undefined;
        
    OnInitialize() {
    }
    OnEnable() {
        this.RegisterMessage("Ovale_CheckBoxValueChanged", "ScriptControlChanged");
        this.RegisterMessage("Ovale_EquipmentChanged", "EventHandler");
        this.RegisterMessage("Ovale_ListValueChanged", "ScriptControlChanged");
        this.RegisterMessage("Ovale_ScriptChanged");
        this.RegisterMessage("Ovale_SpecializationChanged", "Ovale_ScriptChanged");
        this.RegisterMessage("Ovale_SpellsChanged", "EventHandler");
        this.RegisterMessage("Ovale_StanceChanged");
        this.RegisterMessage("Ovale_TalentsChanged", "EventHandler");
        this.SendMessage("Ovale_ScriptChanged");
    }
    OnDisable() {
        this.UnregisterMessage("Ovale_CheckBoxValueChanged");
        this.UnregisterMessage("Ovale_EquipmentChanged");
        this.UnregisterMessage("Ovale_ListValueChanged");
        this.UnregisterMessage("Ovale_ScriptChanged");
        this.UnregisterMessage("Ovale_SpecializationChanged");
        this.UnregisterMessage("Ovale_SpellsChanged");
        this.UnregisterMessage("Ovale_StanceChanged");
        this.UnregisterMessage("Ovale_TalentsChanged");
    }
    Ovale_ScriptChanged(event) {
        this.CompileScript(Ovale.db.profile.source);
        this.EventHandler(event);
    }
    Ovale_StanceChanged(event) {
        if (self_compileOnStances) {
            this.EventHandler(event);
        }
    }
    ScriptControlChanged(event, name) {
        if (!name) {
            this.EventHandler(event);
        } else {
            let control;
            if (event == "Ovale_CheckBoxValueChanged") {
                control = Ovale.checkBox[name];
            } else if (event == "Ovale_ListValueChanged") {
                control = Ovale.list[name];
            }
            if (control && control.triggerEvaluation) {
                this.EventHandler(event);
            }
        }
    }
    EventHandler(event) {
        self_serial = self_serial + 1;
        this.Debug("%s: advance age to %d.", event, self_serial);
        Ovale.refreshNeeded[Ovale.playerGUID] = true;
    }
    CompileScript(name) {
        OvaleDebug.ResetTrace();
        this.Debug("Compiling script '%s'.", name);
        if (this.ast) {
            OvaleAST.Release(this.ast);
            this.ast = undefined;
        }
        this.ast = OvaleAST.ParseScript(name);
        Ovale.ResetControls();
    }
    EvaluateScript(ast?, forceEvaluation?) {
        this.StartProfiling("OvaleCompile_EvaluateScript");
        if (_type(ast) != "table") {
            forceEvaluation = ast;
            ast = this.ast;
        }
        let changed = false;
        self_canEvaluate = self_canEvaluate || Ovale.IsPreloaded(self_requirePreload);
        if (self_canEvaluate && ast && (forceEvaluation || !this.serial || this.serial < self_serial)) {
            this.Debug("Evaluating script.");
            changed = true;
            let ok = true;
            self_compileOnStances = false;
            _wipe(self_icon);
            OvaleData.Reset();
            OvaleCooldown.ResetSharedCooldowns();
            self_timesEvaluated = self_timesEvaluated + 1;
            this.serial = self_serial;
            for (const [_, node] of _ipairs<Node>(ast.child)) {
                let nodeType = node.type;
                if (nodeType == "checkbox") {
                    ok = EvaluateAddCheckBox(node);
                } else if (nodeType == "icon") {
                    ok = EvaluateAddIcon(node);
                } else if (nodeType == "list_item") {
                    ok = EvaluateAddListItem(node);
                } else if (nodeType == "item_info") {
                    ok = EvaluateItemInfo(node);
                } else if (nodeType == "item_require") {
                    ok = EvaluateItemRequire(node);
                } else if (nodeType == "list") {
                    ok = EvaluateList(node);
                } else if (nodeType == "score_spells") {
                    ok = EvaluateScoreSpells(node);
                } else if (nodeType == "spell_aura_list") {
                    ok = EvaluateSpellAuraList(node);
                } else if (nodeType == "spell_info") {
                    ok = EvaluateSpellInfo(node);
                } else if (nodeType == "spell_require") {
                    ok = EvaluateSpellRequire(node);
                } else {
                }
                if (!ok) {
                    break;
                }
            }
            if (ok) {
                AddMissingVariantSpells(ast.annotation);
                UpdateTrinketInfo();
            }
        }
        this.StopProfiling("OvaleCompile_EvaluateScript");
        return changed;
    }
    GetFunctionNode(name) {
        let node;
        if (this.ast && this.ast.annotation && this.ast.annotation.customFunction) {
            node = this.ast.annotation.customFunction[name];
        }
        return node;
    }
    GetIconNodes() {
        return self_icon;
    }
    DebugCompile() {
        this.Print("Total number of times the script was evaluated: %d", self_timesEvaluated);
    }
}

OvaleCompile = new OvaleCompileClass();