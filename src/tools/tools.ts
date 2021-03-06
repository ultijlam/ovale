import {
    type,
    LuaArray,
    LuaObj,
    pairs,
    strjoin,
    tostring,
    tostringall,
    truthy,
    wipe,
    select,
    kpairs,
    ipairs,
} from "@wowts/lua";
import { len, find, format, gsub } from "@wowts/string";
import { DEFAULT_CHAT_FRAME, UIFrame } from "@wowts/wow-mock";

export function isString(s: unknown): s is string {
    return type(s) === "string";
}

export function isNumber(s: unknown): s is number {
    return type(s) === "number";
}

export function isBoolean(s: unknown): s is number {
    return type(s) === "boolean";
}

export function isLuaArray<T>(a: unknown): a is LuaArray<T> {
    return type(a) === "table";
}

export type KeyCheck<T extends string> = { [K in T]: boolean };

export type TypeCheck<T> = { [K in keyof Required<T>]: boolean };
export function checkToken<T extends string>(
    type: KeyCheck<T>,
    token: unknown
): token is T {
    return type[<T>token];
}

export const oneTimeMessages: LuaObj<boolean | "printed"> = {};

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function makeString(s?: string, ...parameters: any[]) {
    if (s && len(s) > 0) {
        if (truthy(parameters) && select("#", parameters) > 0) {
            if (truthy(find(s, "%%%.%d")) || truthy(find(s, "%%[%w]"))) {
                s = format(s, ...tostringall(...parameters));
            } else {
                s = strjoin(" ", s, ...tostringall(...parameters));
            }
        } else {
            return s;
        }
    } else {
        s = tostring(undefined);
    }
    return s;
}

export function printFormat(pattern: string, ...parameters: unknown[]) {
    const s = makeString(pattern, ...parameters);
    DEFAULT_CHAT_FRAME.AddMessage(format("|cff33ff99Ovale|r: %s", s));
}

export function oneTimeMessage(pattern: string, ...parameters: unknown[]) {
    const s = makeString(pattern, ...parameters);
    if (!oneTimeMessages[s]) {
        oneTimeMessages[s] = true;
    }
}

export function clearOneTimeMessages() {
    wipe(oneTimeMessages);
}

export function printOneTimeMessages() {
    for (const [s] of pairs(oneTimeMessages)) {
        if (oneTimeMessages[s] != "printed") {
            printFormat(s);
            oneTimeMessages[s] = "printed";
        }
    }
}

export type AceEventHandler<E> = E extends (
    x: UIFrame,
    ...args: infer P
) => infer R
    ? (...args: P) => R
    : never;

export function stringify(obj: any) {
    if (obj === undefined) return "null";

    if (isString(obj)) {
        return `"${gsub(obj, '"', '\\"')}"`;
    }
    if (isNumber(obj)) {
        return tostring(obj);
    }
    if (isBoolean(obj)) {
        return (obj && "true") || "false";
    }
    if (obj[1]) {
        let firstItem = true;
        let serialized = "[";
        for (const [, item] of ipairs(obj)) {
            if (firstItem) firstItem = false;
            else serialized += ",";
            serialized += stringify(item);
        }
        serialized += "]";
        return serialized;
    }
    let serialized = "{";
    let firstProp = true;
    for (const [k, v] of kpairs(obj)) {
        if (v !== undefined) {
            if (firstProp) firstProp = false;
            else serialized += ",";
            serialized += `"${k as string}": `;
            serialized += stringify(v);
        }
    }
    serialized += "}";
    return serialized;
}
