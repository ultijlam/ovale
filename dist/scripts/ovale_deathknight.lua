local __exports = LibStub:NewLibrary("ovale/scripts/ovale_deathknight", 80300)
if not __exports then return end
__exports.registerDeathKnight = function(OvaleScripts)
    do
        local name = "sc_t25_death_knight_blood"
        local desc = "[9.0] Simulationcraft: T25_Death_Knight_Blood"
        local code = [[
# Based on SimulationCraft profile "T25_Death_Knight_Blood".
#	class=deathknight
#	spec=blood
#	talents=2220022

Include(ovale_common)
Include(ovale_deathknight_spells)

AddCheckBox(opt_interrupt l(interrupt) default specialization=blood)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=blood)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=blood)

AddFunction bloodinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(mind_freeze) and target.isinterruptible() spell(mind_freeze)
  if target.inrange(asphyxiate) and not target.classification(worldboss) spell(asphyxiate)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
 }
}

AddFunction blooduseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction bloodgetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(death_strike) texture(misc_arrowlup help=l(not_in_melee_range))
}

### actions.standard

AddFunction bloodstandardmainactions
{
 #death_strike,if=runic_power.deficit<=10
 if runicpowerdeficit() <= 10 spell(death_strike)
 #blooddrinker,if=!buff.dancing_rune_weapon.up
 if not buffpresent(dancing_rune_weapon) spell(blooddrinker)
 #marrowrend,if=(buff.bone_shield.remains<=rune.time_to_3|buff.bone_shield.remains<=(gcd+cooldown.blooddrinker.ready*talent.blooddrinker.enabled*2)|buff.bone_shield.stack<3)&runic_power.deficit>=20
 if { buffremaining(bone_shield) <= timetorunes(3) or buffremaining(bone_shield) <= gcd() + { spellcooldown(blooddrinker) == 0 } * talentpoints(blooddrinker_talent) * 2 or buffstacks(bone_shield) < 3 } and runicpowerdeficit() >= 20 spell(marrowrend)
 #blood_boil,if=charges_fractional>=1.8&(buff.hemostasis.stack<=(5-spell_targets.blood_boil)|spell_targets.blood_boil>2)
 if charges(blood_boil count=0) >= 1.8 and { buffstacks(hemostasis_buff) <= 5 - enemies() or enemies() > 2 } spell(blood_boil)
 #marrowrend,if=buff.bone_shield.stack<5&runic_power.deficit>=15
 if buffstacks(bone_shield) < 5 and runicpowerdeficit() >= 15 spell(marrowrend)
 #bonestorm,if=runic_power>=100&!buff.dancing_rune_weapon.up
 if runicpower() >= 100 and not buffpresent(dancing_rune_weapon) spell(bonestorm)
 #death_strike,if=runic_power.deficit<=(15+buff.dancing_rune_weapon.up*5+spell_targets.heart_strike*talent.heartbreaker.enabled*2)|target.1.time_to_die<10
 if runicpowerdeficit() <= 15 + buffpresent(dancing_rune_weapon) * 5 + enemies() * talentpoints(heartbreaker_talent) * 2 or target.timetodie() < 10 spell(death_strike)
 #death_and_decay,if=spell_targets.death_and_decay>=3
 if enemies() >= 3 spell(death_and_decay)
 #heart_strike,if=buff.dancing_rune_weapon.up|rune.time_to_4<gcd
 if buffpresent(dancing_rune_weapon) or timetorunes(4) < gcd() spell(heart_strike)
 #blood_boil,if=buff.dancing_rune_weapon.up
 if buffpresent(dancing_rune_weapon) spell(blood_boil)
 #death_and_decay,if=buff.crimson_scourge.up|talent.rapid_decomposition.enabled|spell_targets.death_and_decay>=2
 if buffpresent(crimson_scourge) or hastalent(rapid_decomposition_talent) or enemies() >= 2 spell(death_and_decay)
 #consumption
 spell(consumption)
 #blood_boil
 spell(blood_boil)
 #heart_strike,if=rune.time_to_3<gcd|buff.bone_shield.stack>6
 if timetorunes(3) < gcd() or buffstacks(bone_shield) > 6 spell(heart_strike)
}

AddFunction bloodstandardmainpostconditions
{
}

AddFunction bloodstandardshortcdactions
{
}

AddFunction bloodstandardshortcdpostconditions
{
 runicpowerdeficit() <= 10 and spell(death_strike) or not buffpresent(dancing_rune_weapon) and spell(blooddrinker) or { buffremaining(bone_shield) <= timetorunes(3) or buffremaining(bone_shield) <= gcd() + { spellcooldown(blooddrinker) == 0 } * talentpoints(blooddrinker_talent) * 2 or buffstacks(bone_shield) < 3 } and runicpowerdeficit() >= 20 and spell(marrowrend) or charges(blood_boil count=0) >= 1.8 and { buffstacks(hemostasis_buff) <= 5 - enemies() or enemies() > 2 } and spell(blood_boil) or buffstacks(bone_shield) < 5 and runicpowerdeficit() >= 15 and spell(marrowrend) or runicpower() >= 100 and not buffpresent(dancing_rune_weapon) and spell(bonestorm) or { runicpowerdeficit() <= 15 + buffpresent(dancing_rune_weapon) * 5 + enemies() * talentpoints(heartbreaker_talent) * 2 or target.timetodie() < 10 } and spell(death_strike) or enemies() >= 3 and spell(death_and_decay) or { buffpresent(dancing_rune_weapon) or timetorunes(4) < gcd() } and spell(heart_strike) or buffpresent(dancing_rune_weapon) and spell(blood_boil) or { buffpresent(crimson_scourge) or hastalent(rapid_decomposition_talent) or enemies() >= 2 } and spell(death_and_decay) or spell(consumption) or spell(blood_boil) or { timetorunes(3) < gcd() or buffstacks(bone_shield) > 6 } and spell(heart_strike)
}

AddFunction bloodstandardcdactions
{
 unless runicpowerdeficit() <= 10 and spell(death_strike) or not buffpresent(dancing_rune_weapon) and spell(blooddrinker) or { buffremaining(bone_shield) <= timetorunes(3) or buffremaining(bone_shield) <= gcd() + { spellcooldown(blooddrinker) == 0 } * talentpoints(blooddrinker_talent) * 2 or buffstacks(bone_shield) < 3 } and runicpowerdeficit() >= 20 and spell(marrowrend) or charges(blood_boil count=0) >= 1.8 and { buffstacks(hemostasis_buff) <= 5 - enemies() or enemies() > 2 } and spell(blood_boil) or buffstacks(bone_shield) < 5 and runicpowerdeficit() >= 15 and spell(marrowrend) or runicpower() >= 100 and not buffpresent(dancing_rune_weapon) and spell(bonestorm) or { runicpowerdeficit() <= 15 + buffpresent(dancing_rune_weapon) * 5 + enemies() * talentpoints(heartbreaker_talent) * 2 or target.timetodie() < 10 } and spell(death_strike) or enemies() >= 3 and spell(death_and_decay) or { buffpresent(dancing_rune_weapon) or timetorunes(4) < gcd() } and spell(heart_strike) or buffpresent(dancing_rune_weapon) and spell(blood_boil) or { buffpresent(crimson_scourge) or hastalent(rapid_decomposition_talent) or enemies() >= 2 } and spell(death_and_decay) or spell(consumption) or spell(blood_boil) or { timetorunes(3) < gcd() or buffstacks(bone_shield) > 6 } and spell(heart_strike)
 {
  #use_item,name=grongs_primal_rage
  blooduseitemactions()
  #arcane_torrent,if=runic_power.deficit>20
  if runicpowerdeficit() > 20 spell(arcane_torrent)
 }
}

AddFunction bloodstandardcdpostconditions
{
 runicpowerdeficit() <= 10 and spell(death_strike) or not buffpresent(dancing_rune_weapon) and spell(blooddrinker) or { buffremaining(bone_shield) <= timetorunes(3) or buffremaining(bone_shield) <= gcd() + { spellcooldown(blooddrinker) == 0 } * talentpoints(blooddrinker_talent) * 2 or buffstacks(bone_shield) < 3 } and runicpowerdeficit() >= 20 and spell(marrowrend) or charges(blood_boil count=0) >= 1.8 and { buffstacks(hemostasis_buff) <= 5 - enemies() or enemies() > 2 } and spell(blood_boil) or buffstacks(bone_shield) < 5 and runicpowerdeficit() >= 15 and spell(marrowrend) or runicpower() >= 100 and not buffpresent(dancing_rune_weapon) and spell(bonestorm) or { runicpowerdeficit() <= 15 + buffpresent(dancing_rune_weapon) * 5 + enemies() * talentpoints(heartbreaker_talent) * 2 or target.timetodie() < 10 } and spell(death_strike) or enemies() >= 3 and spell(death_and_decay) or { buffpresent(dancing_rune_weapon) or timetorunes(4) < gcd() } and spell(heart_strike) or buffpresent(dancing_rune_weapon) and spell(blood_boil) or { buffpresent(crimson_scourge) or hastalent(rapid_decomposition_talent) or enemies() >= 2 } and spell(death_and_decay) or spell(consumption) or spell(blood_boil) or { timetorunes(3) < gcd() or buffstacks(bone_shield) > 6 } and spell(heart_strike)
}

### actions.precombat

AddFunction bloodprecombatmainactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(potion_of_unbridled_fury_item usable=1)
}

AddFunction bloodprecombatmainpostconditions
{
}

AddFunction bloodprecombatshortcdactions
{
}

AddFunction bloodprecombatshortcdpostconditions
{
 checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
}

AddFunction bloodprecombatcdactions
{
 unless checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
 {
  #use_item,name=azsharas_font_of_power
  blooduseitemactions()
  #use_item,effect_name=cyclotronic_blast
  blooduseitemactions()
 }
}

AddFunction bloodprecombatcdpostconditions
{
 checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
}

### actions.essences

AddFunction bloodessencesmainactions
{
 #concentrated_flame,if=dot.concentrated_flame_burn.remains<2&!buff.dancing_rune_weapon.up
 if target.debuffremaining(concentrated_flame_burn_debuff) < 2 and not buffpresent(dancing_rune_weapon) spell(concentrated_flame)
 #memory_of_lucid_dreams,if=rune.time_to_1>gcd&runic_power<40
 if timetorunes(1) > gcd() and runicpower() < 40 spell(memory_of_lucid_dreams)
 #worldvein_resonance
 spell(worldvein_resonance)
 #ripple_in_space,if=!buff.dancing_rune_weapon.up
 if not buffpresent(dancing_rune_weapon) spell(ripple_in_space)
}

AddFunction bloodessencesmainpostconditions
{
}

AddFunction bloodessencesshortcdactions
{
}

AddFunction bloodessencesshortcdpostconditions
{
 target.debuffremaining(concentrated_flame_burn_debuff) < 2 and not buffpresent(dancing_rune_weapon) and spell(concentrated_flame) or timetorunes(1) > gcd() and runicpower() < 40 and spell(memory_of_lucid_dreams) or spell(worldvein_resonance) or not buffpresent(dancing_rune_weapon) and spell(ripple_in_space)
}

AddFunction bloodessencescdactions
{
 unless target.debuffremaining(concentrated_flame_burn_debuff) < 2 and not buffpresent(dancing_rune_weapon) and spell(concentrated_flame)
 {
  #anima_of_death,if=buff.vampiric_blood.up&(raid_event.adds.exists|raid_event.adds.in>15)
  if buffpresent(vampiric_blood) and { false(raid_event_adds_exists) or 600 > 15 } spell(anima_of_death)
 }
}

AddFunction bloodessencescdpostconditions
{
 target.debuffremaining(concentrated_flame_burn_debuff) < 2 and not buffpresent(dancing_rune_weapon) and spell(concentrated_flame) or timetorunes(1) > gcd() and runicpower() < 40 and spell(memory_of_lucid_dreams) or spell(worldvein_resonance) or not buffpresent(dancing_rune_weapon) and spell(ripple_in_space)
}

### actions.default

AddFunction blood_defaultmainactions
{
 #berserking
 spell(berserking)
 #potion,if=buff.dancing_rune_weapon.up
 if buffpresent(dancing_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) item(potion_of_unbridled_fury_item usable=1)
 #tombstone,if=buff.bone_shield.stack>=7
 if buffstacks(bone_shield) >= 7 spell(tombstone)
 #call_action_list,name=essences
 bloodessencesmainactions()

 unless bloodessencesmainpostconditions()
 {
  #call_action_list,name=standard
  bloodstandardmainactions()
 }
}

AddFunction blood_defaultmainpostconditions
{
 bloodessencesmainpostconditions() or bloodstandardmainpostconditions()
}

AddFunction blood_defaultshortcdactions
{
 #auto_attack
 bloodgetinmeleerange()

 unless spell(berserking)
 {
  #bag_of_tricks
  spell(bag_of_tricks)
  #vampiric_blood
  spell(vampiric_blood)

  unless buffpresent(dancing_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or buffstacks(bone_shield) >= 7 and spell(tombstone)
  {
   #call_action_list,name=essences
   bloodessencesshortcdactions()

   unless bloodessencesshortcdpostconditions()
   {
    #call_action_list,name=standard
    bloodstandardshortcdactions()
   }
  }
 }
}

AddFunction blood_defaultshortcdpostconditions
{
 spell(berserking) or buffpresent(dancing_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or buffstacks(bone_shield) >= 7 and spell(tombstone) or bloodessencesshortcdpostconditions() or bloodstandardshortcdpostconditions()
}

AddFunction blood_defaultcdactions
{
 bloodinterruptactions()
 #blood_fury,if=cooldown.dancing_rune_weapon.ready&(!cooldown.blooddrinker.ready|!talent.blooddrinker.enabled)
 if spellcooldown(dancing_rune_weapon) == 0 and { not spellcooldown(blooddrinker) == 0 or not hastalent(blooddrinker_talent) } spell(blood_fury)

 unless spell(berserking)
 {
  #arcane_pulse,if=active_enemies>=2|rune<1&runic_power.deficit>60
  if enemies() >= 2 or runecount() < 1 and runicpowerdeficit() > 60 spell(arcane_pulse)
  #lights_judgment,if=buff.unholy_strength.up
  if buffpresent(unholy_strength) spell(lights_judgment)
  #ancestral_call
  spell(ancestral_call)
  #fireblood
  spell(fireblood)

  unless spell(bag_of_tricks)
  {
   #use_items,if=cooldown.dancing_rune_weapon.remains>90
   if spellcooldown(dancing_rune_weapon) > 90 blooduseitemactions()
   #use_item,name=razdunks_big_red_button
   blooduseitemactions()
   #use_item,effect_name=cyclotronic_blast,if=cooldown.dancing_rune_weapon.remains&!buff.dancing_rune_weapon.up&rune.time_to_4>cast_time
   if spellcooldown(dancing_rune_weapon) > 0 and not buffpresent(dancing_rune_weapon) and timetorunes(4) > casttime(use_item) blooduseitemactions()
   #use_item,name=azsharas_font_of_power,if=(cooldown.dancing_rune_weapon.remains<5&target.time_to_die>15)|(target.time_to_die<34)
   if spellcooldown(dancing_rune_weapon) < 5 and target.timetodie() > 15 or target.timetodie() < 34 blooduseitemactions()
   #use_item,name=merekthas_fang,if=(cooldown.dancing_rune_weapon.remains&!buff.dancing_rune_weapon.up&rune.time_to_4>3)&!raid_event.adds.exists|raid_event.adds.in>15
   if spellcooldown(dancing_rune_weapon) > 0 and not buffpresent(dancing_rune_weapon) and timetorunes(4) > 3 and not false(raid_event_adds_exists) or 600 > 15 blooduseitemactions()
   #use_item,name=ashvanes_razor_coral,if=debuff.razor_coral_debuff.down
   if target.debuffexpires(razor_coral) blooduseitemactions()
   #use_item,name=ashvanes_razor_coral,if=target.health.pct<31&equipped.dribbling_inkpod
   if target.healthpercent() < 31 and hasequippeditem(dribbling_inkpod_item) blooduseitemactions()
   #use_item,name=ashvanes_razor_coral,if=buff.dancing_rune_weapon.up&debuff.razor_coral_debuff.up&!equipped.dribbling_inkpod
   if buffpresent(dancing_rune_weapon) and target.debuffpresent(razor_coral) and not hasequippeditem(dribbling_inkpod_item) blooduseitemactions()

   unless spell(vampiric_blood) or buffpresent(dancing_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
   {
    #dancing_rune_weapon,if=!talent.blooddrinker.enabled|!cooldown.blooddrinker.ready
    if not hastalent(blooddrinker_talent) or not spellcooldown(blooddrinker) == 0 spell(dancing_rune_weapon)

    unless buffstacks(bone_shield) >= 7 and spell(tombstone)
    {
     #call_action_list,name=essences
     bloodessencescdactions()

     unless bloodessencescdpostconditions()
     {
      #call_action_list,name=standard
      bloodstandardcdactions()
     }
    }
   }
  }
 }
}

AddFunction blood_defaultcdpostconditions
{
 spell(berserking) or spell(bag_of_tricks) or spell(vampiric_blood) or buffpresent(dancing_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or buffstacks(bone_shield) >= 7 and spell(tombstone) or bloodessencescdpostconditions() or bloodstandardcdpostconditions()
}

### Blood icons.

AddCheckBox(opt_deathknight_blood_aoe l(aoe) default specialization=blood)

AddIcon checkbox=!opt_deathknight_blood_aoe enemies=1 help=shortcd specialization=blood
{
 if not incombat() bloodprecombatshortcdactions()
 blood_defaultshortcdactions()
}

AddIcon checkbox=opt_deathknight_blood_aoe help=shortcd specialization=blood
{
 if not incombat() bloodprecombatshortcdactions()
 blood_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=blood
{
 if not incombat() bloodprecombatmainactions()
 blood_defaultmainactions()
}

AddIcon checkbox=opt_deathknight_blood_aoe help=aoe specialization=blood
{
 if not incombat() bloodprecombatmainactions()
 blood_defaultmainactions()
}

AddIcon checkbox=!opt_deathknight_blood_aoe enemies=1 help=cd specialization=blood
{
 if not incombat() bloodprecombatcdactions()
 blood_defaultcdactions()
}

AddIcon checkbox=opt_deathknight_blood_aoe help=cd specialization=blood
{
 if not incombat() bloodprecombatcdactions()
 blood_defaultcdactions()
}

### Required symbols
# ancestral_call
# anima_of_death
# arcane_pulse
# arcane_torrent
# asphyxiate
# bag_of_tricks
# berserking
# blood_boil
# blood_fury
# blooddrinker
# blooddrinker_talent
# bone_shield
# bonestorm
# concentrated_flame
# concentrated_flame_burn_debuff
# consumption
# crimson_scourge
# dancing_rune_weapon
# death_and_decay
# death_strike
# dribbling_inkpod_item
# fireblood
# heart_strike
# heartbreaker_talent
# hemostasis_buff
# lights_judgment
# marrowrend
# memory_of_lucid_dreams
# mind_freeze
# potion_of_unbridled_fury_item
# rapid_decomposition_talent
# razor_coral
# ripple_in_space
# tombstone
# unholy_strength
# vampiric_blood
# war_stomp
# worldvein_resonance
]]
        OvaleScripts:RegisterScript("DEATHKNIGHT", "blood", name, desc, code, "script")
    end
    do
        local name = "sc_t25_death_knight_frost"
        local desc = "[9.0] Simulationcraft: T25_Death_Knight_Frost"
        local code = [[
# Based on SimulationCraft profile "T25_Death_Knight_Frost".
#	class=deathknight
#	spec=frost
#	talents=3102013

Include(ovale_common)
Include(ovale_deathknight_spells)

AddCheckBox(opt_interrupt l(interrupt) default specialization=frost)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=frost)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=frost)

AddFunction frostinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(mind_freeze) and target.isinterruptible() spell(mind_freeze)
  if target.distance(less 12) and not target.classification(worldboss) spell(blinding_sleet)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
 }
}

AddFunction frostuseheartessence
{
 spell(concentrated_flame_essence)
}

AddFunction frostuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction frostgetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(death_strike) texture(misc_arrowlup help=l(not_in_melee_range))
}

### actions.standard

AddFunction froststandardmainactions
{
 #remorseless_winter,if=talent.gathering_storm.enabled|conduit.everfrost.enabled|runeforge.biting_cold.equipped
 if hastalent(gathering_storm_talent) or conduit(everfrost_conduit) or equippedruneforge(biting_cold_runeforge) spell(remorseless_winter)
 #glacial_advance,if=!death_knight.runeforge.razorice&(debuff.razorice.stack<5|debuff.razorice.remains<7)
 if not message("death_knight.runeforge.razorice is not implemented") and { target.debuffstacks(razorice) < 5 or target.debuffremaining(razorice) < 7 } spell(glacial_advance)
 #frost_strike,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
 if spellcooldown(remorseless_winter) <= 2 * gcd() and hastalent(gathering_storm_talent) spell(frost_strike)
 #frost_strike,if=conduit.unleashed_frenzy.enabled&buff.unleashed_frenzy.remains<3|conduit.eradicating_blow.enabled&buff.eradicating_blow.stack=2
 if conduit(unleashed_frenzy_conduit) and buffremaining(unleashed_frenzy_buff) < 3 or conduit(eradicating_blow_conduit) and buffstacks(eradicating_blow) == 2 spell(frost_strike)
 #howling_blast,if=buff.rime.up
 if buffpresent(rime_buff) spell(howling_blast)
 #obliterate,if=!buff.frozen_pulse.up&talent.frozen_pulse.enabled
 if not buffpresent(frozen_pulse_buff) and hastalent(frozen_pulse_talent) spell(obliterate)
 #frost_strike,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
 if runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 spell(frost_strike)
 #frostscythe,if=buff.killing_machine.up&rune.time_to_4>=gcd
 if buffpresent(killing_machine_buff) and timetorunes(4) >= gcd() spell(frostscythe)
 #obliterate,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
 if runicpowerdeficit() > 25 + talentpoints(runic_attenuation_talent) * 3 spell(obliterate)
 #frost_strike
 spell(frost_strike)
 #horn_of_winter
 spell(horn_of_winter)
}

AddFunction froststandardmainpostconditions
{
}

AddFunction froststandardshortcdactions
{
}

AddFunction froststandardshortcdpostconditions
{
 { hastalent(gathering_storm_talent) or conduit(everfrost_conduit) or equippedruneforge(biting_cold_runeforge) } and spell(remorseless_winter) or not message("death_knight.runeforge.razorice is not implemented") and { target.debuffstacks(razorice) < 5 or target.debuffremaining(razorice) < 7 } and spell(glacial_advance) or spellcooldown(remorseless_winter) <= 2 * gcd() and hastalent(gathering_storm_talent) and spell(frost_strike) or { conduit(unleashed_frenzy_conduit) and buffremaining(unleashed_frenzy_buff) < 3 or conduit(eradicating_blow_conduit) and buffstacks(eradicating_blow) == 2 } and spell(frost_strike) or buffpresent(rime_buff) and spell(howling_blast) or not buffpresent(frozen_pulse_buff) and hastalent(frozen_pulse_talent) and spell(obliterate) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(frost_strike) or buffpresent(killing_machine_buff) and timetorunes(4) >= gcd() and spell(frostscythe) or runicpowerdeficit() > 25 + talentpoints(runic_attenuation_talent) * 3 and spell(obliterate) or spell(frost_strike) or spell(horn_of_winter)
}

AddFunction froststandardcdactions
{
 unless { hastalent(gathering_storm_talent) or conduit(everfrost_conduit) or equippedruneforge(biting_cold_runeforge) } and spell(remorseless_winter) or not message("death_knight.runeforge.razorice is not implemented") and { target.debuffstacks(razorice) < 5 or target.debuffremaining(razorice) < 7 } and spell(glacial_advance) or spellcooldown(remorseless_winter) <= 2 * gcd() and hastalent(gathering_storm_talent) and spell(frost_strike) or { conduit(unleashed_frenzy_conduit) and buffremaining(unleashed_frenzy_buff) < 3 or conduit(eradicating_blow_conduit) and buffstacks(eradicating_blow) == 2 } and spell(frost_strike) or buffpresent(rime_buff) and spell(howling_blast) or not buffpresent(frozen_pulse_buff) and hastalent(frozen_pulse_talent) and spell(obliterate) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(frost_strike) or buffpresent(killing_machine_buff) and timetorunes(4) >= gcd() and spell(frostscythe) or runicpowerdeficit() > 25 + talentpoints(runic_attenuation_talent) * 3 and spell(obliterate) or spell(frost_strike) or spell(horn_of_winter)
 {
  #arcane_torrent
  spell(arcane_torrent)
 }
}

AddFunction froststandardcdpostconditions
{
 { hastalent(gathering_storm_talent) or conduit(everfrost_conduit) or equippedruneforge(biting_cold_runeforge) } and spell(remorseless_winter) or not message("death_knight.runeforge.razorice is not implemented") and { target.debuffstacks(razorice) < 5 or target.debuffremaining(razorice) < 7 } and spell(glacial_advance) or spellcooldown(remorseless_winter) <= 2 * gcd() and hastalent(gathering_storm_talent) and spell(frost_strike) or { conduit(unleashed_frenzy_conduit) and buffremaining(unleashed_frenzy_buff) < 3 or conduit(eradicating_blow_conduit) and buffstacks(eradicating_blow) == 2 } and spell(frost_strike) or buffpresent(rime_buff) and spell(howling_blast) or not buffpresent(frozen_pulse_buff) and hastalent(frozen_pulse_talent) and spell(obliterate) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(frost_strike) or buffpresent(killing_machine_buff) and timetorunes(4) >= gcd() and spell(frostscythe) or runicpowerdeficit() > 25 + talentpoints(runic_attenuation_talent) * 3 and spell(obliterate) or spell(frost_strike) or spell(horn_of_winter)
}

### actions.precombat

AddFunction frostprecombatmainactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(potion_of_unbridled_fury_item usable=1)
}

AddFunction frostprecombatmainpostconditions
{
}

AddFunction frostprecombatshortcdactions
{
}

AddFunction frostprecombatshortcdpostconditions
{
 checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
}

AddFunction frostprecombatcdactions
{
}

AddFunction frostprecombatcdpostconditions
{
 checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
}

### actions.obliteration

AddFunction frostobliterationmainactions
{
 #remorseless_winter,if=talent.gathering_storm.enabled&active_enemies>=3
 if hastalent(gathering_storm_talent) and enemies() >= 3 spell(remorseless_winter)
 #howling_blast,if=!dot.frost_fever.ticking&!buff.killing_machine.up
 if not target.debuffpresent(frost_fever) and not buffpresent(killing_machine_buff) spell(howling_blast)
 #frostscythe,if=buff.killing_machine.react&spell_targets.frostscythe>=2
 if buffpresent(killing_machine_buff) and enemies() >= 2 spell(frostscythe)
 #obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=buff.killing_machine.react|!buff.rime.up&spell_targets.howling_blast>=3
 if buffpresent(killing_machine_buff) or not buffpresent(rime_buff) and enemies() >= 3 spell(obliterate)
 #glacial_advance,if=spell_targets.glacial_advance>=2&(runic_power.deficit<10|rune.time_to_2>gcd)|(debuff.razorice.stack<5|debuff.razorice.remains<15)
 if enemies() >= 2 and { runicpowerdeficit() < 10 or timetorunes(2) > gcd() } or target.debuffstacks(razorice) < 5 or target.debuffremaining(razorice) < 15 spell(glacial_advance)
 #frost_strike,if=conduit.eradicating_blow.enabled&buff.eradicating_blow.stack=2&active_enemies=1
 if conduit(eradicating_blow_conduit) and buffstacks(eradicating_blow) == 2 and enemies() == 1 spell(frost_strike)
 #howling_blast,if=buff.rime.up&spell_targets.howling_blast>=2
 if buffpresent(rime_buff) and enemies() >= 2 spell(howling_blast)
 #glacial_advance,if=spell_targets.glacial_advance>=2
 if enemies() >= 2 spell(glacial_advance)
 #frost_strike,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=runic_power.deficit<10|rune.time_to_2>gcd|!buff.rime.up
 if runicpowerdeficit() < 10 or timetorunes(2) > gcd() or not buffpresent(rime_buff) spell(frost_strike)
 #howling_blast,if=buff.rime.up
 if buffpresent(rime_buff) spell(howling_blast)
 #obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice
 spell(obliterate)
}

AddFunction frostobliterationmainpostconditions
{
}

AddFunction frostobliterationshortcdactions
{
}

AddFunction frostobliterationshortcdpostconditions
{
 hastalent(gathering_storm_talent) and enemies() >= 3 and spell(remorseless_winter) or not target.debuffpresent(frost_fever) and not buffpresent(killing_machine_buff) and spell(howling_blast) or buffpresent(killing_machine_buff) and enemies() >= 2 and spell(frostscythe) or { buffpresent(killing_machine_buff) or not buffpresent(rime_buff) and enemies() >= 3 } and spell(obliterate) or { enemies() >= 2 and { runicpowerdeficit() < 10 or timetorunes(2) > gcd() } or target.debuffstacks(razorice) < 5 or target.debuffremaining(razorice) < 15 } and spell(glacial_advance) or conduit(eradicating_blow_conduit) and buffstacks(eradicating_blow) == 2 and enemies() == 1 and spell(frost_strike) or buffpresent(rime_buff) and enemies() >= 2 and spell(howling_blast) or enemies() >= 2 and spell(glacial_advance) or { runicpowerdeficit() < 10 or timetorunes(2) > gcd() or not buffpresent(rime_buff) } and spell(frost_strike) or buffpresent(rime_buff) and spell(howling_blast) or spell(obliterate)
}

AddFunction frostobliterationcdactions
{
}

AddFunction frostobliterationcdpostconditions
{
 hastalent(gathering_storm_talent) and enemies() >= 3 and spell(remorseless_winter) or not target.debuffpresent(frost_fever) and not buffpresent(killing_machine_buff) and spell(howling_blast) or buffpresent(killing_machine_buff) and enemies() >= 2 and spell(frostscythe) or { buffpresent(killing_machine_buff) or not buffpresent(rime_buff) and enemies() >= 3 } and spell(obliterate) or { enemies() >= 2 and { runicpowerdeficit() < 10 or timetorunes(2) > gcd() } or target.debuffstacks(razorice) < 5 or target.debuffremaining(razorice) < 15 } and spell(glacial_advance) or conduit(eradicating_blow_conduit) and buffstacks(eradicating_blow) == 2 and enemies() == 1 and spell(frost_strike) or buffpresent(rime_buff) and enemies() >= 2 and spell(howling_blast) or enemies() >= 2 and spell(glacial_advance) or { runicpowerdeficit() < 10 or timetorunes(2) > gcd() or not buffpresent(rime_buff) } and spell(frost_strike) or buffpresent(rime_buff) and spell(howling_blast) or spell(obliterate)
}

### actions.cooldowns

AddFunction frostcooldownsmainactions
{
 #potion,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
 if buffpresent(pillar_of_frost) and buffpresent(empower_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) item(potion_of_unbridled_fury_item usable=1)
 #berserking,if=buff.pillar_of_frost.up
 if buffpresent(pillar_of_frost) spell(berserking)
 #breath_of_sindragosa,if=buff.pillar_of_frost.up
 if buffpresent(pillar_of_frost) spell(breath_of_sindragosa)
 #hypothermic_presence,if=talent.breath_of_sindragosa.enabled&runic_power.deficit>40&rune>=3&buff.pillar_of_frost.up|!talent.breath_of_sindragosa.enabled&runic_power.deficit>=25
 if hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() > 40 and runecount() >= 3 and buffpresent(pillar_of_frost) or not hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() >= 25 spell(hypothermic_presence)
}

AddFunction frostcooldownsmainpostconditions
{
}

AddFunction frostcooldownsshortcdactions
{
 unless buffpresent(pillar_of_frost) and buffpresent(empower_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or buffpresent(pillar_of_frost) and spell(berserking)
 {
  #bag_of_tricks,if=buff.pillar_of_frost.up&(buff.pillar_of_frost.remains<5&talent.cold_heart.enabled|!talent.cold_heart.enabled&buff.pillar_of_frost.remains<3)&active_enemies=1
  if buffpresent(pillar_of_frost) and { buffremaining(pillar_of_frost) < 5 and hastalent(cold_heart_talent) or not hastalent(cold_heart_talent) and buffremaining(pillar_of_frost) < 3 } and enemies() == 1 spell(bag_of_tricks)
  #pillar_of_frost,if=talent.breath_of_sindragosa.enabled&(cooldown.breath_of_sindragosa.remains|cooldown.breath_of_sindragosa.ready&runic_power.deficit<60)
  if hastalent(breath_of_sindragosa_talent) and { spellcooldown(breath_of_sindragosa) > 0 or spellcooldown(breath_of_sindragosa) == 0 and runicpowerdeficit() < 60 } spell(pillar_of_frost)
  #pillar_of_frost,if=talent.icecap.enabled&!buff.pillar_of_frost.up
  if hastalent(icecap_talent) and not buffpresent(pillar_of_frost) spell(pillar_of_frost)
  #pillar_of_frost,if=talent.obliteration.enabled&(talent.gathering_storm.enabled&buff.remorseless_winter.up|!talent.gathering_storm.enabled)
  if hastalent(obliteration_talent) and { hastalent(gathering_storm_talent) and buffpresent(remorseless_winter) or not hastalent(gathering_storm_talent) } spell(pillar_of_frost)
 }
}

AddFunction frostcooldownsshortcdpostconditions
{
 buffpresent(pillar_of_frost) and buffpresent(empower_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or buffpresent(pillar_of_frost) and spell(berserking) or buffpresent(pillar_of_frost) and spell(breath_of_sindragosa) or { hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() > 40 and runecount() >= 3 and buffpresent(pillar_of_frost) or not hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() >= 25 } and spell(hypothermic_presence)
}

AddFunction frostcooldownscdactions
{
 #use_items,if=cooldown.pillar_of_frost.ready|cooldown.pillar_of_frost.remains>20
 if spellcooldown(pillar_of_frost) == 0 or spellcooldown(pillar_of_frost) > 20 frostuseitemactions()

 unless buffpresent(pillar_of_frost) and buffpresent(empower_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
 {
  #blood_fury,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
  if buffpresent(pillar_of_frost) and buffpresent(empower_rune_weapon) spell(blood_fury)

  unless buffpresent(pillar_of_frost) and spell(berserking)
  {
   #arcane_pulse,if=(!buff.pillar_of_frost.up&active_enemies>=2)|!buff.pillar_of_frost.up&(rune.deficit>=5&runic_power.deficit>=60)
   if not buffpresent(pillar_of_frost) and enemies() >= 2 or not buffpresent(pillar_of_frost) and runedeficit() >= 5 and runicpowerdeficit() >= 60 spell(arcane_pulse)
   #lights_judgment,if=buff.pillar_of_frost.up
   if buffpresent(pillar_of_frost) spell(lights_judgment)
   #ancestral_call,if=buff.pillar_of_frost.up&buff.empower_rune_weapon.up
   if buffpresent(pillar_of_frost) and buffpresent(empower_rune_weapon) spell(ancestral_call)
   #fireblood,if=buff.pillar_of_frost.remains<=8&buff.empower_rune_weapon.up
   if buffremaining(pillar_of_frost) <= 8 and buffpresent(empower_rune_weapon) spell(fireblood)

   unless buffpresent(pillar_of_frost) and { buffremaining(pillar_of_frost) < 5 and hastalent(cold_heart_talent) or not hastalent(cold_heart_talent) and buffremaining(pillar_of_frost) < 3 } and enemies() == 1 and spell(bag_of_tricks)
   {
    #empower_rune_weapon,if=talent.obliteration.enabled&(cooldown.pillar_of_frost.ready&rune.time_to_5>gcd&runic_power.deficit>=10|buff.pillar_of_frost.up&rune.time_to_5>gcd)|fight_remains<20
    if hastalent(obliteration_talent) and { spellcooldown(pillar_of_frost) == 0 and timetorunes(5) > gcd() and runicpowerdeficit() >= 10 or buffpresent(pillar_of_frost) and timetorunes(5) > gcd() } or fightremains() < 20 spell(empower_rune_weapon)
    #empower_rune_weapon,if=talent.breath_of_sindragosa.enabled&runic_power.deficit>40&rune.time_to_5>gcd&(buff.breath_of_sindragosa.up|fight_remains<20)
    if hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() > 40 and timetorunes(5) > gcd() and { buffpresent(breath_of_sindragosa) or fightremains() < 20 } spell(empower_rune_weapon)
    #empower_rune_weapon,if=talent.icecap.enabled&rune<3
    if hastalent(icecap_talent) and runecount() < 3 spell(empower_rune_weapon)

    unless hastalent(breath_of_sindragosa_talent) and { spellcooldown(breath_of_sindragosa) > 0 or spellcooldown(breath_of_sindragosa) == 0 and runicpowerdeficit() < 60 } and spell(pillar_of_frost) or hastalent(icecap_talent) and not buffpresent(pillar_of_frost) and spell(pillar_of_frost) or hastalent(obliteration_talent) and { hastalent(gathering_storm_talent) and buffpresent(remorseless_winter) or not hastalent(gathering_storm_talent) } and spell(pillar_of_frost) or buffpresent(pillar_of_frost) and spell(breath_of_sindragosa)
    {
     #frostwyrms_fury,if=buff.pillar_of_frost.remains<gcd&buff.pillar_of_frost.up&!talent.obliteration.enabled
     if buffremaining(pillar_of_frost) < gcd() and buffpresent(pillar_of_frost) and not hastalent(obliteration_talent) spell(frostwyrms_fury)
     #frostwyrms_fury,if=active_enemies>=2&cooldown.pillar_of_frost.remains+15>target.time_to_die|fight_remains<gcd
     if enemies() >= 2 and spellcooldown(pillar_of_frost) + 15 > target.timetodie() or fightremains() < gcd() spell(frostwyrms_fury)
     #frostwyrms_fury,if=talent.obliteration.enabled&!buff.pillar_of_frost.up&((buff.unholy_strength.up|!death_knight.runeforge.fallen_crusader)&(debuff.razorice.stack=5|!death_knight.runeforge.razorice))
     if hastalent(obliteration_talent) and not buffpresent(pillar_of_frost) and { buffpresent(unholy_strength) or not message("death_knight.runeforge.fallen_crusader is not implemented") } and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } spell(frostwyrms_fury)

     unless { hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() > 40 and runecount() >= 3 and buffpresent(pillar_of_frost) or not hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() >= 25 } and spell(hypothermic_presence)
     {
      #raise_dead,if=buff.pillar_of_frost.up
      if buffpresent(pillar_of_frost) spell(raise_dead)
      #heart_essence
      frostuseheartessence()
     }
    }
   }
  }
 }
}

AddFunction frostcooldownscdpostconditions
{
 buffpresent(pillar_of_frost) and buffpresent(empower_rune_weapon) and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or buffpresent(pillar_of_frost) and spell(berserking) or buffpresent(pillar_of_frost) and { buffremaining(pillar_of_frost) < 5 and hastalent(cold_heart_talent) or not hastalent(cold_heart_talent) and buffremaining(pillar_of_frost) < 3 } and enemies() == 1 and spell(bag_of_tricks) or hastalent(breath_of_sindragosa_talent) and { spellcooldown(breath_of_sindragosa) > 0 or spellcooldown(breath_of_sindragosa) == 0 and runicpowerdeficit() < 60 } and spell(pillar_of_frost) or hastalent(icecap_talent) and not buffpresent(pillar_of_frost) and spell(pillar_of_frost) or hastalent(obliteration_talent) and { hastalent(gathering_storm_talent) and buffpresent(remorseless_winter) or not hastalent(gathering_storm_talent) } and spell(pillar_of_frost) or buffpresent(pillar_of_frost) and spell(breath_of_sindragosa) or { hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() > 40 and runecount() >= 3 and buffpresent(pillar_of_frost) or not hastalent(breath_of_sindragosa_talent) and runicpowerdeficit() >= 25 } and spell(hypothermic_presence)
}

### actions.cold_heart

AddFunction frostcold_heartmainactions
{
 #chains_of_ice,if=fight_remains<gcd|buff.pillar_of_frost.remains<3&buff.cold_heart.stack=20&!talent.obliteration.enabled
 if fightremains() < gcd() or buffremaining(pillar_of_frost) < 3 and buffstacks(cold_heart_buff) == 20 and not hastalent(obliteration_talent) spell(chains_of_ice)
 #chains_of_ice,if=talent.obliteration.enabled&!buff.pillar_of_frost.up&(buff.cold_heart.stack>=16&buff.unholy_strength.up|buff.cold_heart.stack>=19)
 if hastalent(obliteration_talent) and not buffpresent(pillar_of_frost) and { buffstacks(cold_heart_buff) >= 16 and buffpresent(unholy_strength) or buffstacks(cold_heart_buff) >= 19 } spell(chains_of_ice)
}

AddFunction frostcold_heartmainpostconditions
{
}

AddFunction frostcold_heartshortcdactions
{
}

AddFunction frostcold_heartshortcdpostconditions
{
 { fightremains() < gcd() or buffremaining(pillar_of_frost) < 3 and buffstacks(cold_heart_buff) == 20 and not hastalent(obliteration_talent) } and spell(chains_of_ice) or hastalent(obliteration_talent) and not buffpresent(pillar_of_frost) and { buffstacks(cold_heart_buff) >= 16 and buffpresent(unholy_strength) or buffstacks(cold_heart_buff) >= 19 } and spell(chains_of_ice)
}

AddFunction frostcold_heartcdactions
{
}

AddFunction frostcold_heartcdpostconditions
{
 { fightremains() < gcd() or buffremaining(pillar_of_frost) < 3 and buffstacks(cold_heart_buff) == 20 and not hastalent(obliteration_talent) } and spell(chains_of_ice) or hastalent(obliteration_talent) and not buffpresent(pillar_of_frost) and { buffstacks(cold_heart_buff) >= 16 and buffpresent(unholy_strength) or buffstacks(cold_heart_buff) >= 19 } and spell(chains_of_ice)
}

### actions.bos_ticking

AddFunction frostbos_tickingmainactions
{
 #obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=runic_power<=40
 if runicpower() <= 40 spell(obliterate)
 #remorseless_winter,if=talent.gathering_storm.enabled|active_enemies>=2
 if hastalent(gathering_storm_talent) or enemies() >= 2 spell(remorseless_winter)
 #howling_blast,if=buff.rime.up
 if buffpresent(rime_buff) spell(howling_blast)
 #obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=rune.time_to_4<gcd|runic_power<=45
 if timetorunes(4) < gcd() or runicpower() <= 45 spell(obliterate)
 #frostscythe,if=buff.killing_machine.up&spell_targets.frostscythe>=2
 if buffpresent(killing_machine_buff) and enemies() >= 2 spell(frostscythe)
 #horn_of_winter,if=runic_power.deficit>=40&rune.time_to_3>gcd
 if runicpowerdeficit() >= 40 and timetorunes(3) > gcd() spell(horn_of_winter)
 #frostscythe,if=spell_targets.frostscythe>=2
 if enemies() >= 2 spell(frostscythe)
 #obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=runic_power.deficit>25|rune>3
 if runicpowerdeficit() > 25 or runecount() > 3 spell(obliterate)
}

AddFunction frostbos_tickingmainpostconditions
{
}

AddFunction frostbos_tickingshortcdactions
{
}

AddFunction frostbos_tickingshortcdpostconditions
{
 runicpower() <= 40 and spell(obliterate) or { hastalent(gathering_storm_talent) or enemies() >= 2 } and spell(remorseless_winter) or buffpresent(rime_buff) and spell(howling_blast) or { timetorunes(4) < gcd() or runicpower() <= 45 } and spell(obliterate) or buffpresent(killing_machine_buff) and enemies() >= 2 and spell(frostscythe) or runicpowerdeficit() >= 40 and timetorunes(3) > gcd() and spell(horn_of_winter) or enemies() >= 2 and spell(frostscythe) or { runicpowerdeficit() > 25 or runecount() > 3 } and spell(obliterate)
}

AddFunction frostbos_tickingcdactions
{
 unless runicpower() <= 40 and spell(obliterate) or { hastalent(gathering_storm_talent) or enemies() >= 2 } and spell(remorseless_winter) or buffpresent(rime_buff) and spell(howling_blast) or { timetorunes(4) < gcd() or runicpower() <= 45 } and spell(obliterate) or buffpresent(killing_machine_buff) and enemies() >= 2 and spell(frostscythe) or runicpowerdeficit() >= 40 and timetorunes(3) > gcd() and spell(horn_of_winter) or enemies() >= 2 and spell(frostscythe) or { runicpowerdeficit() > 25 or runecount() > 3 } and spell(obliterate)
 {
  #arcane_torrent,if=runic_power.deficit>50
  if runicpowerdeficit() > 50 spell(arcane_torrent)
 }
}

AddFunction frostbos_tickingcdpostconditions
{
 runicpower() <= 40 and spell(obliterate) or { hastalent(gathering_storm_talent) or enemies() >= 2 } and spell(remorseless_winter) or buffpresent(rime_buff) and spell(howling_blast) or { timetorunes(4) < gcd() or runicpower() <= 45 } and spell(obliterate) or buffpresent(killing_machine_buff) and enemies() >= 2 and spell(frostscythe) or runicpowerdeficit() >= 40 and timetorunes(3) > gcd() and spell(horn_of_winter) or enemies() >= 2 and spell(frostscythe) or { runicpowerdeficit() > 25 or runecount() > 3 } and spell(obliterate)
}

### actions.bos_pooling

AddFunction frostbos_poolingmainactions
{
 #howling_blast,if=buff.rime.up
 if buffpresent(rime_buff) spell(howling_blast)
 #remorseless_winter,if=talent.gathering_storm.enabled&rune>=5|active_enemies>=2
 if hastalent(gathering_storm_talent) and runecount() >= 5 or enemies() >= 2 spell(remorseless_winter)
 #obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=runic_power.deficit>=25
 if runicpowerdeficit() >= 25 spell(obliterate)
 #glacial_advance,if=runic_power.deficit<20&spell_targets.glacial_advance>=2&cooldown.pillar_of_frost.remains>5
 if runicpowerdeficit() < 20 and enemies() >= 2 and spellcooldown(pillar_of_frost) > 5 spell(glacial_advance)
 #frost_strike,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=runic_power.deficit<20&cooldown.pillar_of_frost.remains>5
 if runicpowerdeficit() < 20 and spellcooldown(pillar_of_frost) > 5 spell(frost_strike)
 #frostscythe,if=buff.killing_machine.up&runic_power.deficit>(15+talent.runic_attenuation.enabled*3)&spell_targets.frostscythe>=2
 if buffpresent(killing_machine_buff) and runicpowerdeficit() > 15 + talentpoints(runic_attenuation_talent) * 3 and enemies() >= 2 spell(frostscythe)
 #frostscythe,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)&spell_targets.frostscythe>=2
 if runicpowerdeficit() >= 35 + talentpoints(runic_attenuation_talent) * 3 and enemies() >= 2 spell(frostscythe)
 #obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=runic_power.deficit>=(35+talent.runic_attenuation.enabled*3)
 if runicpowerdeficit() >= 35 + talentpoints(runic_attenuation_talent) * 3 spell(obliterate)
 #glacial_advance,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40&spell_targets.glacial_advance>=2
 if spellcooldown(pillar_of_frost) > timetorunes(4) and runicpowerdeficit() < 40 and enemies() >= 2 spell(glacial_advance)
 #frost_strike,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=cooldown.pillar_of_frost.remains>rune.time_to_4&runic_power.deficit<40
 if spellcooldown(pillar_of_frost) > timetorunes(4) and runicpowerdeficit() < 40 spell(frost_strike)
}

AddFunction frostbos_poolingmainpostconditions
{
}

AddFunction frostbos_poolingshortcdactions
{
}

AddFunction frostbos_poolingshortcdpostconditions
{
 buffpresent(rime_buff) and spell(howling_blast) or { hastalent(gathering_storm_talent) and runecount() >= 5 or enemies() >= 2 } and spell(remorseless_winter) or runicpowerdeficit() >= 25 and spell(obliterate) or runicpowerdeficit() < 20 and enemies() >= 2 and spellcooldown(pillar_of_frost) > 5 and spell(glacial_advance) or runicpowerdeficit() < 20 and spellcooldown(pillar_of_frost) > 5 and spell(frost_strike) or buffpresent(killing_machine_buff) and runicpowerdeficit() > 15 + talentpoints(runic_attenuation_talent) * 3 and enemies() >= 2 and spell(frostscythe) or runicpowerdeficit() >= 35 + talentpoints(runic_attenuation_talent) * 3 and enemies() >= 2 and spell(frostscythe) or runicpowerdeficit() >= 35 + talentpoints(runic_attenuation_talent) * 3 and spell(obliterate) or spellcooldown(pillar_of_frost) > timetorunes(4) and runicpowerdeficit() < 40 and enemies() >= 2 and spell(glacial_advance) or spellcooldown(pillar_of_frost) > timetorunes(4) and runicpowerdeficit() < 40 and spell(frost_strike)
}

AddFunction frostbos_poolingcdactions
{
}

AddFunction frostbos_poolingcdpostconditions
{
 buffpresent(rime_buff) and spell(howling_blast) or { hastalent(gathering_storm_talent) and runecount() >= 5 or enemies() >= 2 } and spell(remorseless_winter) or runicpowerdeficit() >= 25 and spell(obliterate) or runicpowerdeficit() < 20 and enemies() >= 2 and spellcooldown(pillar_of_frost) > 5 and spell(glacial_advance) or runicpowerdeficit() < 20 and spellcooldown(pillar_of_frost) > 5 and spell(frost_strike) or buffpresent(killing_machine_buff) and runicpowerdeficit() > 15 + talentpoints(runic_attenuation_talent) * 3 and enemies() >= 2 and spell(frostscythe) or runicpowerdeficit() >= 35 + talentpoints(runic_attenuation_talent) * 3 and enemies() >= 2 and spell(frostscythe) or runicpowerdeficit() >= 35 + talentpoints(runic_attenuation_talent) * 3 and spell(obliterate) or spellcooldown(pillar_of_frost) > timetorunes(4) and runicpowerdeficit() < 40 and enemies() >= 2 and spell(glacial_advance) or spellcooldown(pillar_of_frost) > timetorunes(4) and runicpowerdeficit() < 40 and spell(frost_strike)
}

### actions.aoe

AddFunction frostaoemainactions
{
 #remorseless_winter,if=talent.gathering_storm.enabled
 if hastalent(gathering_storm_talent) spell(remorseless_winter)
 #glacial_advance,if=talent.frostscythe.enabled
 if hastalent(frostscythe_talent) spell(glacial_advance)
 #frost_strike,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=cooldown.remorseless_winter.remains<=2*gcd&talent.gathering_storm.enabled
 if spellcooldown(remorseless_winter) <= 2 * gcd() and hastalent(gathering_storm_talent) spell(frost_strike)
 #howling_blast,if=buff.rime.up
 if buffpresent(rime_buff) spell(howling_blast)
 #frostscythe,if=buff.killing_machine.up
 if buffpresent(killing_machine_buff) spell(frostscythe)
 #glacial_advance,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
 if runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 spell(glacial_advance)
 #frost_strike,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=runic_power.deficit<(15+talent.runic_attenuation.enabled*3)
 if runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 spell(frost_strike)
 #remorseless_winter
 spell(remorseless_winter)
 #frostscythe
 spell(frostscythe)
 #obliterate,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice,if=runic_power.deficit>(25+talent.runic_attenuation.enabled*3)
 if runicpowerdeficit() > 25 + talentpoints(runic_attenuation_talent) * 3 spell(obliterate)
 #glacial_advance
 spell(glacial_advance)
 #frost_strike,target_if=max:(debuff.razorice.stack+1)%(debuff.razorice.remains+1)*death_knight.runeforge.razorice
 spell(frost_strike)
 #horn_of_winter
 spell(horn_of_winter)
}

AddFunction frostaoemainpostconditions
{
}

AddFunction frostaoeshortcdactions
{
}

AddFunction frostaoeshortcdpostconditions
{
 hastalent(gathering_storm_talent) and spell(remorseless_winter) or hastalent(frostscythe_talent) and spell(glacial_advance) or spellcooldown(remorseless_winter) <= 2 * gcd() and hastalent(gathering_storm_talent) and spell(frost_strike) or buffpresent(rime_buff) and spell(howling_blast) or buffpresent(killing_machine_buff) and spell(frostscythe) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(glacial_advance) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(frost_strike) or spell(remorseless_winter) or spell(frostscythe) or runicpowerdeficit() > 25 + talentpoints(runic_attenuation_talent) * 3 and spell(obliterate) or spell(glacial_advance) or spell(frost_strike) or spell(horn_of_winter)
}

AddFunction frostaoecdactions
{
 unless hastalent(gathering_storm_talent) and spell(remorseless_winter) or hastalent(frostscythe_talent) and spell(glacial_advance) or spellcooldown(remorseless_winter) <= 2 * gcd() and hastalent(gathering_storm_talent) and spell(frost_strike) or buffpresent(rime_buff) and spell(howling_blast) or buffpresent(killing_machine_buff) and spell(frostscythe) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(glacial_advance) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(frost_strike) or spell(remorseless_winter) or spell(frostscythe) or runicpowerdeficit() > 25 + talentpoints(runic_attenuation_talent) * 3 and spell(obliterate) or spell(glacial_advance) or spell(frost_strike) or spell(horn_of_winter)
 {
  #arcane_torrent
  spell(arcane_torrent)
 }
}

AddFunction frostaoecdpostconditions
{
 hastalent(gathering_storm_talent) and spell(remorseless_winter) or hastalent(frostscythe_talent) and spell(glacial_advance) or spellcooldown(remorseless_winter) <= 2 * gcd() and hastalent(gathering_storm_talent) and spell(frost_strike) or buffpresent(rime_buff) and spell(howling_blast) or buffpresent(killing_machine_buff) and spell(frostscythe) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(glacial_advance) or runicpowerdeficit() < 15 + talentpoints(runic_attenuation_talent) * 3 and spell(frost_strike) or spell(remorseless_winter) or spell(frostscythe) or runicpowerdeficit() > 25 + talentpoints(runic_attenuation_talent) * 3 and spell(obliterate) or spell(glacial_advance) or spell(frost_strike) or spell(horn_of_winter)
}

### actions.default

AddFunction frost_defaultmainactions
{
 #howling_blast,if=!dot.frost_fever.ticking&(talent.icecap.enabled|cooldown.breath_of_sindragosa.remains>15|talent.obliteration.enabled&cooldown.pillar_of_frost.remains<dot.frost_fever.remains)
 if not target.debuffpresent(frost_fever) and { hastalent(icecap_talent) or spellcooldown(breath_of_sindragosa) > 15 or hastalent(obliteration_talent) and spellcooldown(pillar_of_frost) < target.debuffremaining(frost_fever) } spell(howling_blast)
 #glacial_advance,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&spell_targets.glacial_advance>=2&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
 if buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and enemies() >= 2 and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } spell(glacial_advance)
 #frost_strike,if=buff.icy_talons.remains<=gcd&buff.icy_talons.up&(!talent.breath_of_sindragosa.enabled|cooldown.breath_of_sindragosa.remains>15)
 if buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } spell(frost_strike)
 #call_action_list,name=cooldowns
 frostcooldownsmainactions()

 unless frostcooldownsmainpostconditions()
 {
  #call_action_list,name=cold_heart,if=talent.cold_heart.enabled&(buff.cold_heart.stack>=10&(debuff.razorice.stack=5|!death_knight.runeforge.razorice)|fight_remains<=gcd)
  if hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } frostcold_heartmainactions()

  unless hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } and frostcold_heartmainpostconditions()
  {
   #run_action_list,name=bos_ticking,if=buff.breath_of_sindragosa.up
   if buffpresent(breath_of_sindragosa) frostbos_tickingmainactions()

   unless buffpresent(breath_of_sindragosa) and frostbos_tickingmainpostconditions()
   {
    #run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&(cooldown.breath_of_sindragosa.remains<10)
    if hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 frostbos_poolingmainactions()

    unless hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 and frostbos_poolingmainpostconditions()
    {
     #run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
     if buffpresent(pillar_of_frost) and hastalent(obliteration_talent) frostobliterationmainactions()

     unless buffpresent(pillar_of_frost) and hastalent(obliteration_talent) and frostobliterationmainpostconditions()
     {
      #run_action_list,name=aoe,if=active_enemies>=2
      if enemies() >= 2 frostaoemainactions()

      unless enemies() >= 2 and frostaoemainpostconditions()
      {
       #call_action_list,name=standard
       froststandardmainactions()
      }
     }
    }
   }
  }
 }
}

AddFunction frost_defaultmainpostconditions
{
 frostcooldownsmainpostconditions() or hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } and frostcold_heartmainpostconditions() or buffpresent(breath_of_sindragosa) and frostbos_tickingmainpostconditions() or hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 and frostbos_poolingmainpostconditions() or buffpresent(pillar_of_frost) and hastalent(obliteration_talent) and frostobliterationmainpostconditions() or enemies() >= 2 and frostaoemainpostconditions() or froststandardmainpostconditions()
}

AddFunction frost_defaultshortcdactions
{
 #auto_attack
 frostgetinmeleerange()

 unless not target.debuffpresent(frost_fever) and { hastalent(icecap_talent) or spellcooldown(breath_of_sindragosa) > 15 or hastalent(obliteration_talent) and spellcooldown(pillar_of_frost) < target.debuffremaining(frost_fever) } and spell(howling_blast) or buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and enemies() >= 2 and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } and spell(glacial_advance) or buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } and spell(frost_strike)
 {
  #call_action_list,name=cooldowns
  frostcooldownsshortcdactions()

  unless frostcooldownsshortcdpostconditions()
  {
   #call_action_list,name=cold_heart,if=talent.cold_heart.enabled&(buff.cold_heart.stack>=10&(debuff.razorice.stack=5|!death_knight.runeforge.razorice)|fight_remains<=gcd)
   if hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } frostcold_heartshortcdactions()

   unless hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } and frostcold_heartshortcdpostconditions()
   {
    #run_action_list,name=bos_ticking,if=buff.breath_of_sindragosa.up
    if buffpresent(breath_of_sindragosa) frostbos_tickingshortcdactions()

    unless buffpresent(breath_of_sindragosa) and frostbos_tickingshortcdpostconditions()
    {
     #run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&(cooldown.breath_of_sindragosa.remains<10)
     if hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 frostbos_poolingshortcdactions()

     unless hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 and frostbos_poolingshortcdpostconditions()
     {
      #run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
      if buffpresent(pillar_of_frost) and hastalent(obliteration_talent) frostobliterationshortcdactions()

      unless buffpresent(pillar_of_frost) and hastalent(obliteration_talent) and frostobliterationshortcdpostconditions()
      {
       #run_action_list,name=aoe,if=active_enemies>=2
       if enemies() >= 2 frostaoeshortcdactions()

       unless enemies() >= 2 and frostaoeshortcdpostconditions()
       {
        #call_action_list,name=standard
        froststandardshortcdactions()
       }
      }
     }
    }
   }
  }
 }
}

AddFunction frost_defaultshortcdpostconditions
{
 not target.debuffpresent(frost_fever) and { hastalent(icecap_talent) or spellcooldown(breath_of_sindragosa) > 15 or hastalent(obliteration_talent) and spellcooldown(pillar_of_frost) < target.debuffremaining(frost_fever) } and spell(howling_blast) or buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and enemies() >= 2 and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } and spell(glacial_advance) or buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } and spell(frost_strike) or frostcooldownsshortcdpostconditions() or hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } and frostcold_heartshortcdpostconditions() or buffpresent(breath_of_sindragosa) and frostbos_tickingshortcdpostconditions() or hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 and frostbos_poolingshortcdpostconditions() or buffpresent(pillar_of_frost) and hastalent(obliteration_talent) and frostobliterationshortcdpostconditions() or enemies() >= 2 and frostaoeshortcdpostconditions() or froststandardshortcdpostconditions()
}

AddFunction frost_defaultcdactions
{
 frostinterruptactions()

 unless not target.debuffpresent(frost_fever) and { hastalent(icecap_talent) or spellcooldown(breath_of_sindragosa) > 15 or hastalent(obliteration_talent) and spellcooldown(pillar_of_frost) < target.debuffremaining(frost_fever) } and spell(howling_blast) or buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and enemies() >= 2 and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } and spell(glacial_advance) or buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } and spell(frost_strike)
 {
  #call_action_list,name=cooldowns
  frostcooldownscdactions()

  unless frostcooldownscdpostconditions()
  {
   #call_action_list,name=cold_heart,if=talent.cold_heart.enabled&(buff.cold_heart.stack>=10&(debuff.razorice.stack=5|!death_knight.runeforge.razorice)|fight_remains<=gcd)
   if hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } frostcold_heartcdactions()

   unless hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } and frostcold_heartcdpostconditions()
   {
    #run_action_list,name=bos_ticking,if=buff.breath_of_sindragosa.up
    if buffpresent(breath_of_sindragosa) frostbos_tickingcdactions()

    unless buffpresent(breath_of_sindragosa) and frostbos_tickingcdpostconditions()
    {
     #run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&(cooldown.breath_of_sindragosa.remains<10)
     if hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 frostbos_poolingcdactions()

     unless hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 and frostbos_poolingcdpostconditions()
     {
      #run_action_list,name=obliteration,if=buff.pillar_of_frost.up&talent.obliteration.enabled
      if buffpresent(pillar_of_frost) and hastalent(obliteration_talent) frostobliterationcdactions()

      unless buffpresent(pillar_of_frost) and hastalent(obliteration_talent) and frostobliterationcdpostconditions()
      {
       #run_action_list,name=aoe,if=active_enemies>=2
       if enemies() >= 2 frostaoecdactions()

       unless enemies() >= 2 and frostaoecdpostconditions()
       {
        #call_action_list,name=standard
        froststandardcdactions()
       }
      }
     }
    }
   }
  }
 }
}

AddFunction frost_defaultcdpostconditions
{
 not target.debuffpresent(frost_fever) and { hastalent(icecap_talent) or spellcooldown(breath_of_sindragosa) > 15 or hastalent(obliteration_talent) and spellcooldown(pillar_of_frost) < target.debuffremaining(frost_fever) } and spell(howling_blast) or buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and enemies() >= 2 and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } and spell(glacial_advance) or buffremaining(icy_talons_buff) <= gcd() and buffpresent(icy_talons_buff) and { not hastalent(breath_of_sindragosa_talent) or spellcooldown(breath_of_sindragosa) > 15 } and spell(frost_strike) or frostcooldownscdpostconditions() or hastalent(cold_heart_talent) and { buffstacks(cold_heart_buff) >= 10 and { target.debuffstacks(razorice) == 5 or not message("death_knight.runeforge.razorice is not implemented") } or fightremains() <= gcd() } and frostcold_heartcdpostconditions() or buffpresent(breath_of_sindragosa) and frostbos_tickingcdpostconditions() or hastalent(breath_of_sindragosa_talent) and spellcooldown(breath_of_sindragosa) < 10 and frostbos_poolingcdpostconditions() or buffpresent(pillar_of_frost) and hastalent(obliteration_talent) and frostobliterationcdpostconditions() or enemies() >= 2 and frostaoecdpostconditions() or froststandardcdpostconditions()
}

### Frost icons.

AddCheckBox(opt_deathknight_frost_aoe l(aoe) default specialization=frost)

AddIcon checkbox=!opt_deathknight_frost_aoe enemies=1 help=shortcd specialization=frost
{
 if not incombat() frostprecombatshortcdactions()
 frost_defaultshortcdactions()
}

AddIcon checkbox=opt_deathknight_frost_aoe help=shortcd specialization=frost
{
 if not incombat() frostprecombatshortcdactions()
 frost_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=frost
{
 if not incombat() frostprecombatmainactions()
 frost_defaultmainactions()
}

AddIcon checkbox=opt_deathknight_frost_aoe help=aoe specialization=frost
{
 if not incombat() frostprecombatmainactions()
 frost_defaultmainactions()
}

AddIcon checkbox=!opt_deathknight_frost_aoe enemies=1 help=cd specialization=frost
{
 if not incombat() frostprecombatcdactions()
 frost_defaultcdactions()
}

AddIcon checkbox=opt_deathknight_frost_aoe help=cd specialization=frost
{
 if not incombat() frostprecombatcdactions()
 frost_defaultcdactions()
}

### Required symbols
# ancestral_call
# arcane_pulse
# arcane_torrent
# bag_of_tricks
# berserking
# biting_cold_runeforge
# blinding_sleet
# blood_fury
# breath_of_sindragosa
# breath_of_sindragosa_talent
# chains_of_ice
# cold_heart_buff
# cold_heart_talent
# concentrated_flame_essence
# death_strike
# empower_rune_weapon
# eradicating_blow
# eradicating_blow_conduit
# everfrost_conduit
# fireblood
# frost_fever
# frost_strike
# frostscythe
# frostscythe_talent
# frostwyrms_fury
# frozen_pulse_buff
# frozen_pulse_talent
# gathering_storm_talent
# glacial_advance
# horn_of_winter
# howling_blast
# hypothermic_presence
# icecap_talent
# icy_talons_buff
# killing_machine_buff
# lights_judgment
# mind_freeze
# obliterate
# obliteration_talent
# pillar_of_frost
# potion_of_unbridled_fury_item
# raise_dead
# razorice
# remorseless_winter
# rime_buff
# runic_attenuation_talent
# unholy_strength
# unleashed_frenzy_buff
# unleashed_frenzy_conduit
# war_stomp
]]
        OvaleScripts:RegisterScript("DEATHKNIGHT", "frost", name, desc, code, "script")
    end
    do
        local name = "sc_t25_death_knight_unholy"
        local desc = "[9.0] Simulationcraft: T25_Death_Knight_Unholy"
        local code = [[
# Based on SimulationCraft profile "T25_Death_Knight_Unholy".
#	class=deathknight
#	spec=unholy
#	talents=2203032

Include(ovale_common)
Include(ovale_deathknight_spells)


AddFunction pooling_for_gargoyle
{
 spellcooldown(summon_gargoyle) < 5 and hastalent(summon_gargoyle_talent)
}

AddCheckBox(opt_interrupt l(interrupt) default specialization=unholy)
AddCheckBox(opt_melee_range l(not_in_melee_range) specialization=unholy)
AddCheckBox(opt_use_consumables l(opt_use_consumables) default specialization=unholy)

AddFunction unholyinterruptactions
{
 if checkboxon(opt_interrupt) and not target.isfriend() and target.casting()
 {
  if target.inrange(mind_freeze) and target.isinterruptible() spell(mind_freeze)
  if target.inrange(asphyxiate) and not target.classification(worldboss) spell(asphyxiate)
  if target.distance(less 5) and not target.classification(worldboss) spell(war_stomp)
 }
}

AddFunction unholyuseheartessence
{
 spell(concentrated_flame_essence)
}

AddFunction unholyuseitemactions
{
 item(trinket0slot text=13 usable=1)
 item(trinket1slot text=14 usable=1)
}

AddFunction unholygetinmeleerange
{
 if checkboxon(opt_melee_range) and not target.inrange(death_strike) texture(misc_arrowlup help=l(not_in_melee_range))
}

### actions.precombat

AddFunction unholyprecombatmainactions
{
 #flask
 #food
 #augmentation
 #snapshot_stats
 #potion
 if checkboxon(opt_use_consumables) and target.classification(worldboss) item(potion_of_unbridled_fury_item usable=1)
}

AddFunction unholyprecombatmainpostconditions
{
}

AddFunction unholyprecombatshortcdactions
{
}

AddFunction unholyprecombatshortcdpostconditions
{
 checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
}

AddFunction unholyprecombatcdactions
{
 unless checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
 {
  #raise_dead
  spell(raise_dead)
 }
}

AddFunction unholyprecombatcdpostconditions
{
 checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
}

### actions.generic_aoe

AddFunction unholygeneric_aoemainactions
{
 #epidemic,if=buff.sudden_doom.react
 if buffpresent(sudden_doom_buff) spell(epidemic)
 #epidemic,if=!variable.pooling_for_gargoyle
 if not pooling_for_gargoyle() spell(epidemic)
 #wound_spender,target_if=max:debuff.festering_wound.stack,if=(cooldown.apocalypse.remains>5&debuff.festering_wound.up|debuff.festering_wound.stack>4)&(fight_remains<cooldown.death_and_decay.remains+10|fight_remains>cooldown.apocalypse.remains)
 if { spellcooldown(apocalypse) > 5 and target.debuffpresent(festering_wound) or target.debuffstacks(festering_wound) > 4 } and { fightremains() < spellcooldown(death_and_decay) + 10 or fightremains() > spellcooldown(apocalypse) } spell(wound_spender)
 #festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=3&cooldown.apocalypse.remains<3|debuff.festering_wound.stack<1
 if target.debuffstacks(festering_wound) <= 3 and spellcooldown(apocalypse) < 3 or target.debuffstacks(festering_wound) < 1 spell(festering_strike)
 #festering_strike,target_if=min:debuff.festering_wound.stack,if=cooldown.apocalypse.remains>5&debuff.festering_wound.stack<1
 if spellcooldown(apocalypse) > 5 and target.debuffstacks(festering_wound) < 1 spell(festering_strike)
}

AddFunction unholygeneric_aoemainpostconditions
{
}

AddFunction unholygeneric_aoeshortcdactions
{
}

AddFunction unholygeneric_aoeshortcdpostconditions
{
 buffpresent(sudden_doom_buff) and spell(epidemic) or not pooling_for_gargoyle() and spell(epidemic) or { spellcooldown(apocalypse) > 5 and target.debuffpresent(festering_wound) or target.debuffstacks(festering_wound) > 4 } and { fightremains() < spellcooldown(death_and_decay) + 10 or fightremains() > spellcooldown(apocalypse) } and spell(wound_spender) or { target.debuffstacks(festering_wound) <= 3 and spellcooldown(apocalypse) < 3 or target.debuffstacks(festering_wound) < 1 } and spell(festering_strike) or spellcooldown(apocalypse) > 5 and target.debuffstacks(festering_wound) < 1 and spell(festering_strike)
}

AddFunction unholygeneric_aoecdactions
{
}

AddFunction unholygeneric_aoecdpostconditions
{
 buffpresent(sudden_doom_buff) and spell(epidemic) or not pooling_for_gargoyle() and spell(epidemic) or { spellcooldown(apocalypse) > 5 and target.debuffpresent(festering_wound) or target.debuffstacks(festering_wound) > 4 } and { fightremains() < spellcooldown(death_and_decay) + 10 or fightremains() > spellcooldown(apocalypse) } and spell(wound_spender) or { target.debuffstacks(festering_wound) <= 3 and spellcooldown(apocalypse) < 3 or target.debuffstacks(festering_wound) < 1 } and spell(festering_strike) or spellcooldown(apocalypse) > 5 and target.debuffstacks(festering_wound) < 1 and spell(festering_strike)
}

### actions.generic

AddFunction unholygenericmainactions
{
 #death_coil,if=buff.sudden_doom.react&!variable.pooling_for_gargoyle|pet.gargoyle.active
 if buffpresent(sudden_doom_buff) and not pooling_for_gargoyle() or pet.present() spell(death_coil)
 #death_coil,if=runic_power.deficit<13&!variable.pooling_for_gargoyle
 if runicpowerdeficit() < 13 and not pooling_for_gargoyle() spell(death_coil)
 #defile,if=cooldown.apocalypse.remains
 if spellcooldown(apocalypse) > 0 spell(defile)
 #wound_spender,if=debuff.festering_wound.stack>4
 if target.debuffstacks(festering_wound) > 4 spell(wound_spender)
 #wound_spender,if=debuff.festering_wound.up&cooldown.apocalypse.remains>5&(!talent.unholy_blight.enabled|talent.army_of_the_damned.enabled|conduit.convocation_of_the_dead.enabled|raid_event.adds.exists)
 if target.debuffpresent(festering_wound) and spellcooldown(apocalypse) > 5 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or false(raid_event_adds_exists) } spell(wound_spender)
 #wound_spender,if=debuff.festering_wound.up&talent.unholy_blight.enabled&cooldown.unholy_blight.remains>5&!talent.army_of_the_damned.enabled&!conduit.convocation_of_the_dead.enabled&!cooldown.apocalypse.ready&!raid_event.adds.exists
 if target.debuffpresent(festering_wound) and hastalent(unholy_blight_talent) and spellcooldown(unholy_blight) > 5 and not hastalent(army_of_the_damned_talent) and not conduit(convocation_of_the_dead_conduit) and not spellcooldown(apocalypse) == 0 and not false(raid_event_adds_exists) spell(wound_spender)
 #death_coil,if=runic_power.deficit<20&!variable.pooling_for_gargoyle
 if runicpowerdeficit() < 20 and not pooling_for_gargoyle() spell(death_coil)
 #festering_strike,if=debuff.festering_wound.stack<1
 if target.debuffstacks(festering_wound) < 1 spell(festering_strike)
 #festering_strike,if=debuff.festering_wound.stack<4&cooldown.apocalypse.remains<3&(!talent.unholy_blight.enabled|talent.army_of_the_damned.enabled|conduit.convocation_of_the_dead.enabled|raid_event.adds.exists)
 if target.debuffstacks(festering_wound) < 4 and spellcooldown(apocalypse) < 3 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or false(raid_event_adds_exists) } spell(festering_strike)
 #festering_strike,if=debuff.festering_wound.stack<4&talent.unholy_blight.enabled&!talent.army_of_the_damned.enabled&!conduit.convocation_of_the_dead.enabled&!raid_event.adds.exists&cooldown.apocalypse.ready&(cooldown.unholy_blight.remains<3|dot.unholy_blight.remains)
 if target.debuffstacks(festering_wound) < 4 and hastalent(unholy_blight_talent) and not hastalent(army_of_the_damned_talent) and not conduit(convocation_of_the_dead_conduit) and not false(raid_event_adds_exists) and spellcooldown(apocalypse) == 0 and { spellcooldown(unholy_blight) < 3 or target.debuffremaining(unholy_blight) } spell(festering_strike)
 #death_coil,if=!variable.pooling_for_gargoyle
 if not pooling_for_gargoyle() spell(death_coil)
}

AddFunction unholygenericmainpostconditions
{
}

AddFunction unholygenericshortcdactions
{
}

AddFunction unholygenericshortcdpostconditions
{
 { buffpresent(sudden_doom_buff) and not pooling_for_gargoyle() or pet.present() } and spell(death_coil) or runicpowerdeficit() < 13 and not pooling_for_gargoyle() and spell(death_coil) or spellcooldown(apocalypse) > 0 and spell(defile) or target.debuffstacks(festering_wound) > 4 and spell(wound_spender) or target.debuffpresent(festering_wound) and spellcooldown(apocalypse) > 5 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or false(raid_event_adds_exists) } and spell(wound_spender) or target.debuffpresent(festering_wound) and hastalent(unholy_blight_talent) and spellcooldown(unholy_blight) > 5 and not hastalent(army_of_the_damned_talent) and not conduit(convocation_of_the_dead_conduit) and not spellcooldown(apocalypse) == 0 and not false(raid_event_adds_exists) and spell(wound_spender) or runicpowerdeficit() < 20 and not pooling_for_gargoyle() and spell(death_coil) or target.debuffstacks(festering_wound) < 1 and spell(festering_strike) or target.debuffstacks(festering_wound) < 4 and spellcooldown(apocalypse) < 3 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or false(raid_event_adds_exists) } and spell(festering_strike) or target.debuffstacks(festering_wound) < 4 and hastalent(unholy_blight_talent) and not hastalent(army_of_the_damned_talent) and not conduit(convocation_of_the_dead_conduit) and not false(raid_event_adds_exists) and spellcooldown(apocalypse) == 0 and { spellcooldown(unholy_blight) < 3 or target.debuffremaining(unholy_blight) } and spell(festering_strike) or not pooling_for_gargoyle() and spell(death_coil)
}

AddFunction unholygenericcdactions
{
}

AddFunction unholygenericcdpostconditions
{
 { buffpresent(sudden_doom_buff) and not pooling_for_gargoyle() or pet.present() } and spell(death_coil) or runicpowerdeficit() < 13 and not pooling_for_gargoyle() and spell(death_coil) or spellcooldown(apocalypse) > 0 and spell(defile) or target.debuffstacks(festering_wound) > 4 and spell(wound_spender) or target.debuffpresent(festering_wound) and spellcooldown(apocalypse) > 5 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or false(raid_event_adds_exists) } and spell(wound_spender) or target.debuffpresent(festering_wound) and hastalent(unholy_blight_talent) and spellcooldown(unholy_blight) > 5 and not hastalent(army_of_the_damned_talent) and not conduit(convocation_of_the_dead_conduit) and not spellcooldown(apocalypse) == 0 and not false(raid_event_adds_exists) and spell(wound_spender) or runicpowerdeficit() < 20 and not pooling_for_gargoyle() and spell(death_coil) or target.debuffstacks(festering_wound) < 1 and spell(festering_strike) or target.debuffstacks(festering_wound) < 4 and spellcooldown(apocalypse) < 3 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or false(raid_event_adds_exists) } and spell(festering_strike) or target.debuffstacks(festering_wound) < 4 and hastalent(unholy_blight_talent) and not hastalent(army_of_the_damned_talent) and not conduit(convocation_of_the_dead_conduit) and not false(raid_event_adds_exists) and spellcooldown(apocalypse) == 0 and { spellcooldown(unholy_blight) < 3 or target.debuffremaining(unholy_blight) } and spell(festering_strike) or not pooling_for_gargoyle() and spell(death_coil)
}

### actions.cooldowns

AddFunction unholycooldownsmainactions
{
 #potion,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
 if { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and checkboxon(opt_use_consumables) and target.classification(worldboss) item(potion_of_unbridled_fury_item usable=1)
 #unholy_blight,if=!raid_event.adds.exists&(cooldown.army_of_the_dead.remains>5|death_knight.disable_aotd)&(cooldown.apocalypse.ready&(debuff.festering_wound.stack>=4|rune>=3)|cooldown.apocalypse.remains)&!raid_event.adds.exists
 if not false(raid_event_adds_exists) and { spellcooldown(army_of_the_dead) > 5 or message("death_knight.disable_aotd is not implemented") } and { spellcooldown(apocalypse) == 0 and { target.debuffstacks(festering_wound) >= 4 or runecount() >= 3 } or spellcooldown(apocalypse) > 0 } and not false(raid_event_adds_exists) spell(unholy_blight)
 #unholy_blight,if=raid_event.adds.exists&(active_enemies>=2|raid_event.adds.in>15)
 if false(raid_event_adds_exists) and { enemies() >= 2 or 600 > 15 } spell(unholy_blight)
 #summon_gargoyle,if=runic_power.deficit<14
 if runicpowerdeficit() < 14 spell(summon_gargoyle)
 #unholy_assault,if=active_enemies=1&debuff.festering_wound.stack<2&(pet.apoc_ghoul.active|conduit.convocation_of_the_dead.enabled)
 if enemies() == 1 and target.debuffstacks(festering_wound) < 2 and { pet.present() or conduit(convocation_of_the_dead_conduit) } spell(unholy_assault)
 #unholy_assault,target_if=min:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack<2
 if enemies() >= 2 and target.debuffstacks(festering_wound) < 2 spell(unholy_assault)
 #soul_reaper,target_if=target.time_to_pct_35<5&target.time_to_die>5
 if target.timetohealthpercent(35) < 5 and target.timetodie() > 5 spell(soul_reaper)
}

AddFunction unholycooldownsmainpostconditions
{
}

AddFunction unholycooldownsshortcdactions
{
 unless { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or not false(raid_event_adds_exists) and { spellcooldown(army_of_the_dead) > 5 or message("death_knight.disable_aotd is not implemented") } and { spellcooldown(apocalypse) == 0 and { target.debuffstacks(festering_wound) >= 4 or runecount() >= 3 } or spellcooldown(apocalypse) > 0 } and not false(raid_event_adds_exists) and spell(unholy_blight) or false(raid_event_adds_exists) and { enemies() >= 2 or 600 > 15 } and spell(unholy_blight)
 {
  #dark_transformation,if=!raid_event.adds.exists&cooldown.unholy_blight.remains&(!runeforge.deadliest_coil.equipped|runeforge.deadliest_coil.equipped&(!buff.dark_transformation.up&!talent.unholy_pact.enabled|talent.unholy_pact.enabled))
  if not false(raid_event_adds_exists) and spellcooldown(unholy_blight) > 0 and { not equippedruneforge(deadliest_coil_runeforge) or equippedruneforge(deadliest_coil_runeforge) and { not buffpresent(dark_transformation) and not hastalent(unholy_pact_talent) or hastalent(unholy_pact_talent) } } spell(dark_transformation)
  #dark_transformation,if=!raid_event.adds.exists&!talent.unholy_blight.enabled
  if not false(raid_event_adds_exists) and not hastalent(unholy_blight_talent) spell(dark_transformation)
  #dark_transformation,if=raid_event.adds.exists&(active_enemies>=2|raid_event.adds.in>15)
  if false(raid_event_adds_exists) and { enemies() >= 2 or 600 > 15 } spell(dark_transformation)
  #apocalypse,if=active_enemies=1&debuff.festering_wound.stack>=4&((!talent.unholy_blight.enabled|talent.army_of_the_damned.enabled|conduit.convocation_of_the_dead.enabled)|talent.unholy_blight.enabled&!talent.army_of_the_damned.enabled&dot.unholy_blight.remains)
  if enemies() == 1 and target.debuffstacks(festering_wound) >= 4 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or hastalent(unholy_blight_talent) and not hastalent(army_of_the_damned_talent) and target.debuffremaining(unholy_blight) } spell(apocalypse)
  #apocalypse,target_if=max:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack>=4&!death_and_decay.ticking
  if enemies() >= 2 and target.debuffstacks(festering_wound) >= 4 and not message("death_and_decay.ticking is not implemented") spell(apocalypse)
 }
}

AddFunction unholycooldownsshortcdpostconditions
{
 { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or not false(raid_event_adds_exists) and { spellcooldown(army_of_the_dead) > 5 or message("death_knight.disable_aotd is not implemented") } and { spellcooldown(apocalypse) == 0 and { target.debuffstacks(festering_wound) >= 4 or runecount() >= 3 } or spellcooldown(apocalypse) > 0 } and not false(raid_event_adds_exists) and spell(unholy_blight) or false(raid_event_adds_exists) and { enemies() >= 2 or 600 > 15 } and spell(unholy_blight) or runicpowerdeficit() < 14 and spell(summon_gargoyle) or enemies() == 1 and target.debuffstacks(festering_wound) < 2 and { pet.present() or conduit(convocation_of_the_dead_conduit) } and spell(unholy_assault) or enemies() >= 2 and target.debuffstacks(festering_wound) < 2 and spell(unholy_assault) or target.timetohealthpercent(35) < 5 and target.timetodie() > 5 and spell(soul_reaper)
}

AddFunction unholycooldownscdactions
{
 #use_items
 unholyuseitemactions()

 unless { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1)
 {
  #army_of_the_dead,if=cooldown.unholy_blight.remains<5&talent.unholy_blight.enabled|!talent.unholy_blight.enabled
  if spellcooldown(unholy_blight) < 5 and hastalent(unholy_blight_talent) or not hastalent(unholy_blight_talent) spell(army_of_the_dead)

  unless not false(raid_event_adds_exists) and { spellcooldown(army_of_the_dead) > 5 or message("death_knight.disable_aotd is not implemented") } and { spellcooldown(apocalypse) == 0 and { target.debuffstacks(festering_wound) >= 4 or runecount() >= 3 } or spellcooldown(apocalypse) > 0 } and not false(raid_event_adds_exists) and spell(unholy_blight) or false(raid_event_adds_exists) and { enemies() >= 2 or 600 > 15 } and spell(unholy_blight) or not false(raid_event_adds_exists) and spellcooldown(unholy_blight) > 0 and { not equippedruneforge(deadliest_coil_runeforge) or equippedruneforge(deadliest_coil_runeforge) and { not buffpresent(dark_transformation) and not hastalent(unholy_pact_talent) or hastalent(unholy_pact_talent) } } and spell(dark_transformation) or not false(raid_event_adds_exists) and not hastalent(unholy_blight_talent) and spell(dark_transformation) or false(raid_event_adds_exists) and { enemies() >= 2 or 600 > 15 } and spell(dark_transformation) or enemies() == 1 and target.debuffstacks(festering_wound) >= 4 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or hastalent(unholy_blight_talent) and not hastalent(army_of_the_damned_talent) and target.debuffremaining(unholy_blight) } and spell(apocalypse) or enemies() >= 2 and target.debuffstacks(festering_wound) >= 4 and not message("death_and_decay.ticking is not implemented") and spell(apocalypse) or runicpowerdeficit() < 14 and spell(summon_gargoyle) or enemies() == 1 and target.debuffstacks(festering_wound) < 2 and { pet.present() or conduit(convocation_of_the_dead_conduit) } and spell(unholy_assault) or enemies() >= 2 and target.debuffstacks(festering_wound) < 2 and spell(unholy_assault) or target.timetohealthpercent(35) < 5 and target.timetodie() > 5 and spell(soul_reaper)
  {
   #raise_dead,if=!pet.ghoul.active
   if not pet.present() spell(raise_dead)
   #heart_essence
   unholyuseheartessence()
  }
 }
}

AddFunction unholycooldownscdpostconditions
{
 { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and checkboxon(opt_use_consumables) and target.classification(worldboss) and item(potion_of_unbridled_fury_item usable=1) or not false(raid_event_adds_exists) and { spellcooldown(army_of_the_dead) > 5 or message("death_knight.disable_aotd is not implemented") } and { spellcooldown(apocalypse) == 0 and { target.debuffstacks(festering_wound) >= 4 or runecount() >= 3 } or spellcooldown(apocalypse) > 0 } and not false(raid_event_adds_exists) and spell(unholy_blight) or false(raid_event_adds_exists) and { enemies() >= 2 or 600 > 15 } and spell(unholy_blight) or not false(raid_event_adds_exists) and spellcooldown(unholy_blight) > 0 and { not equippedruneforge(deadliest_coil_runeforge) or equippedruneforge(deadliest_coil_runeforge) and { not buffpresent(dark_transformation) and not hastalent(unholy_pact_talent) or hastalent(unholy_pact_talent) } } and spell(dark_transformation) or not false(raid_event_adds_exists) and not hastalent(unholy_blight_talent) and spell(dark_transformation) or false(raid_event_adds_exists) and { enemies() >= 2 or 600 > 15 } and spell(dark_transformation) or enemies() == 1 and target.debuffstacks(festering_wound) >= 4 and { not hastalent(unholy_blight_talent) or hastalent(army_of_the_damned_talent) or conduit(convocation_of_the_dead_conduit) or hastalent(unholy_blight_talent) and not hastalent(army_of_the_damned_talent) and target.debuffremaining(unholy_blight) } and spell(apocalypse) or enemies() >= 2 and target.debuffstacks(festering_wound) >= 4 and not message("death_and_decay.ticking is not implemented") and spell(apocalypse) or runicpowerdeficit() < 14 and spell(summon_gargoyle) or enemies() == 1 and target.debuffstacks(festering_wound) < 2 and { pet.present() or conduit(convocation_of_the_dead_conduit) } and spell(unholy_assault) or enemies() >= 2 and target.debuffstacks(festering_wound) < 2 and spell(unholy_assault) or target.timetohealthpercent(35) < 5 and target.timetodie() > 5 and spell(soul_reaper)
}

### actions.aoe_setup

AddFunction unholyaoe_setupmainactions
{
 #any_dnd,if=death_knight.fwounded_targets=active_enemies|raid_event.adds.exists&raid_event.adds.remains<=11
 if message("death_knight.fwounded_targets is not implemented") == enemies() or false(raid_event_adds_exists) and message("raid_event.adds.remains is not implemented") <= 11 spell(any_dnd)
 #any_dnd,if=death_knight.fwounded_targets>=5
 if message("death_knight.fwounded_targets is not implemented") >= 5 spell(any_dnd)
 #epidemic,if=!variable.pooling_for_gargoyle&runic_power.deficit<20|buff.sudden_doom.react
 if not pooling_for_gargoyle() and runicpowerdeficit() < 20 or buffpresent(sudden_doom_buff) spell(epidemic)
 #festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=3&cooldown.apocalypse.remains<3
 if target.debuffstacks(festering_wound) <= 3 and spellcooldown(apocalypse) < 3 spell(festering_strike)
 #festering_strike,target_if=debuff.festering_wound.stack<1
 if target.debuffstacks(festering_wound) < 1 spell(festering_strike)
 #festering_strike,target_if=min:debuff.festering_wound.stack,if=rune.time_to_4<(cooldown.death_and_decay.remains&!talent.defile.enabled|cooldown.defile.remains&talent.defile.enabled)
 if timetorunes(4) < { spellcooldown(death_and_decay) > 0 and not hastalent(defile_talent) or spellcooldown(defile) > 0 and hastalent(defile_talent) } spell(festering_strike)
 #epidemic,if=!variable.pooling_for_gargoyle
 if not pooling_for_gargoyle() spell(epidemic)
}

AddFunction unholyaoe_setupmainpostconditions
{
}

AddFunction unholyaoe_setupshortcdactions
{
}

AddFunction unholyaoe_setupshortcdpostconditions
{
 { message("death_knight.fwounded_targets is not implemented") == enemies() or false(raid_event_adds_exists) and message("raid_event.adds.remains is not implemented") <= 11 } and spell(any_dnd) or message("death_knight.fwounded_targets is not implemented") >= 5 and spell(any_dnd) or { not pooling_for_gargoyle() and runicpowerdeficit() < 20 or buffpresent(sudden_doom_buff) } and spell(epidemic) or target.debuffstacks(festering_wound) <= 3 and spellcooldown(apocalypse) < 3 and spell(festering_strike) or target.debuffstacks(festering_wound) < 1 and spell(festering_strike) or timetorunes(4) < { spellcooldown(death_and_decay) > 0 and not hastalent(defile_talent) or spellcooldown(defile) > 0 and hastalent(defile_talent) } and spell(festering_strike) or not pooling_for_gargoyle() and spell(epidemic)
}

AddFunction unholyaoe_setupcdactions
{
}

AddFunction unholyaoe_setupcdpostconditions
{
 { message("death_knight.fwounded_targets is not implemented") == enemies() or false(raid_event_adds_exists) and message("raid_event.adds.remains is not implemented") <= 11 } and spell(any_dnd) or message("death_knight.fwounded_targets is not implemented") >= 5 and spell(any_dnd) or { not pooling_for_gargoyle() and runicpowerdeficit() < 20 or buffpresent(sudden_doom_buff) } and spell(epidemic) or target.debuffstacks(festering_wound) <= 3 and spellcooldown(apocalypse) < 3 and spell(festering_strike) or target.debuffstacks(festering_wound) < 1 and spell(festering_strike) or timetorunes(4) < { spellcooldown(death_and_decay) > 0 and not hastalent(defile_talent) or spellcooldown(defile) > 0 and hastalent(defile_talent) } and spell(festering_strike) or not pooling_for_gargoyle() and spell(epidemic)
}

### actions.aoe_burst

AddFunction unholyaoe_burstmainactions
{
 #epidemic,if=runic_power.deficit<(10+death_knight.fwounded_targets*3)&death_knight.fwounded_targets<6&!variable.pooling_for_gargoyle
 if runicpowerdeficit() < 10 + message("death_knight.fwounded_targets is not implemented") * 3 and message("death_knight.fwounded_targets is not implemented") < 6 and not pooling_for_gargoyle() spell(epidemic)
 #epidemic,if=runic_power.deficit<25&death_knight.fwounded_targets>5&!variable.pooling_for_gargoyle
 if runicpowerdeficit() < 25 and message("death_knight.fwounded_targets is not implemented") > 5 and not pooling_for_gargoyle() spell(epidemic)
 #epidemic,if=!death_knight.fwounded_targets&!variable.pooling_for_gargoyle
 if not message("death_knight.fwounded_targets is not implemented") and not pooling_for_gargoyle() spell(epidemic)
 #wound_spender
 spell(wound_spender)
 #epidemic,if=!variable.pooling_for_gargoyle
 if not pooling_for_gargoyle() spell(epidemic)
}

AddFunction unholyaoe_burstmainpostconditions
{
}

AddFunction unholyaoe_burstshortcdactions
{
}

AddFunction unholyaoe_burstshortcdpostconditions
{
 runicpowerdeficit() < 10 + message("death_knight.fwounded_targets is not implemented") * 3 and message("death_knight.fwounded_targets is not implemented") < 6 and not pooling_for_gargoyle() and spell(epidemic) or runicpowerdeficit() < 25 and message("death_knight.fwounded_targets is not implemented") > 5 and not pooling_for_gargoyle() and spell(epidemic) or not message("death_knight.fwounded_targets is not implemented") and not pooling_for_gargoyle() and spell(epidemic) or spell(wound_spender) or not pooling_for_gargoyle() and spell(epidemic)
}

AddFunction unholyaoe_burstcdactions
{
}

AddFunction unholyaoe_burstcdpostconditions
{
 runicpowerdeficit() < 10 + message("death_knight.fwounded_targets is not implemented") * 3 and message("death_knight.fwounded_targets is not implemented") < 6 and not pooling_for_gargoyle() and spell(epidemic) or runicpowerdeficit() < 25 and message("death_knight.fwounded_targets is not implemented") > 5 and not pooling_for_gargoyle() and spell(epidemic) or not message("death_knight.fwounded_targets is not implemented") and not pooling_for_gargoyle() and spell(epidemic) or spell(wound_spender) or not pooling_for_gargoyle() and spell(epidemic)
}

### actions.default

AddFunction unholy_defaultmainactions
{
 #berserking,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
 if pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } spell(berserking)
 #outbreak,if=dot.virulent_plague.refreshable&!talent.unholy_blight.enabled&!raid_event.adds.exists
 if target.debuffrefreshable(virulent_plague) and not hastalent(unholy_blight_talent) and not false(raid_event_adds_exists) spell(outbreak)
 #outbreak,if=dot.virulent_plague.refreshable&(!talent.unholy_blight.enabled|talent.unholy_blight.enabled&cooldown.unholy_blight.remains)&active_enemies>=2
 if target.debuffrefreshable(virulent_plague) and { not hastalent(unholy_blight_talent) or hastalent(unholy_blight_talent) and spellcooldown(unholy_blight) > 0 } and enemies() >= 2 spell(outbreak)
 #call_action_list,name=cooldowns
 unholycooldownsmainactions()

 unless unholycooldownsmainpostconditions()
 {
  #run_action_list,name=aoe_setup,if=active_enemies>=2&(cooldown.death_and_decay.remains<10&!talent.defile.enabled|cooldown.defile.remains<10&talent.defile.enabled)&!death_and_decay.ticking
  if enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") unholyaoe_setupmainactions()

  unless enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") and unholyaoe_setupmainpostconditions()
  {
   #run_action_list,name=aoe_burst,if=active_enemies>=2&death_and_decay.ticking
   if enemies() >= 2 and message("death_and_decay.ticking is not implemented") unholyaoe_burstmainactions()

   unless enemies() >= 2 and message("death_and_decay.ticking is not implemented") and unholyaoe_burstmainpostconditions()
   {
    #run_action_list,name=generic_aoe,if=active_enemies>=2&(!death_and_decay.ticking&(cooldown.death_and_decay.remains>10&!talent.defile.enabled|cooldown.defile.remains>10&talent.defile.enabled))
    if enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } unholygeneric_aoemainactions()

    unless enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } and unholygeneric_aoemainpostconditions()
    {
     #call_action_list,name=generic,if=active_enemies=1
     if enemies() == 1 unholygenericmainactions()
    }
   }
  }
 }
}

AddFunction unholy_defaultmainpostconditions
{
 unholycooldownsmainpostconditions() or enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") and unholyaoe_setupmainpostconditions() or enemies() >= 2 and message("death_and_decay.ticking is not implemented") and unholyaoe_burstmainpostconditions() or enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } and unholygeneric_aoemainpostconditions() or enemies() == 1 and unholygenericmainpostconditions()
}

AddFunction unholy_defaultshortcdactions
{
 #auto_attack
 unholygetinmeleerange()

 unless { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and spell(berserking)
 {
  #bag_of_tricks,if=buff.unholy_strength.up&active_enemies=1
  if buffpresent(unholy_strength) and enemies() == 1 spell(bag_of_tricks)

  unless target.debuffrefreshable(virulent_plague) and not hastalent(unholy_blight_talent) and not false(raid_event_adds_exists) and spell(outbreak) or target.debuffrefreshable(virulent_plague) and { not hastalent(unholy_blight_talent) or hastalent(unholy_blight_talent) and spellcooldown(unholy_blight) > 0 } and enemies() >= 2 and spell(outbreak)
  {
   #call_action_list,name=cooldowns
   unholycooldownsshortcdactions()

   unless unholycooldownsshortcdpostconditions()
   {
    #run_action_list,name=aoe_setup,if=active_enemies>=2&(cooldown.death_and_decay.remains<10&!talent.defile.enabled|cooldown.defile.remains<10&talent.defile.enabled)&!death_and_decay.ticking
    if enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") unholyaoe_setupshortcdactions()

    unless enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") and unholyaoe_setupshortcdpostconditions()
    {
     #run_action_list,name=aoe_burst,if=active_enemies>=2&death_and_decay.ticking
     if enemies() >= 2 and message("death_and_decay.ticking is not implemented") unholyaoe_burstshortcdactions()

     unless enemies() >= 2 and message("death_and_decay.ticking is not implemented") and unholyaoe_burstshortcdpostconditions()
     {
      #run_action_list,name=generic_aoe,if=active_enemies>=2&(!death_and_decay.ticking&(cooldown.death_and_decay.remains>10&!talent.defile.enabled|cooldown.defile.remains>10&talent.defile.enabled))
      if enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } unholygeneric_aoeshortcdactions()

      unless enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } and unholygeneric_aoeshortcdpostconditions()
      {
       #call_action_list,name=generic,if=active_enemies=1
       if enemies() == 1 unholygenericshortcdactions()
      }
     }
    }
   }
  }
 }
}

AddFunction unholy_defaultshortcdpostconditions
{
 { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and spell(berserking) or target.debuffrefreshable(virulent_plague) and not hastalent(unholy_blight_talent) and not false(raid_event_adds_exists) and spell(outbreak) or target.debuffrefreshable(virulent_plague) and { not hastalent(unholy_blight_talent) or hastalent(unholy_blight_talent) and spellcooldown(unholy_blight) > 0 } and enemies() >= 2 and spell(outbreak) or unholycooldownsshortcdpostconditions() or enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") and unholyaoe_setupshortcdpostconditions() or enemies() >= 2 and message("death_and_decay.ticking is not implemented") and unholyaoe_burstshortcdpostconditions() or enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } and unholygeneric_aoeshortcdpostconditions() or enemies() == 1 and unholygenericshortcdpostconditions()
}

AddFunction unholy_defaultcdactions
{
 unholyinterruptactions()
 #variable,name=pooling_for_gargoyle,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle.enabled
 #arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle.enabled)&rune.deficit>=5
 if runicpowerdeficit() > 65 and { pet.present() or not hastalent(summon_gargoyle_talent) } and runedeficit() >= 5 spell(arcane_torrent)
 #blood_fury,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
 if pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } spell(blood_fury)

 unless { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and spell(berserking)
 {
  #lights_judgment,if=buff.unholy_strength.up
  if buffpresent(unholy_strength) spell(lights_judgment)
  #ancestral_call,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
  if pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } spell(ancestral_call)
  #arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
  if enemies() >= 2 or runedeficit() >= 5 and runicpowerdeficit() >= 60 spell(arcane_pulse)
  #fireblood,if=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned.enabled&(pet.army_ghoul.active|cooldown.army_of_the_dead.remains>target.time_to_die)
  if pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } spell(fireblood)

  unless buffpresent(unholy_strength) and enemies() == 1 and spell(bag_of_tricks) or target.debuffrefreshable(virulent_plague) and not hastalent(unholy_blight_talent) and not false(raid_event_adds_exists) and spell(outbreak) or target.debuffrefreshable(virulent_plague) and { not hastalent(unholy_blight_talent) or hastalent(unholy_blight_talent) and spellcooldown(unholy_blight) > 0 } and enemies() >= 2 and spell(outbreak)
  {
   #call_action_list,name=cooldowns
   unholycooldownscdactions()

   unless unholycooldownscdpostconditions()
   {
    #run_action_list,name=aoe_setup,if=active_enemies>=2&(cooldown.death_and_decay.remains<10&!talent.defile.enabled|cooldown.defile.remains<10&talent.defile.enabled)&!death_and_decay.ticking
    if enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") unholyaoe_setupcdactions()

    unless enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") and unholyaoe_setupcdpostconditions()
    {
     #run_action_list,name=aoe_burst,if=active_enemies>=2&death_and_decay.ticking
     if enemies() >= 2 and message("death_and_decay.ticking is not implemented") unholyaoe_burstcdactions()

     unless enemies() >= 2 and message("death_and_decay.ticking is not implemented") and unholyaoe_burstcdpostconditions()
     {
      #run_action_list,name=generic_aoe,if=active_enemies>=2&(!death_and_decay.ticking&(cooldown.death_and_decay.remains>10&!talent.defile.enabled|cooldown.defile.remains>10&talent.defile.enabled))
      if enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } unholygeneric_aoecdactions()

      unless enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } and unholygeneric_aoecdpostconditions()
      {
       #call_action_list,name=generic,if=active_enemies=1
       if enemies() == 1 unholygenericcdactions()
      }
     }
    }
   }
  }
 }
}

AddFunction unholy_defaultcdpostconditions
{
 { pet.present() or buffpresent(unholy_assault) or hastalent(army_of_the_damned_talent) and { pet.present() or spellcooldown(army_of_the_dead) > target.timetodie() } } and spell(berserking) or buffpresent(unholy_strength) and enemies() == 1 and spell(bag_of_tricks) or target.debuffrefreshable(virulent_plague) and not hastalent(unholy_blight_talent) and not false(raid_event_adds_exists) and spell(outbreak) or target.debuffrefreshable(virulent_plague) and { not hastalent(unholy_blight_talent) or hastalent(unholy_blight_talent) and spellcooldown(unholy_blight) > 0 } and enemies() >= 2 and spell(outbreak) or unholycooldownscdpostconditions() or enemies() >= 2 and { spellcooldown(death_and_decay) < 10 and not hastalent(defile_talent) or spellcooldown(defile) < 10 and hastalent(defile_talent) } and not message("death_and_decay.ticking is not implemented") and unholyaoe_setupcdpostconditions() or enemies() >= 2 and message("death_and_decay.ticking is not implemented") and unholyaoe_burstcdpostconditions() or enemies() >= 2 and not message("death_and_decay.ticking is not implemented") and { spellcooldown(death_and_decay) > 10 and not hastalent(defile_talent) or spellcooldown(defile) > 10 and hastalent(defile_talent) } and unholygeneric_aoecdpostconditions() or enemies() == 1 and unholygenericcdpostconditions()
}

### Unholy icons.

AddCheckBox(opt_deathknight_unholy_aoe l(aoe) default specialization=unholy)

AddIcon checkbox=!opt_deathknight_unholy_aoe enemies=1 help=shortcd specialization=unholy
{
 if not incombat() unholyprecombatshortcdactions()
 unholy_defaultshortcdactions()
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=shortcd specialization=unholy
{
 if not incombat() unholyprecombatshortcdactions()
 unholy_defaultshortcdactions()
}

AddIcon enemies=1 help=main specialization=unholy
{
 if not incombat() unholyprecombatmainactions()
 unholy_defaultmainactions()
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=aoe specialization=unholy
{
 if not incombat() unholyprecombatmainactions()
 unholy_defaultmainactions()
}

AddIcon checkbox=!opt_deathknight_unholy_aoe enemies=1 help=cd specialization=unholy
{
 if not incombat() unholyprecombatcdactions()
 unholy_defaultcdactions()
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=cd specialization=unholy
{
 if not incombat() unholyprecombatcdactions()
 unholy_defaultcdactions()
}

### Required symbols
# ancestral_call
# any_dnd
# apocalypse
# arcane_pulse
# arcane_torrent
# army_of_the_damned_talent
# army_of_the_dead
# asphyxiate
# bag_of_tricks
# berserking
# blood_fury
# concentrated_flame_essence
# convocation_of_the_dead_conduit
# dark_transformation
# deadliest_coil_runeforge
# death_and_decay
# death_coil
# death_strike
# defile
# defile_talent
# epidemic
# festering_strike
# festering_wound
# fireblood
# lights_judgment
# mind_freeze
# outbreak
# potion_of_unbridled_fury_item
# raise_dead
# soul_reaper
# sudden_doom_buff
# summon_gargoyle
# summon_gargoyle_talent
# unholy_assault
# unholy_blight
# unholy_blight_talent
# unholy_pact_talent
# unholy_strength
# virulent_plague
# war_stomp
# wound_spender
]]
        OvaleScripts:RegisterScript("DEATHKNIGHT", "unholy", name, desc, code, "script")
    end
end
