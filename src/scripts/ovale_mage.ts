import { OvaleScriptsClass } from "../Scripts";

export function registerMage(OvaleScripts: OvaleScriptsClass) {
// THE REST OF THIS FILE IS AUTOMATICALLY GENERATED
// ANY CHANGES MADE BELOW THIS POINT WILL BE LOST

{
	const name = "sc_t25_mage_arcane"
	const desc = "[9.0] Simulationcraft: T25_Mage_Arcane"
	const code = `
# Based on SimulationCraft profile "T25_Mage_Arcane".
#	class=mage
#	spec=arcane
#	talents=2032021

Include(ovale_common)
Include(ovale_mage_spells)
### Arcane icons.

AddCheckBox(opt_mage_arcane_aoe l(aoe) default specialization=arcane)
`
	OvaleScripts.RegisterScript("MAGE", "arcane", name, desc, code, "script")
}

{
	const name = "sc_t25_mage_fire"
	const desc = "[9.0] Simulationcraft: T25_Mage_Fire"
	const code = `
# Based on SimulationCraft profile "T25_Mage_Fire".
#	class=mage
#	spec=fire
#	talents=3031022

Include(ovale_common)
Include(ovale_mage_spells)
### Fire icons.

AddCheckBox(opt_mage_fire_aoe l(aoe) default specialization=fire)
`
	OvaleScripts.RegisterScript("MAGE", "fire", name, desc, code, "script")
}

{
	const name = "sc_t25_mage_frost"
	const desc = "[9.0] Simulationcraft: T25_Mage_Frost"
	const code = `
# Based on SimulationCraft profile "T25_Mage_Frost".
#	class=mage
#	spec=frost
#	talents=1011023

Include(ovale_common)
Include(ovale_mage_spells)
### Frost icons.

AddCheckBox(opt_mage_frost_aoe l(aoe) default specialization=frost)
`
	OvaleScripts.RegisterScript("MAGE", "frost", name, desc, code, "script")
}

}