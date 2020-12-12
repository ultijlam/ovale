import { GetLocale } from "@wowts/wow-mock";
import { setDEDE } from "./localization/de-DE";
import { getENUS } from "./localization/en-US";
import { setESES } from "./localization/es-ES";
import { setESMX } from "./localization/es-MX";
import { setFRFR } from "./localization/fr-FR";
import { setITIT } from "./localization/it-IT";
import { setKOKR } from "./localization/ko-KR";
import { setPTBR } from "./localization/pt-BR";
import { setRURU } from "./localization/ru-RU";
import { setZHCN } from "./localization/zh-CN";
import { setZHTW } from "./localization/zh-TW";

export const L = getENUS();

const locale = GetLocale();
if (locale == "deDE") {
    setDEDE(L);
} else if (locale == "esES") {
    setESES(L);
} else if (locale == "esMX") {
    setESMX(L);
} else if (locale == "frFR") {
    setFRFR(L);
} else if (locale == "itIT") {
    setITIT(L);
} else if (locale == "koKR") {
    setKOKR(L);
} else if (locale == "ptBR") {
    setPTBR(L);
} else if (locale == "ruRU") {
    setRURU(L);
} else if (locale == "zhCN") {
    setZHCN(L);
} else if (locale == "zhTW") {
    setZHTW(L);
}
