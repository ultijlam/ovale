local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts
do
    local name = "sc_pr_druid_balance"
    local desc = "[8.1] Simulationcraft: PR_Druid_Balance"
    local code = [[
# Based on SimulationCraft profile "PR_Druid_Balance".
#	class=druid
#	spec=balance
#	talents=2000231

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_druid_spells)


AddFunction sf_targets
{
 5
}

AddFunction az_ap
{
 AzeriteTraitRank(arcanic_pulsar_trait)
}

AddFunction az_ss
{
 AzeriteTraitRank(streaking_stars_trait)
}

AddCheckBox(opt_interrupt L(interrupt) default specialization=balance)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=balance)

AddFunction BalanceInterruptActions
{
 if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
 {
  if target.InRange(solar_beam) and target.IsInterruptible() Spell(solar_beam)
  if target.InRange(mighty_bash) and not target.Classification(worldboss) Spell(mighty_bash)
  if target.Distance(less 5) and not target.Classification(worldboss) Spell(war_stomp)
  if target.Distance(less 15) and not target.Classification(worldboss) Spell(typhoon)
 }
}

AddFunction BalanceUseItemActions
{
 Item(Trinket0Slot text=13 usable=1)
 Item(Trinket1Slot text=14 usable=1)
}

### actions.precombat

AddFunction BalancePrecombatMainActions
{
 #flask
 #food
 #augmentation
 #variable,name=az_ss,value=azerite.streaking_stars.rank
 #variable,name=az_ap,value=azerite.arcanic_pulsar.rank
 #variable,name=sf_targets,value=5
 #variable,name=sf_targets,op=sub,value=1,if=talent.stellar_drift.enabled|(talent.incarnation.enabled&talent.twin_moons.enabled&!azerite.arcanic_pulsar.enabled)
 #variable,name=sf_targets,op=sub,value=1,if=!azerite.arcanic_pulsar.enabled&!talent.starlord.enabled
 #moonkin_form
 Spell(moonkin_form_balance)
 #solar_wrath
 Spell(solar_wrath_balance)
}

AddFunction BalancePrecombatMainPostConditions
{
}

AddFunction BalancePrecombatShortCdActions
{
}

AddFunction BalancePrecombatShortCdPostConditions
{
 Spell(moonkin_form_balance) or Spell(solar_wrath_balance)
}

AddFunction BalancePrecombatCdActions
{
 unless Spell(moonkin_form_balance)
 {
  #snapshot_stats
  #potion
  if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(rising_death usable=1)
 }
}

AddFunction BalancePrecombatCdPostConditions
{
 Spell(moonkin_form_balance) or Spell(solar_wrath_balance)
}

### actions.default

AddFunction BalanceDefaultMainActions
{
 #cancel_buff,name=starlord,if=buff.starlord.remains<8&astral_power>87
 if BuffRemaining(starlord_buff) < 8 and AstralPower() > 87 and BuffPresent(starlord_buff) Texture(starlord text=cancel)
 #starfall,if=(buff.starlord.stack<3|buff.starlord.remains>=8)&spell_targets>=variable.sf_targets&(target.time_to_die+1)*spell_targets>cost%2.5
 if { BuffStacks(starlord_buff) < 3 or BuffRemaining(starlord_buff) >= 8 } and Enemies() >= sf_targets() and { target.TimeToDie() + 1 } * Enemies() > PowerCost(starfall) / 2.5 Spell(starfall)
 #starsurge,if=(buff.starlord.stack<3|buff.starlord.remains>=8)&spell_targets.starfall<variable.sf_targets&buff.lunar_empowerment.stack+buff.solar_empowerment.stack<4&buff.solar_empowerment.stack<3&buff.lunar_empowerment.stack<3&(!variable.az_ss|!buff.ca_inc.up|!prev.starsurge)|target.time_to_die<=execute_time*astral_power%40
 if { BuffStacks(starlord_buff) < 3 or BuffRemaining(starlord_buff) >= 8 } and Enemies() < sf_targets() and BuffStacks(lunar_empowerment_buff) + BuffStacks(solar_empowerment_buff) < 4 and BuffStacks(solar_empowerment_buff) < 3 and BuffStacks(lunar_empowerment_buff) < 3 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(starsurge_balance) } or target.TimeToDie() <= ExecuteTime(starsurge_balance) * AstralPower() / 40 Spell(starsurge_balance)
 #sunfire,target_if=refreshable,if=astral_power.deficit>=8&floor(target.time_to_die%tick_time)*spell_targets>=5&(spell_targets>1+talent.twin_moons.enabled|dot.moonfire.ticking)&(!variable.az_ss|!buff.ca_inc.up|!prev.sunfire)
 if target.Refreshable(sunfire_debuff) and AstralPowerDeficit() >= 8 and target.TimeToDie() / target.CurrentTickTime(sunfire_debuff) * Enemies() >= 5 and { Enemies() > 1 + TalentPoints(twin_moons_talent) or target.DebuffPresent(moonfire_debuff) } and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(sunfire) } Spell(sunfire)
 #moonfire,target_if=refreshable,if=astral_power.deficit>=8&floor(target.time_to_die%tick_time)*spell_targets>=5&(!variable.az_ss|!buff.ca_inc.up|!prev.moonfire)
 if target.Refreshable(moonfire_debuff) and AstralPowerDeficit() >= 8 and target.TimeToDie() / target.CurrentTickTime(moonfire_debuff) * Enemies() >= 5 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(moonfire) } Spell(moonfire)
 #stellar_flare,target_if=refreshable,if=astral_power.deficit>=13&floor(target.time_to_die%tick_time)>=5&(!variable.az_ss|!buff.ca_inc.up|!prev.stellar_flare)
 if target.Refreshable(stellar_flare_debuff) and AstralPowerDeficit() >= 13 and target.TimeToDie() / target.CurrentTickTime(stellar_flare_debuff) >= 5 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(stellar_flare) } Spell(stellar_flare)
 #new_moon,if=astral_power.deficit>=15
 if AstralPowerDeficit() >= 15 and not SpellKnown(half_moon) and not SpellKnown(full_moon) Spell(new_moon)
 #half_moon,if=astral_power.deficit>=25
 if AstralPowerDeficit() >= 25 and SpellKnown(half_moon) Spell(half_moon)
 #full_moon,if=astral_power.deficit>=45
 if AstralPowerDeficit() >= 45 and SpellKnown(full_moon) Spell(full_moon)
 #lunar_strike,if=buff.solar_empowerment.stack<3&(astral_power.deficit>=17|buff.lunar_empowerment.stack=3)&((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=2&!buff.solar_empowerment.up)&(!variable.az_ss|!buff.ca_inc.up|(!prev.lunar_strike&!talent.incarnation.enabled|prev.solar_wrath))|variable.az_ss&buff.ca_inc.up&prev.solar_wrath)
 if BuffStacks(solar_empowerment_buff) < 3 and { AstralPowerDeficit() >= 17 or BuffStacks(lunar_empowerment_buff) == 3 } and { { BuffPresent(warrior_of_elune_buff) or BuffPresent(lunar_empowerment_buff) or Enemies() >= 2 and not BuffPresent(solar_empowerment_buff) } and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(lunar_strike) and not Talent(incarnation_talent) or PreviousSpell(solar_wrath_balance) } or az_ss() and BuffPresent(ca_inc_buff) and PreviousSpell(solar_wrath_balance) } Spell(lunar_strike)
 #solar_wrath,if=variable.az_ss<3|!buff.ca_inc.up|!prev.solar_wrath
 if az_ss() < 3 or not BuffPresent(ca_inc_buff) or not PreviousSpell(solar_wrath_balance) Spell(solar_wrath_balance)
 #sunfire
 Spell(sunfire)
}

AddFunction BalanceDefaultMainPostConditions
{
}

AddFunction BalanceDefaultShortCdActions
{
 #warrior_of_elune
 Spell(warrior_of_elune)
 #fury_of_elune,if=(buff.ca_inc.up|cooldown.ca_inc.remains>30)&astral_power.deficit>=13
 if { BuffPresent(ca_inc_buff) or SpellCooldown(ca_inc) > 30 } and AstralPowerDeficit() >= 13 Spell(fury_of_elune)
 #force_of_nature,if=(buff.ca_inc.up|cooldown.ca_inc.remains>30)&astral_power.deficit>=25
 if { BuffPresent(ca_inc_buff) or SpellCooldown(ca_inc) > 30 } and AstralPowerDeficit() >= 25 Spell(force_of_nature)
}

AddFunction BalanceDefaultShortCdPostConditions
{
 BuffRemaining(starlord_buff) < 8 and AstralPower() > 87 and BuffPresent(starlord_buff) and Texture(starlord text=cancel) or { BuffStacks(starlord_buff) < 3 or BuffRemaining(starlord_buff) >= 8 } and Enemies() >= sf_targets() and { target.TimeToDie() + 1 } * Enemies() > PowerCost(starfall) / 2.5 and Spell(starfall) or { { BuffStacks(starlord_buff) < 3 or BuffRemaining(starlord_buff) >= 8 } and Enemies() < sf_targets() and BuffStacks(lunar_empowerment_buff) + BuffStacks(solar_empowerment_buff) < 4 and BuffStacks(solar_empowerment_buff) < 3 and BuffStacks(lunar_empowerment_buff) < 3 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(starsurge_balance) } or target.TimeToDie() <= ExecuteTime(starsurge_balance) * AstralPower() / 40 } and Spell(starsurge_balance) or target.Refreshable(sunfire_debuff) and AstralPowerDeficit() >= 8 and target.TimeToDie() / target.CurrentTickTime(sunfire_debuff) * Enemies() >= 5 and { Enemies() > 1 + TalentPoints(twin_moons_talent) or target.DebuffPresent(moonfire_debuff) } and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(sunfire) } and Spell(sunfire) or target.Refreshable(moonfire_debuff) and AstralPowerDeficit() >= 8 and target.TimeToDie() / target.CurrentTickTime(moonfire_debuff) * Enemies() >= 5 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(moonfire) } and Spell(moonfire) or target.Refreshable(stellar_flare_debuff) and AstralPowerDeficit() >= 13 and target.TimeToDie() / target.CurrentTickTime(stellar_flare_debuff) >= 5 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(stellar_flare) } and Spell(stellar_flare) or AstralPowerDeficit() >= 15 and not SpellKnown(half_moon) and not SpellKnown(full_moon) and Spell(new_moon) or AstralPowerDeficit() >= 25 and SpellKnown(half_moon) and Spell(half_moon) or AstralPowerDeficit() >= 45 and SpellKnown(full_moon) and Spell(full_moon) or BuffStacks(solar_empowerment_buff) < 3 and { AstralPowerDeficit() >= 17 or BuffStacks(lunar_empowerment_buff) == 3 } and { { BuffPresent(warrior_of_elune_buff) or BuffPresent(lunar_empowerment_buff) or Enemies() >= 2 and not BuffPresent(solar_empowerment_buff) } and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(lunar_strike) and not Talent(incarnation_talent) or PreviousSpell(solar_wrath_balance) } or az_ss() and BuffPresent(ca_inc_buff) and PreviousSpell(solar_wrath_balance) } and Spell(lunar_strike) or { az_ss() < 3 or not BuffPresent(ca_inc_buff) or not PreviousSpell(solar_wrath_balance) } and Spell(solar_wrath_balance) or Spell(sunfire)
}

AddFunction BalanceDefaultCdActions
{
 BalanceInterruptActions()
 #potion,if=buff.ca_inc.remains>6&active_enemies=1
 if BuffRemaining(ca_inc_buff) > 6 and Enemies() == 1 and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(rising_death usable=1)
 #potion,name=battle_potion_of_intellect,if=buff.ca_inc.remains>6
 if BuffRemaining(ca_inc_buff) > 6 and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(battle_potion_of_intellect usable=1)
 #blood_fury,if=buff.ca_inc.up
 if BuffPresent(ca_inc_buff) Spell(blood_fury)
 #berserking,if=buff.ca_inc.up
 if BuffPresent(ca_inc_buff) Spell(berserking)
 #arcane_torrent,if=buff.ca_inc.up
 if BuffPresent(ca_inc_buff) Spell(arcane_torrent_energy)
 #lights_judgment,if=buff.ca_inc.up
 if BuffPresent(ca_inc_buff) Spell(lights_judgment)
 #fireblood,if=buff.ca_inc.up
 if BuffPresent(ca_inc_buff) Spell(fireblood)
 #ancestral_call,if=buff.ca_inc.up
 if BuffPresent(ca_inc_buff) Spell(ancestral_call)
 #use_item,name=balefire_branch,if=equipped.159630&cooldown.ca_inc.remains>30
 if HasEquippedItem(159630) and SpellCooldown(ca_inc) > 30 BalanceUseItemActions()
 #use_item,name=dread_gladiators_badge,if=equipped.161902&cooldown.ca_inc.remains>30
 if HasEquippedItem(161902) and SpellCooldown(ca_inc) > 30 BalanceUseItemActions()
 #use_item,name=azurethos_singed_plumage,if=equipped.161377&cooldown.ca_inc.remains>30
 if HasEquippedItem(161377) and SpellCooldown(ca_inc) > 30 BalanceUseItemActions()
 #use_items,if=cooldown.ca_inc.remains>30
 if SpellCooldown(ca_inc) > 30 BalanceUseItemActions()

 unless Spell(warrior_of_elune)
 {
  #innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.remains<2|cooldown.celestial_alignment.remains<12)
  if HasAzeriteTrait(lively_spirit_trait) and { SpellCooldown(incarnation_chosen_of_elune) < 2 or SpellCooldown(celestial_alignment) < 12 } Spell(innervate)
  #incarnation,if=astral_power>=40
  if AstralPower() >= 40 Spell(incarnation_chosen_of_elune)
  #celestial_alignment,if=astral_power>=40&(!azerite.lively_spirit.enabled|buff.lively_spirit.up)&(buff.starlord.stack>=2|!talent.starlord.enabled|!variable.az_ss)
  if AstralPower() >= 40 and { not HasAzeriteTrait(lively_spirit_trait) or BuffPresent(lively_spirit_buff) } and { BuffStacks(starlord_buff) >= 2 or not Talent(starlord_talent) or not az_ss() } Spell(celestial_alignment)
 }
}

AddFunction BalanceDefaultCdPostConditions
{
 Spell(warrior_of_elune) or { BuffPresent(ca_inc_buff) or SpellCooldown(ca_inc) > 30 } and AstralPowerDeficit() >= 13 and Spell(fury_of_elune) or { BuffPresent(ca_inc_buff) or SpellCooldown(ca_inc) > 30 } and AstralPowerDeficit() >= 25 and Spell(force_of_nature) or BuffRemaining(starlord_buff) < 8 and AstralPower() > 87 and BuffPresent(starlord_buff) and Texture(starlord text=cancel) or { BuffStacks(starlord_buff) < 3 or BuffRemaining(starlord_buff) >= 8 } and Enemies() >= sf_targets() and { target.TimeToDie() + 1 } * Enemies() > PowerCost(starfall) / 2.5 and Spell(starfall) or { { BuffStacks(starlord_buff) < 3 or BuffRemaining(starlord_buff) >= 8 } and Enemies() < sf_targets() and BuffStacks(lunar_empowerment_buff) + BuffStacks(solar_empowerment_buff) < 4 and BuffStacks(solar_empowerment_buff) < 3 and BuffStacks(lunar_empowerment_buff) < 3 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(starsurge_balance) } or target.TimeToDie() <= ExecuteTime(starsurge_balance) * AstralPower() / 40 } and Spell(starsurge_balance) or target.Refreshable(sunfire_debuff) and AstralPowerDeficit() >= 8 and target.TimeToDie() / target.CurrentTickTime(sunfire_debuff) * Enemies() >= 5 and { Enemies() > 1 + TalentPoints(twin_moons_talent) or target.DebuffPresent(moonfire_debuff) } and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(sunfire) } and Spell(sunfire) or target.Refreshable(moonfire_debuff) and AstralPowerDeficit() >= 8 and target.TimeToDie() / target.CurrentTickTime(moonfire_debuff) * Enemies() >= 5 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(moonfire) } and Spell(moonfire) or target.Refreshable(stellar_flare_debuff) and AstralPowerDeficit() >= 13 and target.TimeToDie() / target.CurrentTickTime(stellar_flare_debuff) >= 5 and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(stellar_flare) } and Spell(stellar_flare) or AstralPowerDeficit() >= 15 and not SpellKnown(half_moon) and not SpellKnown(full_moon) and Spell(new_moon) or AstralPowerDeficit() >= 25 and SpellKnown(half_moon) and Spell(half_moon) or AstralPowerDeficit() >= 45 and SpellKnown(full_moon) and Spell(full_moon) or BuffStacks(solar_empowerment_buff) < 3 and { AstralPowerDeficit() >= 17 or BuffStacks(lunar_empowerment_buff) == 3 } and { { BuffPresent(warrior_of_elune_buff) or BuffPresent(lunar_empowerment_buff) or Enemies() >= 2 and not BuffPresent(solar_empowerment_buff) } and { not az_ss() or not BuffPresent(ca_inc_buff) or not PreviousSpell(lunar_strike) and not Talent(incarnation_talent) or PreviousSpell(solar_wrath_balance) } or az_ss() and BuffPresent(ca_inc_buff) and PreviousSpell(solar_wrath_balance) } and Spell(lunar_strike) or { az_ss() < 3 or not BuffPresent(ca_inc_buff) or not PreviousSpell(solar_wrath_balance) } and Spell(solar_wrath_balance) or Spell(sunfire)
}

### Balance icons.

AddCheckBox(opt_druid_balance_aoe L(AOE) default specialization=balance)

AddIcon checkbox=!opt_druid_balance_aoe enemies=1 help=shortcd specialization=balance
{
 if not InCombat() BalancePrecombatShortCdActions()
 unless not InCombat() and BalancePrecombatShortCdPostConditions()
 {
  BalanceDefaultShortCdActions()
 }
}

AddIcon checkbox=opt_druid_balance_aoe help=shortcd specialization=balance
{
 if not InCombat() BalancePrecombatShortCdActions()
 unless not InCombat() and BalancePrecombatShortCdPostConditions()
 {
  BalanceDefaultShortCdActions()
 }
}

AddIcon enemies=1 help=main specialization=balance
{
 if not InCombat() BalancePrecombatMainActions()
 unless not InCombat() and BalancePrecombatMainPostConditions()
 {
  BalanceDefaultMainActions()
 }
}

AddIcon checkbox=opt_druid_balance_aoe help=aoe specialization=balance
{
 if not InCombat() BalancePrecombatMainActions()
 unless not InCombat() and BalancePrecombatMainPostConditions()
 {
  BalanceDefaultMainActions()
 }
}

AddIcon checkbox=!opt_druid_balance_aoe enemies=1 help=cd specialization=balance
{
 if not InCombat() BalancePrecombatCdActions()
 unless not InCombat() and BalancePrecombatCdPostConditions()
 {
  BalanceDefaultCdActions()
 }
}

AddIcon checkbox=opt_druid_balance_aoe help=cd specialization=balance
{
 if not InCombat() BalancePrecombatCdActions()
 unless not InCombat() and BalancePrecombatCdPostConditions()
 {
  BalanceDefaultCdActions()
 }
}

### Required symbols
# 159630
# 161377
# 161902
# ancestral_call
# arcane_torrent_energy
# arcanic_pulsar_trait
# battle_potion_of_intellect
# berserking
# blood_fury
# ca_inc
# ca_inc_buff
# celestial_alignment
# fireblood
# force_of_nature
# full_moon
# fury_of_elune
# half_moon
# incarnation_chosen_of_elune
# incarnation_talent
# innervate
# lights_judgment
# lively_spirit_buff
# lively_spirit_trait
# lunar_empowerment_buff
# lunar_strike
# mighty_bash
# moonfire
# moonfire_debuff
# moonkin_form_balance
# new_moon
# rising_death
# solar_beam
# solar_empowerment_buff
# solar_wrath_balance
# starfall
# starlord
# starlord_buff
# starlord_talent
# starsurge_balance
# stellar_flare
# stellar_flare_debuff
# streaking_stars_trait
# sunfire
# sunfire_debuff
# twin_moons_talent
# typhoon
# war_stomp
# warrior_of_elune
# warrior_of_elune_buff
]]
    OvaleScripts:RegisterScript("DRUID", "balance", name, desc, code, "script")
end
do
    local name = "sc_pr_druid_feral"
    local desc = "[8.1] Simulationcraft: PR_Druid_Feral"
    local code = [[
# Based on SimulationCraft profile "PR_Druid_Feral".
#	class=druid
#	spec=feral
#	talents=3000212

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_druid_spells)


AddFunction opener_done
{
 target.DebuffPresent(rip_debuff)
}

AddFunction delayed_tf_opener
{
 if Talent(sabertooth_talent) and Talent(bloodtalons_talent) and not Talent(lunar_inspiration_talent) 1
 0
}

AddFunction use_thrash
{
 if HasAzeriteTrait(wild_fleshrending_trait) 2
 0
}

AddCheckBox(opt_interrupt L(interrupt) default specialization=feral)
AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=feral)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=feral)

AddFunction FeralInterruptActions
{
 if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
 {
  if target.InRange(skull_bash) and target.IsInterruptible() Spell(skull_bash)
  if target.InRange(mighty_bash) and not target.Classification(worldboss) Spell(mighty_bash)
  if target.InRange(maim) and not target.Classification(worldboss) Spell(maim)
  if target.Distance(less 5) and not target.Classification(worldboss) Spell(war_stomp)
  if target.Distance(less 15) and not target.Classification(worldboss) Spell(typhoon)
 }
}

AddFunction FeralUseItemActions
{
 Item(Trinket0Slot text=13 usable=1)
 Item(Trinket1Slot text=14 usable=1)
}

AddFunction FeralGetInMeleeRange
{
 if CheckBoxOn(opt_melee_range) and Stance(druid_bear_form) and not target.InRange(mangle) or { Stance(druid_cat_form) or Stance(druid_claws_of_shirvallah) } and not target.InRange(shred)
 {
  if target.InRange(wild_charge) Spell(wild_charge)
  Texture(misc_arrowlup help=L(not_in_melee_range))
 }
}

### actions.st_generators

AddFunction FeralStgeneratorsMainActions
{
 #regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
 if Talent(bloodtalons_talent) and BuffPresent(predatory_swiftness_buff) and BuffExpires(bloodtalons_buff) and ComboPoints() == 4 and target.DebuffRemaining(rake_debuff) < 4 and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } Spell(regrowth)
 #regrowth,if=talent.bloodtalons.enabled&buff.bloodtalons.down&buff.predatory_swiftness.up&talent.lunar_inspiration.enabled&dot.rake.remains<1
 if Talent(bloodtalons_talent) and BuffExpires(bloodtalons_buff) and BuffPresent(predatory_swiftness_buff) and Talent(lunar_inspiration_talent) and target.DebuffRemaining(rake_debuff) < 1 and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } Spell(regrowth)
 #brutal_slash,if=spell_targets.brutal_slash>desired_targets
 if Enemies() > Enemies(tagged=1) Spell(brutal_slash)
 #pool_resource,for_next=1
 #thrash_cat,if=(refreshable)&(spell_targets.thrash_cat>2)
 if target.Refreshable(thrash_cat_debuff) and Enemies() > 2 Spell(thrash_cat)
 unless target.Refreshable(thrash_cat_debuff) and Enemies() > 2 and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat)
 {
  #pool_resource,for_next=1
  #thrash_cat,if=(talent.scent_of_blood.enabled&buff.scent_of_blood.down)&spell_targets.thrash_cat>3
  if Talent(scent_of_blood_talent) and BuffExpires(scent_of_blood_buff) and Enemies() > 3 Spell(thrash_cat)
  unless Talent(scent_of_blood_talent) and BuffExpires(scent_of_blood_buff) and Enemies() > 3 and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat)
  {
   #pool_resource,for_next=1
   #swipe_cat,if=buff.scent_of_blood.up
   if BuffPresent(scent_of_blood_buff) Spell(swipe_cat)
   unless BuffPresent(scent_of_blood_buff) and SpellUsable(swipe_cat) and SpellCooldown(swipe_cat) < TimeToEnergyFor(swipe_cat)
   {
    #pool_resource,for_next=1
    #rake,target_if=!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)&target.time_to_die>4
    if not target.DebuffPresent(rake_debuff) or not Talent(bloodtalons_talent) and target.DebuffRemaining(rake_debuff) < BaseDuration(rake_debuff) * 0.3 and target.TimeToDie() > 4 Spell(rake)
    unless { not target.DebuffPresent(rake_debuff) or not Talent(bloodtalons_talent) and target.DebuffRemaining(rake_debuff) < BaseDuration(rake_debuff) * 0.3 and target.TimeToDie() > 4 } and SpellUsable(rake) and SpellCooldown(rake) < TimeToEnergyFor(rake)
    {
     #pool_resource,for_next=1
     #rake,target_if=talent.bloodtalons.enabled&buff.bloodtalons.up&((remains<=7)&persistent_multiplier>dot.rake.pmultiplier*0.85)&target.time_to_die>4
     if Talent(bloodtalons_talent) and BuffPresent(bloodtalons_buff) and target.DebuffRemaining(rake_debuff) <= 7 and PersistentMultiplier(rake_debuff) > target.DebuffPersistentMultiplier(rake_debuff) * 0.85 and target.TimeToDie() > 4 Spell(rake)
     unless Talent(bloodtalons_talent) and BuffPresent(bloodtalons_buff) and target.DebuffRemaining(rake_debuff) <= 7 and PersistentMultiplier(rake_debuff) > target.DebuffPersistentMultiplier(rake_debuff) * 0.85 and target.TimeToDie() > 4 and SpellUsable(rake) and SpellCooldown(rake) < TimeToEnergyFor(rake)
     {
      #moonfire_cat,if=buff.bloodtalons.up&buff.predatory_swiftness.down&combo_points<5
      if BuffPresent(bloodtalons_buff) and BuffExpires(predatory_swiftness_buff) and ComboPoints() < 5 Spell(moonfire_cat)
      #brutal_slash,if=(buff.tigers_fury.up&(raid_event.adds.in>(1+max_charges-charges_fractional)*recharge_time))
      if BuffPresent(tigers_fury_buff) and 600 > { 1 + SpellMaxCharges(brutal_slash) - Charges(brutal_slash count=0) } * SpellChargeCooldown(brutal_slash) Spell(brutal_slash)
      #moonfire_cat,target_if=refreshable
      if target.Refreshable(moonfire_cat_debuff) Spell(moonfire_cat)
      #pool_resource,for_next=1
      #thrash_cat,if=refreshable&((variable.use_thrash=2&(!buff.incarnation.up|azerite.wild_fleshrending.enabled))|spell_targets.thrash_cat>1)
      if target.Refreshable(thrash_cat_debuff) and { use_thrash() == 2 and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } or Enemies() > 1 } Spell(thrash_cat)
      unless target.Refreshable(thrash_cat_debuff) and { use_thrash() == 2 and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } or Enemies() > 1 } and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat)
      {
       #thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react&(!buff.incarnation.up|azerite.wild_fleshrending.enabled)
       if target.Refreshable(thrash_cat_debuff) and use_thrash() == 1 and BuffPresent(clearcasting_buff) and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } Spell(thrash_cat)
       #pool_resource,for_next=1
       #swipe_cat,if=spell_targets.swipe_cat>1
       if Enemies() > 1 Spell(swipe_cat)
       unless Enemies() > 1 and SpellUsable(swipe_cat) and SpellCooldown(swipe_cat) < TimeToEnergyFor(swipe_cat)
       {
        #shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react
        if target.DebuffRemaining(rake_debuff) > { PowerCost(shred) + PowerCost(rake) - Energy() } / EnergyRegenRate() or BuffPresent(clearcasting_buff) Spell(shred)
       }
      }
     }
    }
   }
  }
 }
}

AddFunction FeralStgeneratorsMainPostConditions
{
}

AddFunction FeralStgeneratorsShortCdActions
{
}

AddFunction FeralStgeneratorsShortCdPostConditions
{
 Talent(bloodtalons_talent) and BuffPresent(predatory_swiftness_buff) and BuffExpires(bloodtalons_buff) and ComboPoints() == 4 and target.DebuffRemaining(rake_debuff) < 4 and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or Talent(bloodtalons_talent) and BuffExpires(bloodtalons_buff) and BuffPresent(predatory_swiftness_buff) and Talent(lunar_inspiration_talent) and target.DebuffRemaining(rake_debuff) < 1 and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or Enemies() > Enemies(tagged=1) and Spell(brutal_slash) or target.Refreshable(thrash_cat_debuff) and Enemies() > 2 and Spell(thrash_cat) or not { target.Refreshable(thrash_cat_debuff) and Enemies() > 2 and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat) } and { Talent(scent_of_blood_talent) and BuffExpires(scent_of_blood_buff) and Enemies() > 3 and Spell(thrash_cat) or not { Talent(scent_of_blood_talent) and BuffExpires(scent_of_blood_buff) and Enemies() > 3 and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat) } and { BuffPresent(scent_of_blood_buff) and Spell(swipe_cat) or not { BuffPresent(scent_of_blood_buff) and SpellUsable(swipe_cat) and SpellCooldown(swipe_cat) < TimeToEnergyFor(swipe_cat) } and { { not target.DebuffPresent(rake_debuff) or not Talent(bloodtalons_talent) and target.DebuffRemaining(rake_debuff) < BaseDuration(rake_debuff) * 0.3 and target.TimeToDie() > 4 } and Spell(rake) or not { { not target.DebuffPresent(rake_debuff) or not Talent(bloodtalons_talent) and target.DebuffRemaining(rake_debuff) < BaseDuration(rake_debuff) * 0.3 and target.TimeToDie() > 4 } and SpellUsable(rake) and SpellCooldown(rake) < TimeToEnergyFor(rake) } and { Talent(bloodtalons_talent) and BuffPresent(bloodtalons_buff) and target.DebuffRemaining(rake_debuff) <= 7 and PersistentMultiplier(rake_debuff) > target.DebuffPersistentMultiplier(rake_debuff) * 0.85 and target.TimeToDie() > 4 and Spell(rake) or not { Talent(bloodtalons_talent) and BuffPresent(bloodtalons_buff) and target.DebuffRemaining(rake_debuff) <= 7 and PersistentMultiplier(rake_debuff) > target.DebuffPersistentMultiplier(rake_debuff) * 0.85 and target.TimeToDie() > 4 and SpellUsable(rake) and SpellCooldown(rake) < TimeToEnergyFor(rake) } and { BuffPresent(bloodtalons_buff) and BuffExpires(predatory_swiftness_buff) and ComboPoints() < 5 and Spell(moonfire_cat) or BuffPresent(tigers_fury_buff) and 600 > { 1 + SpellMaxCharges(brutal_slash) - Charges(brutal_slash count=0) } * SpellChargeCooldown(brutal_slash) and Spell(brutal_slash) or target.Refreshable(moonfire_cat_debuff) and Spell(moonfire_cat) or target.Refreshable(thrash_cat_debuff) and { use_thrash() == 2 and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } or Enemies() > 1 } and Spell(thrash_cat) or not { target.Refreshable(thrash_cat_debuff) and { use_thrash() == 2 and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } or Enemies() > 1 } and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat) } and { target.Refreshable(thrash_cat_debuff) and use_thrash() == 1 and BuffPresent(clearcasting_buff) and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } and Spell(thrash_cat) or Enemies() > 1 and Spell(swipe_cat) or not { Enemies() > 1 and SpellUsable(swipe_cat) and SpellCooldown(swipe_cat) < TimeToEnergyFor(swipe_cat) } and { target.DebuffRemaining(rake_debuff) > { PowerCost(shred) + PowerCost(rake) - Energy() } / EnergyRegenRate() or BuffPresent(clearcasting_buff) } and Spell(shred) } } } } } }
}

AddFunction FeralStgeneratorsCdActions
{
}

AddFunction FeralStgeneratorsCdPostConditions
{
 Talent(bloodtalons_talent) and BuffPresent(predatory_swiftness_buff) and BuffExpires(bloodtalons_buff) and ComboPoints() == 4 and target.DebuffRemaining(rake_debuff) < 4 and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or Talent(bloodtalons_talent) and BuffExpires(bloodtalons_buff) and BuffPresent(predatory_swiftness_buff) and Talent(lunar_inspiration_talent) and target.DebuffRemaining(rake_debuff) < 1 and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or Enemies() > Enemies(tagged=1) and Spell(brutal_slash) or target.Refreshable(thrash_cat_debuff) and Enemies() > 2 and Spell(thrash_cat) or not { target.Refreshable(thrash_cat_debuff) and Enemies() > 2 and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat) } and { Talent(scent_of_blood_talent) and BuffExpires(scent_of_blood_buff) and Enemies() > 3 and Spell(thrash_cat) or not { Talent(scent_of_blood_talent) and BuffExpires(scent_of_blood_buff) and Enemies() > 3 and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat) } and { BuffPresent(scent_of_blood_buff) and Spell(swipe_cat) or not { BuffPresent(scent_of_blood_buff) and SpellUsable(swipe_cat) and SpellCooldown(swipe_cat) < TimeToEnergyFor(swipe_cat) } and { { not target.DebuffPresent(rake_debuff) or not Talent(bloodtalons_talent) and target.DebuffRemaining(rake_debuff) < BaseDuration(rake_debuff) * 0.3 and target.TimeToDie() > 4 } and Spell(rake) or not { { not target.DebuffPresent(rake_debuff) or not Talent(bloodtalons_talent) and target.DebuffRemaining(rake_debuff) < BaseDuration(rake_debuff) * 0.3 and target.TimeToDie() > 4 } and SpellUsable(rake) and SpellCooldown(rake) < TimeToEnergyFor(rake) } and { Talent(bloodtalons_talent) and BuffPresent(bloodtalons_buff) and target.DebuffRemaining(rake_debuff) <= 7 and PersistentMultiplier(rake_debuff) > target.DebuffPersistentMultiplier(rake_debuff) * 0.85 and target.TimeToDie() > 4 and Spell(rake) or not { Talent(bloodtalons_talent) and BuffPresent(bloodtalons_buff) and target.DebuffRemaining(rake_debuff) <= 7 and PersistentMultiplier(rake_debuff) > target.DebuffPersistentMultiplier(rake_debuff) * 0.85 and target.TimeToDie() > 4 and SpellUsable(rake) and SpellCooldown(rake) < TimeToEnergyFor(rake) } and { BuffPresent(bloodtalons_buff) and BuffExpires(predatory_swiftness_buff) and ComboPoints() < 5 and Spell(moonfire_cat) or BuffPresent(tigers_fury_buff) and 600 > { 1 + SpellMaxCharges(brutal_slash) - Charges(brutal_slash count=0) } * SpellChargeCooldown(brutal_slash) and Spell(brutal_slash) or target.Refreshable(moonfire_cat_debuff) and Spell(moonfire_cat) or target.Refreshable(thrash_cat_debuff) and { use_thrash() == 2 and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } or Enemies() > 1 } and Spell(thrash_cat) or not { target.Refreshable(thrash_cat_debuff) and { use_thrash() == 2 and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } or Enemies() > 1 } and SpellUsable(thrash_cat) and SpellCooldown(thrash_cat) < TimeToEnergyFor(thrash_cat) } and { target.Refreshable(thrash_cat_debuff) and use_thrash() == 1 and BuffPresent(clearcasting_buff) and { not BuffPresent(incarnation_king_of_the_jungle_buff) or HasAzeriteTrait(wild_fleshrending_trait) } and Spell(thrash_cat) or Enemies() > 1 and Spell(swipe_cat) or not { Enemies() > 1 and SpellUsable(swipe_cat) and SpellCooldown(swipe_cat) < TimeToEnergyFor(swipe_cat) } and { target.DebuffRemaining(rake_debuff) > { PowerCost(shred) + PowerCost(rake) - Energy() } / EnergyRegenRate() or BuffPresent(clearcasting_buff) } and Spell(shred) } } } } } }
}

### actions.st_finishers

AddFunction FeralStfinishersMainActions
{
 #pool_resource,for_next=1
 #savage_roar,if=buff.savage_roar.down
 if BuffExpires(savage_roar_buff) Spell(savage_roar)
 unless BuffExpires(savage_roar_buff) and SpellUsable(savage_roar) and SpellCooldown(savage_roar) < TimeToEnergyFor(savage_roar)
 {
  #pool_resource,for_next=1
  #primal_wrath,target_if=spell_targets.primal_wrath>1&dot.rip.remains<4
  if Enemies() > 1 and target.DebuffRemaining(rip_debuff) < 4 Spell(primal_wrath)
  unless Enemies() > 1 and target.DebuffRemaining(rip_debuff) < 4 and SpellUsable(primal_wrath) and SpellCooldown(primal_wrath) < TimeToEnergyFor(primal_wrath)
  {
   #pool_resource,for_next=1
   #rip,target_if=!ticking|(remains<=duration*0.3)&(target.health.pct>25&!talent.sabertooth.enabled)|(remains<=duration*0.8&persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die>8
   if not target.DebuffPresent(rip_debuff) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.3 and target.HealthPercent() > 25 and not Talent(sabertooth_talent) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.8 and PersistentMultiplier(rip_debuff) > target.DebuffPersistentMultiplier(rip_debuff) and target.TimeToDie() > 8 Spell(rip)
   unless { not target.DebuffPresent(rip_debuff) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.3 and target.HealthPercent() > 25 and not Talent(sabertooth_talent) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.8 and PersistentMultiplier(rip_debuff) > target.DebuffPersistentMultiplier(rip_debuff) and target.TimeToDie() > 8 } and SpellUsable(rip) and SpellCooldown(rip) < TimeToEnergyFor(rip)
   {
    #pool_resource,for_next=1
    #savage_roar,if=buff.savage_roar.remains<12
    if BuffRemaining(savage_roar_buff) < 12 Spell(savage_roar)
    unless BuffRemaining(savage_roar_buff) < 12 and SpellUsable(savage_roar) and SpellCooldown(savage_roar) < TimeToEnergyFor(savage_roar)
    {
     #pool_resource,for_next=1
     #maim,if=buff.iron_jaws.up
     if DebuffPresent(iron_jaws) Spell(maim)
     unless DebuffPresent(iron_jaws) and SpellUsable(maim) and SpellCooldown(maim) < TimeToEnergyFor(maim)
     {
      #ferocious_bite,max_energy=1
      if Energy() >= EnergyCost(ferocious_bite max=1) Spell(ferocious_bite)
     }
    }
   }
  }
 }
}

AddFunction FeralStfinishersMainPostConditions
{
}

AddFunction FeralStfinishersShortCdActions
{
}

AddFunction FeralStfinishersShortCdPostConditions
{
 BuffExpires(savage_roar_buff) and Spell(savage_roar) or not { BuffExpires(savage_roar_buff) and SpellUsable(savage_roar) and SpellCooldown(savage_roar) < TimeToEnergyFor(savage_roar) } and { Enemies() > 1 and target.DebuffRemaining(rip_debuff) < 4 and Spell(primal_wrath) or not { Enemies() > 1 and target.DebuffRemaining(rip_debuff) < 4 and SpellUsable(primal_wrath) and SpellCooldown(primal_wrath) < TimeToEnergyFor(primal_wrath) } and { { not target.DebuffPresent(rip_debuff) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.3 and target.HealthPercent() > 25 and not Talent(sabertooth_talent) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.8 and PersistentMultiplier(rip_debuff) > target.DebuffPersistentMultiplier(rip_debuff) and target.TimeToDie() > 8 } and Spell(rip) or not { { not target.DebuffPresent(rip_debuff) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.3 and target.HealthPercent() > 25 and not Talent(sabertooth_talent) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.8 and PersistentMultiplier(rip_debuff) > target.DebuffPersistentMultiplier(rip_debuff) and target.TimeToDie() > 8 } and SpellUsable(rip) and SpellCooldown(rip) < TimeToEnergyFor(rip) } and { BuffRemaining(savage_roar_buff) < 12 and Spell(savage_roar) or not { BuffRemaining(savage_roar_buff) < 12 and SpellUsable(savage_roar) and SpellCooldown(savage_roar) < TimeToEnergyFor(savage_roar) } and { DebuffPresent(iron_jaws) and Spell(maim) or not { DebuffPresent(iron_jaws) and SpellUsable(maim) and SpellCooldown(maim) < TimeToEnergyFor(maim) } and Energy() >= EnergyCost(ferocious_bite max=1) and Spell(ferocious_bite) } } } }
}

AddFunction FeralStfinishersCdActions
{
}

AddFunction FeralStfinishersCdPostConditions
{
 BuffExpires(savage_roar_buff) and Spell(savage_roar) or not { BuffExpires(savage_roar_buff) and SpellUsable(savage_roar) and SpellCooldown(savage_roar) < TimeToEnergyFor(savage_roar) } and { Enemies() > 1 and target.DebuffRemaining(rip_debuff) < 4 and Spell(primal_wrath) or not { Enemies() > 1 and target.DebuffRemaining(rip_debuff) < 4 and SpellUsable(primal_wrath) and SpellCooldown(primal_wrath) < TimeToEnergyFor(primal_wrath) } and { { not target.DebuffPresent(rip_debuff) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.3 and target.HealthPercent() > 25 and not Talent(sabertooth_talent) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.8 and PersistentMultiplier(rip_debuff) > target.DebuffPersistentMultiplier(rip_debuff) and target.TimeToDie() > 8 } and Spell(rip) or not { { not target.DebuffPresent(rip_debuff) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.3 and target.HealthPercent() > 25 and not Talent(sabertooth_talent) or target.DebuffRemaining(rip_debuff) <= BaseDuration(rip_debuff) * 0.8 and PersistentMultiplier(rip_debuff) > target.DebuffPersistentMultiplier(rip_debuff) and target.TimeToDie() > 8 } and SpellUsable(rip) and SpellCooldown(rip) < TimeToEnergyFor(rip) } and { BuffRemaining(savage_roar_buff) < 12 and Spell(savage_roar) or not { BuffRemaining(savage_roar_buff) < 12 and SpellUsable(savage_roar) and SpellCooldown(savage_roar) < TimeToEnergyFor(savage_roar) } and { DebuffPresent(iron_jaws) and Spell(maim) or not { DebuffPresent(iron_jaws) and SpellUsable(maim) and SpellCooldown(maim) < TimeToEnergyFor(maim) } and Energy() >= EnergyCost(ferocious_bite max=1) and Spell(ferocious_bite) } } } }
}

### actions.single_target

AddFunction FeralSingletargetMainActions
{
 #cat_form,if=!buff.cat_form.up
 if not BuffPresent(cat_form_buff) Spell(cat_form)
 #rake,if=buff.prowl.up|buff.shadowmeld.up
 if BuffPresent(prowl_buff) or BuffPresent(shadowmeld_buff) Spell(rake)
 #call_action_list,name=cooldowns
 FeralCooldownsMainActions()

 unless FeralCooldownsMainPostConditions()
 {
  #ferocious_bite,target_if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>10&(target.health.pct<25|talent.sabertooth.enabled)
  if target.DebuffPresent(rip_debuff) and target.DebuffRemaining(rip_debuff) < 3 and target.TimeToDie() > 10 and { target.HealthPercent() < 25 or Talent(sabertooth_talent) } Spell(ferocious_bite)
  #regrowth,if=combo_points=5&buff.predatory_swiftness.up&talent.bloodtalons.enabled&buff.bloodtalons.down&(!buff.incarnation.up|dot.rip.remains<8)
  if ComboPoints() == 5 and BuffPresent(predatory_swiftness_buff) and Talent(bloodtalons_talent) and BuffExpires(bloodtalons_buff) and { not BuffPresent(incarnation_king_of_the_jungle_buff) or target.DebuffRemaining(rip_debuff) < 8 } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } Spell(regrowth)
  #run_action_list,name=st_finishers,if=combo_points>4
  if ComboPoints() > 4 FeralStfinishersMainActions()

  unless ComboPoints() > 4 and FeralStfinishersMainPostConditions()
  {
   #run_action_list,name=st_generators
   FeralStgeneratorsMainActions()
  }
 }
}

AddFunction FeralSingletargetMainPostConditions
{
 FeralCooldownsMainPostConditions() or ComboPoints() > 4 and FeralStfinishersMainPostConditions() or FeralStgeneratorsMainPostConditions()
}

AddFunction FeralSingletargetShortCdActions
{
 unless not BuffPresent(cat_form_buff) and Spell(cat_form) or { BuffPresent(prowl_buff) or BuffPresent(shadowmeld_buff) } and Spell(rake)
 {
  #auto_attack
  FeralGetInMeleeRange()
  #call_action_list,name=cooldowns
  FeralCooldownsShortCdActions()

  unless FeralCooldownsShortCdPostConditions() or target.DebuffPresent(rip_debuff) and target.DebuffRemaining(rip_debuff) < 3 and target.TimeToDie() > 10 and { target.HealthPercent() < 25 or Talent(sabertooth_talent) } and Spell(ferocious_bite) or ComboPoints() == 5 and BuffPresent(predatory_swiftness_buff) and Talent(bloodtalons_talent) and BuffExpires(bloodtalons_buff) and { not BuffPresent(incarnation_king_of_the_jungle_buff) or target.DebuffRemaining(rip_debuff) < 8 } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth)
  {
   #run_action_list,name=st_finishers,if=combo_points>4
   if ComboPoints() > 4 FeralStfinishersShortCdActions()

   unless ComboPoints() > 4 and FeralStfinishersShortCdPostConditions()
   {
    #run_action_list,name=st_generators
    FeralStgeneratorsShortCdActions()
   }
  }
 }
}

AddFunction FeralSingletargetShortCdPostConditions
{
 not BuffPresent(cat_form_buff) and Spell(cat_form) or { BuffPresent(prowl_buff) or BuffPresent(shadowmeld_buff) } and Spell(rake) or FeralCooldownsShortCdPostConditions() or target.DebuffPresent(rip_debuff) and target.DebuffRemaining(rip_debuff) < 3 and target.TimeToDie() > 10 and { target.HealthPercent() < 25 or Talent(sabertooth_talent) } and Spell(ferocious_bite) or ComboPoints() == 5 and BuffPresent(predatory_swiftness_buff) and Talent(bloodtalons_talent) and BuffExpires(bloodtalons_buff) and { not BuffPresent(incarnation_king_of_the_jungle_buff) or target.DebuffRemaining(rip_debuff) < 8 } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or ComboPoints() > 4 and FeralStfinishersShortCdPostConditions() or FeralStgeneratorsShortCdPostConditions()
}

AddFunction FeralSingletargetCdActions
{
 unless not BuffPresent(cat_form_buff) and Spell(cat_form) or { BuffPresent(prowl_buff) or BuffPresent(shadowmeld_buff) } and Spell(rake)
 {
  #call_action_list,name=cooldowns
  FeralCooldownsCdActions()

  unless FeralCooldownsCdPostConditions() or target.DebuffPresent(rip_debuff) and target.DebuffRemaining(rip_debuff) < 3 and target.TimeToDie() > 10 and { target.HealthPercent() < 25 or Talent(sabertooth_talent) } and Spell(ferocious_bite) or ComboPoints() == 5 and BuffPresent(predatory_swiftness_buff) and Talent(bloodtalons_talent) and BuffExpires(bloodtalons_buff) and { not BuffPresent(incarnation_king_of_the_jungle_buff) or target.DebuffRemaining(rip_debuff) < 8 } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth)
  {
   #run_action_list,name=st_finishers,if=combo_points>4
   if ComboPoints() > 4 FeralStfinishersCdActions()

   unless ComboPoints() > 4 and FeralStfinishersCdPostConditions()
   {
    #run_action_list,name=st_generators
    FeralStgeneratorsCdActions()
   }
  }
 }
}

AddFunction FeralSingletargetCdPostConditions
{
 not BuffPresent(cat_form_buff) and Spell(cat_form) or { BuffPresent(prowl_buff) or BuffPresent(shadowmeld_buff) } and Spell(rake) or FeralCooldownsCdPostConditions() or target.DebuffPresent(rip_debuff) and target.DebuffRemaining(rip_debuff) < 3 and target.TimeToDie() > 10 and { target.HealthPercent() < 25 or Talent(sabertooth_talent) } and Spell(ferocious_bite) or ComboPoints() == 5 and BuffPresent(predatory_swiftness_buff) and Talent(bloodtalons_talent) and BuffExpires(bloodtalons_buff) and { not BuffPresent(incarnation_king_of_the_jungle_buff) or target.DebuffRemaining(rip_debuff) < 8 } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or ComboPoints() > 4 and FeralStfinishersCdPostConditions() or FeralStgeneratorsCdPostConditions()
}

### actions.precombat

AddFunction FeralPrecombatMainActions
{
 #flask
 #food
 #augmentation
 #regrowth,if=talent.bloodtalons.enabled
 if Talent(bloodtalons_talent) and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } Spell(regrowth)
 #variable,name=use_thrash,value=0
 #variable,name=use_thrash,value=2,if=azerite.wild_fleshrending.enabled
 #variable,name=delayed_tf_opener,value=0
 #variable,name=delayed_tf_opener,value=1,if=talent.sabertooth.enabled&talent.bloodtalons.enabled&!talent.lunar_inspiration.enabled
 #cat_form
 Spell(cat_form)
 #prowl
 Spell(prowl)
}

AddFunction FeralPrecombatMainPostConditions
{
}

AddFunction FeralPrecombatShortCdActions
{
}

AddFunction FeralPrecombatShortCdPostConditions
{
 Talent(bloodtalons_talent) and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or Spell(cat_form) or Spell(prowl)
}

AddFunction FeralPrecombatCdActions
{
 unless Talent(bloodtalons_talent) and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or Spell(cat_form) or Spell(prowl)
 {
  #snapshot_stats
  #potion
  if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(battle_potion_of_agility usable=1)
  #berserk
  Spell(berserk)
 }
}

AddFunction FeralPrecombatCdPostConditions
{
 Talent(bloodtalons_talent) and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or Spell(cat_form) or Spell(prowl)
}

### actions.opener

AddFunction FeralOpenerMainActions
{
 #rake,if=!ticking|buff.prowl.up
 if not target.DebuffPresent(rake_debuff) or BuffPresent(prowl_buff) Spell(rake)
 #variable,name=opener_done,value=dot.rip.ticking
 #wait,sec=0.001,if=dot.rip.ticking
 #moonfire_cat,if=!ticking|buff.bloodtalons.stack=1&combo_points<5
 if not target.DebuffPresent(moonfire_cat_debuff) or BuffStacks(bloodtalons_buff) == 1 and ComboPoints() < 5 Spell(moonfire_cat)
 #thrash,if=!ticking&combo_points<5
 if not target.DebuffPresent(thrash) and ComboPoints() < 5 Spell(thrash)
 #shred,if=combo_points<5
 if ComboPoints() < 5 Spell(shred)
 #regrowth,if=combo_points=5&talent.bloodtalons.enabled&(talent.sabertooth.enabled&buff.bloodtalons.down|buff.predatory_swiftness.up)
 if ComboPoints() == 5 and Talent(bloodtalons_talent) and { Talent(sabertooth_talent) and BuffExpires(bloodtalons_buff) or BuffPresent(predatory_swiftness_buff) } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } Spell(regrowth)
 #rip,if=combo_points=5
 if ComboPoints() == 5 Spell(rip)
}

AddFunction FeralOpenerMainPostConditions
{
}

AddFunction FeralOpenerShortCdActions
{
 #tigers_fury,if=variable.delayed_tf_opener=0
 if delayed_tf_opener() == 0 Spell(tigers_fury)

 unless { not target.DebuffPresent(rake_debuff) or BuffPresent(prowl_buff) } and Spell(rake) or { not target.DebuffPresent(moonfire_cat_debuff) or BuffStacks(bloodtalons_buff) == 1 and ComboPoints() < 5 } and Spell(moonfire_cat) or not target.DebuffPresent(thrash) and ComboPoints() < 5 and Spell(thrash) or ComboPoints() < 5 and Spell(shred) or ComboPoints() == 5 and Talent(bloodtalons_talent) and { Talent(sabertooth_talent) and BuffExpires(bloodtalons_buff) or BuffPresent(predatory_swiftness_buff) } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth)
 {
  #tigers_fury
  Spell(tigers_fury)
 }
}

AddFunction FeralOpenerShortCdPostConditions
{
 { not target.DebuffPresent(rake_debuff) or BuffPresent(prowl_buff) } and Spell(rake) or { not target.DebuffPresent(moonfire_cat_debuff) or BuffStacks(bloodtalons_buff) == 1 and ComboPoints() < 5 } and Spell(moonfire_cat) or not target.DebuffPresent(thrash) and ComboPoints() < 5 and Spell(thrash) or ComboPoints() < 5 and Spell(shred) or ComboPoints() == 5 and Talent(bloodtalons_talent) and { Talent(sabertooth_talent) and BuffExpires(bloodtalons_buff) or BuffPresent(predatory_swiftness_buff) } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or ComboPoints() == 5 and Spell(rip)
}

AddFunction FeralOpenerCdActions
{
}

AddFunction FeralOpenerCdPostConditions
{
 delayed_tf_opener() == 0 and Spell(tigers_fury) or { not target.DebuffPresent(rake_debuff) or BuffPresent(prowl_buff) } and Spell(rake) or { not target.DebuffPresent(moonfire_cat_debuff) or BuffStacks(bloodtalons_buff) == 1 and ComboPoints() < 5 } and Spell(moonfire_cat) or not target.DebuffPresent(thrash) and ComboPoints() < 5 and Spell(thrash) or ComboPoints() < 5 and Spell(shred) or ComboPoints() == 5 and Talent(bloodtalons_talent) and { Talent(sabertooth_talent) and BuffExpires(bloodtalons_buff) or BuffPresent(predatory_swiftness_buff) } and Talent(bloodtalons_talent) and { BuffRemaining(bloodtalons_buff) < CastTime(regrowth) + GCDRemaining() or InCombat() } and Spell(regrowth) or Spell(tigers_fury) or ComboPoints() == 5 and Spell(rip)
}

### actions.cooldowns

AddFunction FeralCooldownsMainActions
{
 #prowl,if=buff.incarnation.remains<0.5&buff.jungle_stalker.up
 if BuffRemaining(incarnation_king_of_the_jungle_buff) < 0.5 and BuffPresent(jungle_stalker_buff) Spell(prowl)
}

AddFunction FeralCooldownsMainPostConditions
{
}

AddFunction FeralCooldownsShortCdActions
{
 unless BuffRemaining(incarnation_king_of_the_jungle_buff) < 0.5 and BuffPresent(jungle_stalker_buff) and Spell(prowl)
 {
  #tigers_fury,if=energy.deficit>=60
  if EnergyDeficit() >= 60 Spell(tigers_fury)
  #feral_frenzy,if=combo_points=0
  if ComboPoints() == 0 Spell(feral_frenzy)
 }
}

AddFunction FeralCooldownsShortCdPostConditions
{
 BuffRemaining(incarnation_king_of_the_jungle_buff) < 0.5 and BuffPresent(jungle_stalker_buff) and Spell(prowl)
}

AddFunction FeralCooldownsCdActions
{
 #dash,if=!buff.cat_form.up
 if not BuffPresent(cat_form_buff) Spell(dash)

 unless BuffRemaining(incarnation_king_of_the_jungle_buff) < 0.5 and BuffPresent(jungle_stalker_buff) and Spell(prowl)
 {
  #berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up)
  if Energy() >= 30 and { SpellCooldown(tigers_fury) > 5 or BuffPresent(tigers_fury_buff) } Spell(berserk)

  unless EnergyDeficit() >= 60 and Spell(tigers_fury)
  {
   #berserking
   Spell(berserking)

   unless ComboPoints() == 0 and Spell(feral_frenzy)
   {
    #incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up)
    if Energy() >= 30 and { SpellCooldown(tigers_fury) > 15 or BuffPresent(tigers_fury_buff) } Spell(incarnation_king_of_the_jungle)
    #potion,name=battle_potion_of_agility,if=target.time_to_die<65|(time_to_die<180&(buff.berserk.up|buff.incarnation.up))
    if { target.TimeToDie() < 65 or target.TimeToDie() < 180 and { BuffPresent(berserk_buff) or BuffPresent(incarnation_king_of_the_jungle_buff) } } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(battle_potion_of_agility usable=1)
    #shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
    if ComboPoints() < 5 and Energy() >= PowerCost(rake) and target.DebuffPersistentMultiplier(rake_debuff) < 2.1 and BuffPresent(tigers_fury_buff) and { BuffPresent(bloodtalons_buff) or not Talent(bloodtalons_talent) } and { not Talent(incarnation_talent) or SpellCooldown(incarnation_king_of_the_jungle) > 18 } and not BuffPresent(incarnation_king_of_the_jungle_buff) Spell(shadowmeld)
    #use_items
    FeralUseItemActions()
   }
  }
 }
}

AddFunction FeralCooldownsCdPostConditions
{
 BuffRemaining(incarnation_king_of_the_jungle_buff) < 0.5 and BuffPresent(jungle_stalker_buff) and Spell(prowl) or EnergyDeficit() >= 60 and Spell(tigers_fury) or ComboPoints() == 0 and Spell(feral_frenzy)
}

### actions.default

AddFunction FeralDefaultMainActions
{
 #run_action_list,name=opener,if=variable.opener_done=0
 if opener_done() == 0 FeralOpenerMainActions()

 unless opener_done() == 0 and FeralOpenerMainPostConditions()
 {
  #run_action_list,name=single_target
  FeralSingletargetMainActions()
 }
}

AddFunction FeralDefaultMainPostConditions
{
 opener_done() == 0 and FeralOpenerMainPostConditions() or FeralSingletargetMainPostConditions()
}

AddFunction FeralDefaultShortCdActions
{
 #auto_attack,if=!buff.prowl.up&!buff.shadowmeld.up
 if not BuffPresent(prowl_buff) and not BuffPresent(shadowmeld_buff) FeralGetInMeleeRange()
 #run_action_list,name=opener,if=variable.opener_done=0
 if opener_done() == 0 FeralOpenerShortCdActions()

 unless opener_done() == 0 and FeralOpenerShortCdPostConditions()
 {
  #run_action_list,name=single_target
  FeralSingletargetShortCdActions()
 }
}

AddFunction FeralDefaultShortCdPostConditions
{
 opener_done() == 0 and FeralOpenerShortCdPostConditions() or FeralSingletargetShortCdPostConditions()
}

AddFunction FeralDefaultCdActions
{
 FeralInterruptActions()
 #run_action_list,name=opener,if=variable.opener_done=0
 if opener_done() == 0 FeralOpenerCdActions()

 unless opener_done() == 0 and FeralOpenerCdPostConditions()
 {
  #run_action_list,name=single_target
  FeralSingletargetCdActions()
 }
}

AddFunction FeralDefaultCdPostConditions
{
 opener_done() == 0 and FeralOpenerCdPostConditions() or FeralSingletargetCdPostConditions()
}

### Feral icons.

AddCheckBox(opt_druid_feral_aoe L(AOE) default specialization=feral)

AddIcon checkbox=!opt_druid_feral_aoe enemies=1 help=shortcd specialization=feral
{
 if not InCombat() FeralPrecombatShortCdActions()
 unless not InCombat() and FeralPrecombatShortCdPostConditions()
 {
  FeralDefaultShortCdActions()
 }
}

AddIcon checkbox=opt_druid_feral_aoe help=shortcd specialization=feral
{
 if not InCombat() FeralPrecombatShortCdActions()
 unless not InCombat() and FeralPrecombatShortCdPostConditions()
 {
  FeralDefaultShortCdActions()
 }
}

AddIcon enemies=1 help=main specialization=feral
{
 if not InCombat() FeralPrecombatMainActions()
 unless not InCombat() and FeralPrecombatMainPostConditions()
 {
  FeralDefaultMainActions()
 }
}

AddIcon checkbox=opt_druid_feral_aoe help=aoe specialization=feral
{
 if not InCombat() FeralPrecombatMainActions()
 unless not InCombat() and FeralPrecombatMainPostConditions()
 {
  FeralDefaultMainActions()
 }
}

AddIcon checkbox=!opt_druid_feral_aoe enemies=1 help=cd specialization=feral
{
 if not InCombat() FeralPrecombatCdActions()
 unless not InCombat() and FeralPrecombatCdPostConditions()
 {
  FeralDefaultCdActions()
 }
}

AddIcon checkbox=opt_druid_feral_aoe help=cd specialization=feral
{
 if not InCombat() FeralPrecombatCdActions()
 unless not InCombat() and FeralPrecombatCdPostConditions()
 {
  FeralDefaultCdActions()
 }
}

### Required symbols
# battle_potion_of_agility
# berserk
# berserk_buff
# berserking
# bloodtalons_buff
# bloodtalons_talent
# brutal_slash
# cat_form
# cat_form_buff
# clearcasting_buff
# dash
# feral_frenzy
# ferocious_bite
# incarnation_king_of_the_jungle
# incarnation_king_of_the_jungle_buff
# incarnation_talent
# iron_jaws
# jungle_stalker_buff
# lunar_inspiration_talent
# maim
# mangle
# mighty_bash
# moonfire_cat
# moonfire_cat_debuff
# predatory_swiftness_buff
# primal_wrath
# prowl
# prowl_buff
# rake
# rake_debuff
# regrowth
# rip
# rip_debuff
# sabertooth_talent
# savage_roar
# savage_roar_buff
# scent_of_blood_buff
# scent_of_blood_talent
# shadowmeld
# shadowmeld_buff
# shred
# skull_bash
# swipe_cat
# thrash
# thrash_cat
# thrash_cat_debuff
# tigers_fury
# tigers_fury_buff
# typhoon
# war_stomp
# wild_charge
# wild_charge_bear
# wild_charge_cat
# wild_fleshrending_trait
]]
    OvaleScripts:RegisterScript("DRUID", "feral", name, desc, code, "script")
end
do
    local name = "sc_pr_druid_guardian"
    local desc = "[8.1] Simulationcraft: PR_Druid_Guardian"
    local code = [[
# Based on SimulationCraft profile "PR_Druid_Guardian".
#	class=druid
#	spec=guardian
#	talents=1111123

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_druid_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=guardian)
AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=guardian)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=guardian)

AddFunction GuardianInterruptActions
{
 if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
 {
  if target.InRange(skull_bash) and target.IsInterruptible() Spell(skull_bash)
  if target.InRange(mighty_bash) and not target.Classification(worldboss) Spell(mighty_bash)
  if target.Distance(less 10) and not target.Classification(worldboss) Spell(incapacitating_roar)
  if target.Distance(less 5) and not target.Classification(worldboss) Spell(war_stomp)
  if target.Distance(less 15) and not target.Classification(worldboss) Spell(typhoon)
 }
}

AddFunction GuardianUseItemActions
{
 Item(Trinket0Slot text=13 usable=1)
 Item(Trinket1Slot text=14 usable=1)
}

AddFunction GuardianGetInMeleeRange
{
 if CheckBoxOn(opt_melee_range) and Stance(druid_bear_form) and not target.InRange(mangle) or { Stance(druid_cat_form) or Stance(druid_claws_of_shirvallah) } and not target.InRange(shred)
 {
  if target.InRange(wild_charge) Spell(wild_charge)
  Texture(misc_arrowlup help=L(not_in_melee_range))
 }
}

### actions.precombat

AddFunction GuardianPrecombatMainActions
{
 #flask
 #food
 #augmentation
 #bear_form
 Spell(bear_form)
}

AddFunction GuardianPrecombatMainPostConditions
{
}

AddFunction GuardianPrecombatShortCdActions
{
}

AddFunction GuardianPrecombatShortCdPostConditions
{
 Spell(bear_form)
}

AddFunction GuardianPrecombatCdActions
{
 unless Spell(bear_form)
 {
  #snapshot_stats
  #potion
  if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(bursting_blood usable=1)
 }
}

AddFunction GuardianPrecombatCdPostConditions
{
 Spell(bear_form)
}

### actions.cooldowns

AddFunction GuardianCooldownsMainActions
{
}

AddFunction GuardianCooldownsMainPostConditions
{
}

AddFunction GuardianCooldownsShortCdActions
{
 #barkskin,if=buff.bear_form.up
 if DebuffPresent(bear_form) Spell(barkskin)
 #lunar_beam,if=buff.bear_form.up
 if DebuffPresent(bear_form) Spell(lunar_beam)
 #bristling_fur,if=buff.bear_form.up
 if DebuffPresent(bear_form) Spell(bristling_fur)
}

AddFunction GuardianCooldownsShortCdPostConditions
{
}

AddFunction GuardianCooldownsCdActions
{
 #potion
 if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(bursting_blood usable=1)
 #blood_fury
 Spell(blood_fury)
 #berserking
 Spell(berserking)
 #arcane_torrent
 Spell(arcane_torrent_energy)
 #lights_judgment
 Spell(lights_judgment)
 #fireblood
 Spell(fireblood)
 #ancestral_call
 Spell(ancestral_call)

 unless DebuffPresent(bear_form) and Spell(barkskin) or DebuffPresent(bear_form) and Spell(lunar_beam) or DebuffPresent(bear_form) and Spell(bristling_fur)
 {
  #use_items
  GuardianUseItemActions()
 }
}

AddFunction GuardianCooldownsCdPostConditions
{
 DebuffPresent(bear_form) and Spell(barkskin) or DebuffPresent(bear_form) and Spell(lunar_beam) or DebuffPresent(bear_form) and Spell(bristling_fur)
}

### actions.default

AddFunction GuardianDefaultMainActions
{
 #call_action_list,name=cooldowns
 GuardianCooldownsMainActions()

 unless GuardianCooldownsMainPostConditions()
 {
  #maul,if=rage.deficit<10&active_enemies<4
  if RageDeficit() < 10 and Enemies() < 4 Spell(maul)
  #ironfur,if=cost=0|(rage>cost&azerite.layered_mane.enabled&active_enemies>2)
  if PowerCost(ironfur) == 0 or Rage() > PowerCost(ironfur) and HasAzeriteTrait(layered_mane_trait) and Enemies() > 2 Spell(ironfur)
  #pulverize,target_if=dot.thrash_bear.stack=dot.thrash_bear.max_stacks
  if target.DebuffStacks(thrash_bear_debuff) == MaxStacks(thrash_bear_debuff) and target.DebuffGain(thrash_bear_debuff) <= BaseDuration(thrash_bear_debuff) Spell(pulverize)
  #moonfire,target_if=dot.moonfire.refreshable&active_enemies<2
  if target.DebuffRefreshable(moonfire_debuff) and Enemies() < 2 Spell(moonfire)
  #thrash,if=(buff.incarnation.down&active_enemies>1)|(buff.incarnation.up&active_enemies>4)
  if BuffExpires(incarnation_guardian_of_ursoc_buff) and Enemies() > 1 or BuffPresent(incarnation_guardian_of_ursoc_buff) and Enemies() > 4 Spell(thrash)
  #swipe,if=buff.incarnation.down&active_enemies>4
  if BuffExpires(incarnation_guardian_of_ursoc_buff) and Enemies() > 4 Spell(swipe)
  #mangle,if=dot.thrash_bear.ticking
  if target.DebuffPresent(thrash_bear_debuff) Spell(mangle)
  #moonfire,target_if=buff.galactic_guardian.up&active_enemies<2
  if BuffPresent(galactic_guardian_buff) and Enemies() < 2 Spell(moonfire)
  #thrash
  Spell(thrash)
  #maul
  Spell(maul)
  #moonfire,if=azerite.power_of_the_moon.rank>1&active_enemies=1
  if AzeriteTraitRank(power_of_the_moon_trait) > 1 and Enemies() == 1 Spell(moonfire)
  #swipe
  Spell(swipe)
 }
}

AddFunction GuardianDefaultMainPostConditions
{
 GuardianCooldownsMainPostConditions()
}

AddFunction GuardianDefaultShortCdActions
{
 #auto_attack
 GuardianGetInMeleeRange()
 #call_action_list,name=cooldowns
 GuardianCooldownsShortCdActions()
}

AddFunction GuardianDefaultShortCdPostConditions
{
 GuardianCooldownsShortCdPostConditions() or RageDeficit() < 10 and Enemies() < 4 and Spell(maul) or { PowerCost(ironfur) == 0 or Rage() > PowerCost(ironfur) and HasAzeriteTrait(layered_mane_trait) and Enemies() > 2 } and Spell(ironfur) or target.DebuffStacks(thrash_bear_debuff) == MaxStacks(thrash_bear_debuff) and target.DebuffGain(thrash_bear_debuff) <= BaseDuration(thrash_bear_debuff) and Spell(pulverize) or target.DebuffRefreshable(moonfire_debuff) and Enemies() < 2 and Spell(moonfire) or { BuffExpires(incarnation_guardian_of_ursoc_buff) and Enemies() > 1 or BuffPresent(incarnation_guardian_of_ursoc_buff) and Enemies() > 4 } and Spell(thrash) or BuffExpires(incarnation_guardian_of_ursoc_buff) and Enemies() > 4 and Spell(swipe) or target.DebuffPresent(thrash_bear_debuff) and Spell(mangle) or BuffPresent(galactic_guardian_buff) and Enemies() < 2 and Spell(moonfire) or Spell(thrash) or Spell(maul) or AzeriteTraitRank(power_of_the_moon_trait) > 1 and Enemies() == 1 and Spell(moonfire) or Spell(swipe)
}

AddFunction GuardianDefaultCdActions
{
 GuardianInterruptActions()
 #call_action_list,name=cooldowns
 GuardianCooldownsCdActions()

 unless GuardianCooldownsCdPostConditions() or RageDeficit() < 10 and Enemies() < 4 and Spell(maul) or { PowerCost(ironfur) == 0 or Rage() > PowerCost(ironfur) and HasAzeriteTrait(layered_mane_trait) and Enemies() > 2 } and Spell(ironfur) or target.DebuffStacks(thrash_bear_debuff) == MaxStacks(thrash_bear_debuff) and target.DebuffGain(thrash_bear_debuff) <= BaseDuration(thrash_bear_debuff) and Spell(pulverize) or target.DebuffRefreshable(moonfire_debuff) and Enemies() < 2 and Spell(moonfire)
 {
  #incarnation
  Spell(incarnation_guardian_of_ursoc)
 }
}

AddFunction GuardianDefaultCdPostConditions
{
 GuardianCooldownsCdPostConditions() or RageDeficit() < 10 and Enemies() < 4 and Spell(maul) or { PowerCost(ironfur) == 0 or Rage() > PowerCost(ironfur) and HasAzeriteTrait(layered_mane_trait) and Enemies() > 2 } and Spell(ironfur) or target.DebuffStacks(thrash_bear_debuff) == MaxStacks(thrash_bear_debuff) and target.DebuffGain(thrash_bear_debuff) <= BaseDuration(thrash_bear_debuff) and Spell(pulverize) or target.DebuffRefreshable(moonfire_debuff) and Enemies() < 2 and Spell(moonfire) or { BuffExpires(incarnation_guardian_of_ursoc_buff) and Enemies() > 1 or BuffPresent(incarnation_guardian_of_ursoc_buff) and Enemies() > 4 } and Spell(thrash) or BuffExpires(incarnation_guardian_of_ursoc_buff) and Enemies() > 4 and Spell(swipe) or target.DebuffPresent(thrash_bear_debuff) and Spell(mangle) or BuffPresent(galactic_guardian_buff) and Enemies() < 2 and Spell(moonfire) or Spell(thrash) or Spell(maul) or AzeriteTraitRank(power_of_the_moon_trait) > 1 and Enemies() == 1 and Spell(moonfire) or Spell(swipe)
}

### Guardian icons.

AddCheckBox(opt_druid_guardian_aoe L(AOE) default specialization=guardian)

AddIcon checkbox=!opt_druid_guardian_aoe enemies=1 help=shortcd specialization=guardian
{
 if not InCombat() GuardianPrecombatShortCdActions()
 unless not InCombat() and GuardianPrecombatShortCdPostConditions()
 {
  GuardianDefaultShortCdActions()
 }
}

AddIcon checkbox=opt_druid_guardian_aoe help=shortcd specialization=guardian
{
 if not InCombat() GuardianPrecombatShortCdActions()
 unless not InCombat() and GuardianPrecombatShortCdPostConditions()
 {
  GuardianDefaultShortCdActions()
 }
}

AddIcon enemies=1 help=main specialization=guardian
{
 if not InCombat() GuardianPrecombatMainActions()
 unless not InCombat() and GuardianPrecombatMainPostConditions()
 {
  GuardianDefaultMainActions()
 }
}

AddIcon checkbox=opt_druid_guardian_aoe help=aoe specialization=guardian
{
 if not InCombat() GuardianPrecombatMainActions()
 unless not InCombat() and GuardianPrecombatMainPostConditions()
 {
  GuardianDefaultMainActions()
 }
}

AddIcon checkbox=!opt_druid_guardian_aoe enemies=1 help=cd specialization=guardian
{
 if not InCombat() GuardianPrecombatCdActions()
 unless not InCombat() and GuardianPrecombatCdPostConditions()
 {
  GuardianDefaultCdActions()
 }
}

AddIcon checkbox=opt_druid_guardian_aoe help=cd specialization=guardian
{
 if not InCombat() GuardianPrecombatCdActions()
 unless not InCombat() and GuardianPrecombatCdPostConditions()
 {
  GuardianDefaultCdActions()
 }
}

### Required symbols
# ancestral_call
# arcane_torrent_energy
# barkskin
# bear_form
# berserking
# blood_fury
# bristling_fur
# bursting_blood
# fireblood
# galactic_guardian_buff
# incapacitating_roar
# incarnation_guardian_of_ursoc
# incarnation_guardian_of_ursoc_buff
# ironfur
# layered_mane_trait
# lights_judgment
# lunar_beam
# mangle
# maul
# mighty_bash
# moonfire
# moonfire_debuff
# power_of_the_moon_trait
# pulverize
# shred
# skull_bash
# swipe
# thrash
# thrash_bear_debuff
# typhoon
# war_stomp
# wild_charge
# wild_charge_bear
# wild_charge_cat
]]
    OvaleScripts:RegisterScript("DRUID", "guardian", name, desc, code, "script")
end
