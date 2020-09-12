local __exports = LibStub:NewLibrary("ovale/scripts/ovale_druid", 80300)
if not __exports then return end
__exports.registerDruid = function(OvaleScripts)
    do
        local name = "sc_t25_druid_balance"
        local desc = "[9.0] Simulationcraft: T25_Druid_Balance"
        local code = [[
# Based on SimulationCraft profile "T25_Druid_Balance".
#	class=druid
#	spec=balance
#	talents=1000231

Include(ovale_common)
Include(ovale_druid_spells)

AddCheckBox(opt_interrupt l(interrupt) default specialization=balance)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=balance)

AddFunction balanceinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(solar_beam) and target.isinterruptible() spell(solar_beam)
  if target.inrange(mighty_bash) and not target.classification(worldboss) spell(mighty_bash)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
  if target.distance(less 15) and not target.classification(worldboss) spell(typhoon)
 }
}

### actions.precombat

AddFunction balanceprecombatmainactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #moonkin_form
 spell(moonkin_form)
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(disabled_item usable=1)
}

AddFunction balanceprecombatmainpostconditions
{
}

AddFunction balanceprecombatshortcdactions
{
}

AddFunction balanceprecombatshortcdpostconditions
{
 spell(moonkin_form) or checkboxon(opt_use_consumables) and target.classification(worldboss) and item(disabled_item usable=1)
}

AddFunction balanceprecombatcdactions
{
}

AddFunction balanceprecombatcdpostconditions
{
 spell(moonkin_form) or checkboxon(opt_use_consumables) and target.classification(worldboss) and item(disabled_item usable=1)
}

### actions.default

AddFunction balance_defaultmainactions
{
 #wrath
 spell(wrath)
}

AddFunction balance_defaultmainpostconditions
{
}

AddFunction balance_defaultshortcdactions
{
}

AddFunction balance_defaultshortcdpostconditions
{
 spell(wrath)
}

AddFunction balance_defaultcdactions
{
 balanceinterruptactions()
}

AddFunction balance_defaultcdpostconditions
{
 spell(wrath)
}

### Balance icons.

AddCheckBox(opt_druid_balance_aoe l(aoe) default specialization=balance)

AddIcon checkbox=!opt_druid_balance_aoe enemies=1 help=shortcd specialization=balance
{
 if not incombat() balanceprecombatshortcdactions()
 balance_defaultshortcdactions()
}

AddIcon checkbox=opt_druid_balance_aoe help=shortcd specialization=balance
{
 if not incombat() balanceprecombatshortcdactions()
 balance_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=balance
{
 if not incombat() balanceprecombatmainactions()
 balance_defaultmainactions()
}

AddIcon checkbox=opt_druid_balance_aoe help=aoe specialization=balance
{
 if not incombat() balanceprecombatmainactions()
 balance_defaultmainactions()
}

AddIcon checkbox=!opt_druid_balance_aoe enemies=1 help=cd specialization=balance
{
 if not incombat() balanceprecombatcdactions()
 balance_defaultcdactions()
}

AddIcon checkbox=opt_druid_balance_aoe help=cd specialization=balance
{
 if not incombat() balanceprecombatcdactions()
 balance_defaultcdactions()
}

### Required symbols
# disabled_item
# mighty_bash
# moonkin_form
# solar_beam
# typhoon
# war_stomp
# wrath
]]
        OvaleScripts:RegisterScript("DRUID", "balance", name, desc, code, "script")
    end
    do
        local name = "sc_t25_druid_feral"
        local desc = "[9.0] Simulationcraft: T25_Druid_Feral"
        local code = [[
# Based on SimulationCraft profile "T25_Druid_Feral".
#	class=druid
#	spec=feral
#	talents=2331122

Include(ovale_common)
Include(ovale_druid_spells)

AddCheckBox(opt_interrupt l(interrupt) default specialization=feral)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=feral)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=feral)

AddFunction feralinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(skull_bash) and target.isinterruptible() spell(skull_bash)
  if target.inrange(mighty_bash) and not target.classification(worldboss) spell(mighty_bash)
  if target.inrange(maim) and not target.classification(worldboss) spell(maim)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
  if target.distance(less 15) and not target.classification(worldboss) spell(typhoon)
 }
}

AddFunction feralgetinmeleerange
{
 if checkboxon(opt_melee_range) and stance(druid_bear_form) and not target.inrange(mangle) or { stance(druid_cat_form) or stance(druid_claws_of_shirvallah) } and not target.inrange(shred)
 {
  if target.inrange(wild_charge) spell(wild_charge)
  texture(misc_arrowlup help=l(not_in_melee_range))
 }
}

### actions.precombat

AddFunction feralprecombatmainactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #cat_form
 spell(cat_form)
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(disabled_item usable=1)
}

AddFunction feralprecombatmainpostconditions
{
}

AddFunction feralprecombatshortcdactions
{
}

AddFunction feralprecombatshortcdpostconditions
{
 spell(cat_form) or checkboxon(opt_use_consumables) and target.classification(worldboss) and item(disabled_item usable=1)
}

AddFunction feralprecombatcdactions
{
}

AddFunction feralprecombatcdpostconditions
{
 spell(cat_form) or checkboxon(opt_use_consumables) and target.classification(worldboss) and item(disabled_item usable=1)
}

### actions.default

AddFunction feral_defaultmainactions
{
 #shred
 spell(shred)
}

AddFunction feral_defaultmainpostconditions
{
}

AddFunction feral_defaultshortcdactions
{
 #auto_attack
 feralgetinmeleerange()
}

AddFunction feral_defaultshortcdpostconditions
{
 spell(shred)
}

AddFunction feral_defaultcdactions
{
 feralinterruptactions()
}

AddFunction feral_defaultcdpostconditions
{
 spell(shred)
}

### Feral icons.

AddCheckBox(opt_druid_feral_aoe l(aoe) default specialization=feral)

AddIcon checkbox=!opt_druid_feral_aoe enemies=1 help=shortcd specialization=feral
{
 if not incombat() feralprecombatshortcdactions()
 feral_defaultshortcdactions()
}

AddIcon checkbox=opt_druid_feral_aoe help=shortcd specialization=feral
{
 if not incombat() feralprecombatshortcdactions()
 feral_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=feral
{
 if not incombat() feralprecombatmainactions()
 feral_defaultmainactions()
}

AddIcon checkbox=opt_druid_feral_aoe help=aoe specialization=feral
{
 if not incombat() feralprecombatmainactions()
 feral_defaultmainactions()
}

AddIcon checkbox=!opt_druid_feral_aoe enemies=1 help=cd specialization=feral
{
 if not incombat() feralprecombatcdactions()
 feral_defaultcdactions()
}

AddIcon checkbox=opt_druid_feral_aoe help=cd specialization=feral
{
 if not incombat() feralprecombatcdactions()
 feral_defaultcdactions()
}

### Required symbols
# cat_form
# disabled_item
# maim
# mangle
# mighty_bash
# shred
# skull_bash
# typhoon
# war_stomp
# wild_charge
# wild_charge_bear
# wild_charge_cat
]]
        OvaleScripts:RegisterScript("DRUID", "feral", name, desc, code, "script")
    end
    do
        local name = "sc_t25_druid_guardian"
        local desc = "[9.0] Simulationcraft: T25_Druid_Guardian"
        local code = [[
# Based on SimulationCraft profile "T25_Druid_Guardian".
#	class=druid
#	spec=guardian
#	talents=1000131

Include(ovale_common)
Include(ovale_druid_spells)

AddCheckBox(opt_interrupt l(interrupt) default specialization=guardian)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=guardian)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=guardian)

AddFunction guardianinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(skull_bash) and target.isinterruptible() spell(skull_bash)
  if target.inrange(mighty_bash) and not target.classification(worldboss) spell(mighty_bash)
  if target.distance(less 10) and not target.classification(worldboss) spell(incapacitating_roar)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
  if target.distance(less 15) and not target.classification(worldboss) spell(typhoon)
 }
}

AddFunction guardiangetinmeleerange
{
 if checkboxon(opt_melee_range) and stance(druid_bear_form) and not target.inrange(mangle) or { stance(druid_cat_form) or stance(druid_claws_of_shirvallah) } and not target.inrange(shred)
 {
  if target.inrange(wild_charge) spell(wild_charge)
  texture(misc_arrowlup help=l(not_in_melee_range))
 }
}

### actions.precombat

AddFunction guardianprecombatmainactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #bear_form
 spell(bear_form)
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(disabled_item usable=1)
}

AddFunction guardianprecombatmainpostconditions
{
}

AddFunction guardianprecombatshortcdactions
{
}

AddFunction guardianprecombatshortcdpostconditions
{
 spell(bear_form) or checkboxon(opt_use_consumables) and target.classification(worldboss) and item(disabled_item usable=1)
}

AddFunction guardianprecombatcdactions
{
}

AddFunction guardianprecombatcdpostconditions
{
 spell(bear_form) or checkboxon(opt_use_consumables) and target.classification(worldboss) and item(disabled_item usable=1)
}

### actions.default

AddFunction guardian_defaultmainactions
{
 #swipe
 spell(swipe)
}

AddFunction guardian_defaultmainpostconditions
{
}

AddFunction guardian_defaultshortcdactions
{
 #auto_attack
 guardiangetinmeleerange()
}

AddFunction guardian_defaultshortcdpostconditions
{
 spell(swipe)
}

AddFunction guardian_defaultcdactions
{
 guardianinterruptactions()
}

AddFunction guardian_defaultcdpostconditions
{
 spell(swipe)
}

### Guardian icons.

AddCheckBox(opt_druid_guardian_aoe l(aoe) default specialization=guardian)

AddIcon checkbox=!opt_druid_guardian_aoe enemies=1 help=shortcd specialization=guardian
{
 if not incombat() guardianprecombatshortcdactions()
 guardian_defaultshortcdactions()
}

AddIcon checkbox=opt_druid_guardian_aoe help=shortcd specialization=guardian
{
 if not incombat() guardianprecombatshortcdactions()
 guardian_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=guardian
{
 if not incombat() guardianprecombatmainactions()
 guardian_defaultmainactions()
}

AddIcon checkbox=opt_druid_guardian_aoe help=aoe specialization=guardian
{
 if not incombat() guardianprecombatmainactions()
 guardian_defaultmainactions()
}

AddIcon checkbox=!opt_druid_guardian_aoe enemies=1 help=cd specialization=guardian
{
 if not incombat() guardianprecombatcdactions()
 guardian_defaultcdactions()
}

AddIcon checkbox=opt_druid_guardian_aoe help=cd specialization=guardian
{
 if not incombat() guardianprecombatcdactions()
 guardian_defaultcdactions()
}

### Required symbols
# bear_form
# disabled_item
# incapacitating_roar
# mangle
# mighty_bash
# shred
# skull_bash
# swipe
# typhoon
# war_stomp
# wild_charge
# wild_charge_bear
# wild_charge_cat
]]
        OvaleScripts:RegisterScript("DRUID", "guardian", name, desc, code, "script")
    end
end
