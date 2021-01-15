import { OvaleScriptsClass } from "../engine/scripts";

export function registerDeathKnightSpells(OvaleScripts: OvaleScriptsClass) {
    const name = "ovale_deathknight_spells";
    const desc = "[9.0] Ovale: Death Knight spells";

    // THIS PART OF THIS FILE IS AUTOMATICALLY GENERATED
    let code = `Define(abomination_limb 315443)
# Sprout an additional limb, dealing 323798s1*13 Shadow damage over 12 seconds to 323798i nearby enemies. Every t1 sec, an enemy is pulled to your location if they are further than 323710s3 yds from you. The same enemy can only be pulled once every 4 seconds.rnrnGain ?a137008[s3 Bone Shield charges][]?a137006[Rime][]?a137007[Runic Corruption][] instantly, and again every s4 sec.
  SpellInfo(abomination_limb cd=120 duration=12 tick=1)
  # Recently pulled  by Abomination Limb and can't be pulled again.
  SpellAddBuff(abomination_limb abomination_limb_buff add=1)
  # Pulling enemies to your location and dealing 323798s1 Shadow damage to nearby enemies every t1 sec.
  SpellAddBuff(abomination_limb abomination_limb add=1)
Define(abomination_limb_buff 323710)
# Sprout an additional limb, dealing 323798s1*13 Shadow damage over 12 seconds to 323798i nearby enemies. Every t1 sec, an enemy is pulled to your location if they are further than 323710s3 yds from you. The same enemy can only be pulled once every 4 seconds.rnrnGain ?a137008[s3 Bone Shield charges][]?a137006[Rime][]?a137007[Runic Corruption][] instantly, and again every s4 sec.
  SpellInfo(abomination_limb_buff duration=4 gcd=0 offgcd=1)
Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you a random secondary stat for 15 seconds.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
Define(apocalypse 275699)
# Bring doom upon the enemy, dealing sw1 Shadow damage and bursting up to s2 Festering Wounds on the target.rnrnSummons an Army of the Dead ghoul for 15 seconds for each burst Festering Wound.?a343755[rnrn|cFFFFFFFFGenerates 343758s3 Runes.|r][]
  SpellInfo(apocalypse cd=90)
Define(arcane_pulse 260364)
# Deals <damage> Arcane damage to nearby enemies and reduces their movement speed by 260369s1. Lasts 12 seconds.
  SpellInfo(arcane_pulse cd=180 gcd=1)
  # Reduces movement speed by w1.
  SpellAddBuff(arcane_pulse arcane_pulse_buff add=1)
Define(arcane_pulse_buff 260369)
# Reduces movement speed by s1.
  SpellInfo(arcane_pulse_buff duration=12 gcd=0 offgcd=1)
Define(arcane_torrent 25046)
# Remove s1 beneficial effect from all enemies within A1 yards and restore m2 Energy.
  SpellInfo(arcane_torrent cd=120 gcd=1 energy=-15)
Define(army_of_the_dead 42650)
# Summons a legion of ghouls who swarms your enemies, fighting anything they can for 30 seconds.
  SpellInfo(army_of_the_dead runes=1 runicpower=-10 cd=480 duration=4 tick=0.5)
  # Summoning ghouls.
  SpellAddBuff(army_of_the_dead army_of_the_dead add=1)
Define(asphyxiate 221562)
# Lifts the enemy target off the ground, crushing their throat with dark energy and stunning them for 5 seconds.
  SpellInfo(asphyxiate cd=45 duration=5)
  # Stunned.
  SpellAddTargetDebuff(asphyxiate asphyxiate add=1)
Define(bag_of_tricks 312411)
# Pull your chosen trick from the bag and use it on target enemy or ally. Enemies take <damage> damage, while allies are healed for <healing>. 
  SpellInfo(bag_of_tricks cd=90)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
Define(berserking_buff 26297)
# Increases your haste by s1 for 12 seconds.
  SpellInfo(berserking_buff cd=180 duration=12 gcd=0 offgcd=1)
  # Haste increased by s1.
  SpellAddBuff(berserking_buff berserking_buff add=1)
Define(blinding_sleet 207167)
# Targets in a cone in front of you are blinded, causing them to wander disoriented for 5 seconds. Damage may cancel the effect.rnrnWhen Blinding Sleet ends, enemies are slowed by 317898s1 for 6 seconds.
  SpellInfo(blinding_sleet cd=60 duration=5)
  SpellRequire(blinding_sleet unusable set=1 enabled=(not hastalent(blinding_sleet_talent)))
  # Disoriented.
  SpellAddTargetDebuff(blinding_sleet blinding_sleet add=1)
Define(blood_boil 50842)
# Deals s1 Shadow damage?s212744[ to all enemies within A1 yds.][ and infects all enemies within A1 yds with Blood Plague.rnrn|Tinterfaceiconsspell_deathknight_bloodplague.blp:24|t |cFFFFFFFFBlood Plague|rrnA shadowy disease that drains o1 health from the target over 24 seconds.  ]
  SpellInfo(blood_boil cd=7.5)
Define(blood_fury 20572)
# Increases your attack power by s1 for 15 seconds.
  SpellInfo(blood_fury cd=120 duration=15 gcd=0 offgcd=1)
  # Attack power increased by w1.
  SpellAddBuff(blood_fury blood_fury add=1)
Define(blood_plague 55078)
# A shadowy disease that drains o1 health from the target over 24 seconds.  
  SpellInfo(blood_plague duration=24 gcd=0 offgcd=1 tick=3)
Define(blood_tap 221699)
# Consume the essence around you to generate s1 Rune.rnrnRecharge time reduced by s2 sec whenever a Bone Shield charge is consumed.
  SpellInfo(blood_tap cd=60 gcd=0 offgcd=1 runes=-1)
  SpellRequire(blood_tap unusable set=1 enabled=(not hastalent(blood_tap_talent)))
Define(blooddrinker 206931)
# Drains o1 health from the target over 3 seconds.rnrnYou can move, parry, dodge, and use defensive abilities while channeling this ability.
  SpellInfo(blooddrinker runes=1 runicpower=-10 cd=30 duration=3 channel=3 tick=1)
  SpellRequire(blooddrinker unusable set=1 enabled=(not hastalent(blooddrinker_talent)))
  # Draining s1 health from the target every t1 sec.
  SpellAddTargetDebuff(blooddrinker blooddrinker add=1)
Define(bone_shield 195181)
# Surrounds you with a barrier of whirling bones, increasing Armor by s1*STR/100?s316746[, and your Haste by s4][]. Each melee attack against you consumes a charge. Lasts 30 seconds or until all charges are consumed.
  SpellInfo(bone_shield duration=30 max_stacks=10 gcd=0 offgcd=1)
  # Armor increased by w1*STR/100.rnHaste increased by w4.
  SpellAddBuff(bone_shield bone_shield add=1)
Define(bonestorm 194844)
# A whirl of bone and gore batters up to 196528s2 nearby enemies, dealing 196528s1 Shadow damage every t3 sec, and healing you for 196545s1 of your maximum health every time it deals damage (up to s1*s4). Lasts t3 sec per s3 Runic Power spent.
  SpellInfo(bonestorm runicpower=10 max_runicpower=90 cd=60 duration=1 tick=1)
  SpellRequire(bonestorm unusable set=1 enabled=(not hastalent(bonestorm_talent)))
  # Dealing 196528s1 Shadow damage to nearby enemies every t3 sec, and healing for 196545s1 of maximum health for each target hit (up to s1*s4).
  SpellAddBuff(bonestorm bonestorm add=1)
Define(breath_of_sindragosa 152279)
# Continuously deal 155166s2*<CAP>/AP Frost damage every t1 sec to enemies in a cone in front of you, until your Runic Power is exhausted. Deals reduced damage to secondary targets.rnrn|cFFFFFFFFGenerates 303753s1 lRune:Runes; at the start and end.|r
  SpellInfo(breath_of_sindragosa cd=120 gcd=0 offgcd=1 tick=1)
  SpellRequire(breath_of_sindragosa unusable set=1 enabled=(not hastalent(breath_of_sindragosa_talent)))
  # Continuously dealing Frost damage every t1 sec to enemies in a cone in front of you.
  SpellAddBuff(breath_of_sindragosa breath_of_sindragosa add=1)
Define(chains_of_ice 45524)
# Shackles the target with frozen chains, reducing movement speed by s1 for 8 seconds.
  SpellInfo(chains_of_ice runes=1 runicpower=-10 duration=8)
  # Movement slowed s1 by frozen chains.
  SpellAddTargetDebuff(chains_of_ice chains_of_ice add=1)
Define(clawing_shadows 207311)
# Deals s2 Shadow damage and causes 1 Festering Wound to burst.
  SpellInfo(clawing_shadows runes=1 runicpower=-10)
  SpellRequire(clawing_shadows unusable set=1 enabled=(not hastalent(clawing_shadows_talent)))
Define(cold_heart_buff 281209)
# Every t1 sec, gain a stack of Cold Heart, causing your next Chains of Ice to deal 281210s1 Frost damage. Stacks up to 281209u times.
  SpellInfo(cold_heart_buff max_stacks=20 gcd=0 offgcd=1)
Define(consumption 274156)
# Strikes up to s3 enemies in front of you with a hungering attack that deals sw1 Physical damage and heals you for e1*100 of that damage.
  SpellInfo(consumption cd=30)
  SpellRequire(consumption unusable set=1 enabled=(not hastalent(consumption_talent)))
Define(crimson_scourge_buff 81141)
# Your auto attacks on targets infected with your Blood Plague have a chance to make your next Death and Decay cost no runes and reset its cooldown.
  SpellInfo(crimson_scourge_buff duration=15 gcd=0 offgcd=1)
  # Your next Death and Decay costs no Runes and generates no Runic Power.
  SpellAddBuff(crimson_scourge_buff crimson_scourge_buff add=1)
Define(dancing_rune_weapon 49028)
# Summons a rune weapon for 8 seconds that mirrors your melee attacks and bolsters your defenses.rnrnWhile active, you gain 81256s1 parry chance.
  SpellInfo(dancing_rune_weapon cd=120 duration=13)
Define(dancing_rune_weapon_buff 81256)
# Summons a rune weapon for 8 seconds that mirrors your melee attacks and bolsters your defenses.rnrnWhile active, you gain 81256s1 parry chance.
  SpellInfo(dancing_rune_weapon_buff duration=8 gcd=0 offgcd=1)
  # Parry chance increased by s1.
  SpellAddBuff(dancing_rune_weapon_buff dancing_rune_weapon_buff add=1)
Define(dark_transformation 63560)
# Your ?s207313[abomination]?s58640[geist][ghoul] deals 344955s1 Shadow damage to 344955s2 nearby enemies and transforms into a powerful undead monstrosity for 15 seconds. ?s325554[Granting them 325554s1 energy and the][The] ?s207313[abomination]?s58640[geist][ghoul]'s abilities are empowered and take on new functions while the transformation is active.
  SpellInfo(dark_transformation cd=60 duration=15)
  # ?w2>0[Transformed into an undead monstrosity.][Gassy.]rnDamage dealt increased by w1.
  SpellAddBuff(dark_transformation dark_transformation add=1)
Define(death_and_decay 43265)
# Corrupts the targeted ground, causing 52212m1*11 Shadow damage over 10 seconds to targets within the area.?!c2[rnrnWhile you remain within the area, your ][]?s223829&!c2[Necrotic Strike and ][]?c1[Heart Strike will hit up to 188290m3 additional targets.]?s207311&!c2[Clawing Shadows will hit up to 55090s4-1 enemies near the target.]?!c2[Scourge Strike will hit up to 55090s4-1 enemies near the target.][]
  SpellInfo(death_and_decay runes=1 runicpower=-10 cd=30 duration=10 tick=1)
  SpellRequire(death_and_decay replaced_by set=defile enabled=(hastalent(defile_talent)))
Define(death_coil 47541)
# Fires a blast of unholy energy at the target, causing 47632s1 Shadow damage to an enemy or healing an Undead ally for 47633s1 health.?s316941[rnrnReduces the cooldown of Dark Transformation by s2/1000 sec.][]
  SpellInfo(death_coil runicpower=40)
Define(death_strike 49998)
# Focuses dark power into a strike?s137006[ with both weapons, that deals a total of s1+66188s1][ that deals s1] Physical damage and heals you for s2 of all damage taken in the last s4 sec, minimum s3.1 of maximum health.
  SpellInfo(death_strike runicpower=45)
Define(deaths_due 324165)
# Corrupts the targeted ground, causing 341340m1*11 Shadow damage over 10 seconds to targets within the area.?!c2[rnrnWhile you remain within the area, your ][]?s223829&!c2[Necrotic Strike and ][]?c1[Heart Strike will hit up to 188290m3 additional targets and inflict Death's Due for 12 seconds.]?s207311&!c2[Clawing Shadows will hit up to 55090s4-1 enemies near the target and inflict Death's Due for 12 seconds.]?!c2[Scourge Strike will hit up to 55090s4-1 enemies near the target and inflict Death's Due for 12 seconds.][rnrnWhile you remain within the area, your Obliterate will hit up to 315442s2 additional target and inflict Death's Due for 12 seconds.]rnrnDeath's Due reduces damage enemies deal to you by 324164s1, up to a maximum of 324164s1*-324164u and their power is transferred to you as an equal amount of Strength.
  SpellInfo(deaths_due duration=12 max_stacks=8 gcd=0 offgcd=1)
  # Strength increased by s1.
  SpellAddBuff(deaths_due deaths_due add=1)
Define(deaths_due_buff 315442)
# Learn Death's Due, replacing Death and Decay.rn
  SpellInfo(deaths_due_buff gcd=0 offgcd=1)
  # Drain power from each enemy within the area, reducing their damage done by 10 and increasing your Strength by 80 for 10 sec.
  SpellAddBuff(deaths_due_buff deaths_due_buff add=1)
Define(defile 152280)
# Defile the targeted ground, dealing (156000s1*(10 seconds+1)/t3) Shadow damage to all enemies over 10 seconds.rnrnWhile you remain within your Defile, your ?s207311[Clawing Shadows][Scourge Strike] will hit 55090s4-1 enemies near the target?a315442|a331119[ and inflict Death's Due for 12 seconds.rnrnDeath's Due reduces damage enemies deal to you by 324164s1, up to a maximum of 324164s1*-324164u and their power is transferred to you as an equal amount of Strength.][.]rnrnIf any enemies are standing in the Defile, it grows in size and deals increasing damage every sec.
  SpellInfo(defile runes=1 runicpower=-10 cd=20 duration=10 tick=1)
  SpellRequire(defile unusable set=1 enabled=(not hastalent(defile_talent)))
Define(empower_rune_weapon 47568)
# Empower your rune weapon, gaining s3 Haste and generating s1 LRune:Runes; and m2/10 Runic Power instantly and every t1 sec for 20 seconds.
  SpellInfo(empower_rune_weapon cd=120 duration=20 gcd=0 offgcd=1 tick=5)
  # Haste increased by s3.rnGenerating s1 LRune:Runes; and m2/10 Runic Power every t1 sec.
  SpellAddBuff(empower_rune_weapon empower_rune_weapon add=1)
Define(epidemic 207317)
# Causes each of your Virulent Plagues to flare up, dealing 212739s1 Shadow damage to the infected enemy, and an additional 215969s2 Shadow damage to all other enemies near them.
  SpellInfo(epidemic runicpower=30)
Define(eradicating_blow 337936)
# Obliterate increases the damage of your next Frost Strike by |cFFFFFFFFs1.1|r, stacks up to 337936u times.
  SpellInfo(eradicating_blow duration=10 max_stacks=2 gcd=0 offgcd=1)
  # Frost Strike damage increased by w1.
  SpellAddBuff(eradicating_blow eradicating_blow add=1)
Define(festering_strike 85948)
# Strikes for s1 Physical damage and infects the target with m2-M2 Festering Wounds.rnrn|Tinterfaceiconsspell_yorsahj_bloodboil_purpleoil.blp:24|t |cFFFFFFFFFestering Wound|rrnA pustulent lesion that will burst on death or when damaged by Scourge Strike, dealing 194311s1 Shadow damage and generating 195757s1 Runic Power.
  SpellInfo(festering_strike runes=2 runicpower=-20)
Define(festering_wound 194310)
# A pustulent lesion that will burst on death or when damaged by Scourge Strike, dealing 194311s1 Shadow damage and generating 195757s1 Runic Power.
  SpellInfo(festering_wound duration=30 max_stacks=6 gcd=0 offgcd=1)
  # Suffering from a wound that will deal 194311s1/s1 Shadow damage when damaged by Scourge Strike.
  SpellAddTargetDebuff(festering_wound festering_wound add=1)
Define(fireblood 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood cd=120 gcd=0 offgcd=1)
Define(fireblood_buff 265226)
# Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by s1.
  SpellInfo(fireblood_buff duration=8 max_stacks=6 gcd=0 offgcd=1)
  # Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by w1.
  SpellAddBuff(fireblood_buff fireblood_buff add=1)
Define(frost_fever 55095)
# A disease that deals o1*<CAP>/AP Frost damage over 24 seconds and has a chance to grant the Death Knight 195617m1/10 Runic Power each time it deals damage.
  SpellInfo(frost_fever duration=24 gcd=0 offgcd=1 tick=3)
  # Suffering w1 Frost damage every t1 sec.
  SpellAddTargetDebuff(frost_fever frost_fever add=1)
Define(frost_strike 49143)
# Chill your ?owb==0[weapon with icy power and quickly strike the enemy, dealing <2hDamage> Frost damage.][weapons with icy power and quickly strike the enemy with both, dealing a total of <dualWieldDamage> Frost damage.]
  SpellInfo(frost_strike runicpower=25)
Define(frostscythe 207230)
# A sweeping attack that strikes up to s5 enemies in front of you for s2 Frost damage. This attack benefits from Killing Machine. Critical strikes with Frostscythe deal s3 times normal damage.
  SpellInfo(frostscythe runes=1 runicpower=-10)
  SpellRequire(frostscythe unusable set=1 enabled=(not hastalent(frostscythe_talent)))
Define(frostwyrms_fury 279302)
# Summons a frostwyrm who breathes on all enemies within s1 yd in front of you, dealing 279303s1 Frost damage and slowing movement speed by (25 of Spell Power) for 10 seconds.
  SpellInfo(frostwyrms_fury cd=180 duration=10)
Define(frozen_pulse_frost 194909)
# While you have fewer than m2 full LRune:Runes;, your auto attacks radiate intense cold, inflicting 195750s1 Frost damage on all nearby enemies.
  SpellInfo(frozen_pulse_frost gcd=0 offgcd=1 unusable=1)
  SpellRequire(frozen_pulse_frost unusable set=1 enabled=(not hastalent(frozen_pulse_talent)))
Define(glacial_advance 194913)
# Summon glacial spikes from the ground that advance forward, each dealing 195975s1*<CAP>/AP Frost damage and applying Razorice to enemies near their eruption point.
  SpellInfo(glacial_advance runicpower=30 cd=6)
  SpellRequire(glacial_advance unusable set=1 enabled=(not hastalent(glacial_advance_talent)))
Define(heart_strike 206930)
# Instantly strike the target and 1 other nearby enemy, causing s2 Physical damage, and reducing enemies' movement speed by s5 for 8 seconds?s316575[rnrn|cFFFFFFFFGenerates s3 bonus Runic Power][]?s221536[, plus 210738s1/10 Runic Power per additional enemy struck][].|r
  SpellInfo(heart_strike runes=1 runicpower=-10 duration=8)
  # Movement speed reduced by s5.
  SpellAddTargetDebuff(heart_strike heart_strike add=1)
Define(hemostasis_buff 273947)
# Each enemy hit by Blood Boil increases the damage and healing done by your next Death Strike by 273947s1, stacking up to 273947u times.
  SpellInfo(hemostasis_buff duration=15 max_stacks=5 gcd=0 offgcd=1)
Define(horn_of_winter 57330)
# Blow the Horn of Winter, gaining s1 LRune:Runes; and generating s2/10 Runic Power.
  SpellInfo(horn_of_winter cd=45 runes=-2 runicpower=-25)
  SpellRequire(horn_of_winter unusable set=1 enabled=(not hastalent(horn_of_winter_talent)))
Define(howling_blast 49184)
# Blast the target with a frigid wind, dealing s1*<CAP>/AP ?s204088[Frost damage and applying Frost Fever to the target.][Frost damage to that foe, and reduced damage to all other enemies within 237680A1 yards, infecting all targets with Frost Fever.]rnrn|Tinterfaceiconsspell_deathknight_frostfever.blp:24|t |cFFFFFFFFFrost Fever|rrnA disease that deals o1*<CAP>/AP Frost damage over 24 seconds and has a chance to grant the Death Knight 195617m1/10 Runic Power each time it deals damage.
  SpellInfo(howling_blast runes=1 runicpower=-10)
Define(hypothermic_presence 321995)
# Embrace the ice in your veins, reducing the Runic Power cost of your abilities by s1 for 8 seconds. Does not trigger the global cooldown.
  SpellInfo(hypothermic_presence cd=45 duration=8 gcd=0 offgcd=1)
  SpellRequire(hypothermic_presence unusable set=1 enabled=(not hastalent(hypothermic_presence_talent)))
  # The Runic Power cost of your abilities is reduced by s1.
  SpellAddBuff(hypothermic_presence hypothermic_presence add=1)
Define(icy_talons_buff 194879)
# Your Runic Power spending abilities increase your melee attack speed by 194879s1 for 6 seconds, stacking up to 194879u times.
  SpellInfo(icy_talons_buff duration=6 max_stacks=3 gcd=0 offgcd=1)
Define(inscrutable_quantum_device 330323)
# ???
  SpellInfo(inscrutable_quantum_device cd=180 gcd=0 offgcd=1)
Define(killing_machine_frost 317214)
# Your next Obliterate also deals Frost damage.
  SpellInfo(killing_machine_frost gcd=0 offgcd=1 unusable=1)
Define(lights_judgment 255647)
# Call down a strike of Holy energy, dealing <damage> Holy damage to enemies within A1 yards after 3 sec.
  SpellInfo(lights_judgment cd=150)
Define(marrowrend 195182)
# Smash the target, dealing s2 Physical damage and generating s3 charges of Bone Shield.rnrn|Tinterfaceiconsability_deathknight_boneshield.blp:24|t |cFFFFFFFFBone Shield|rrnSurrounds you with a barrier of whirling bones, increasing Armor by s1*STR/100?s316746[, and your Haste by s4][]. Each melee attack against you consumes a charge. Lasts 30 seconds or until all charges are consumed.
  SpellInfo(marrowrend runes=2 runicpower=-20)
Define(mind_freeze 47528)
# Smash the target's mind with cold, interrupting spellcasting and preventing any spell in that school from being cast for 3 seconds.
  SpellInfo(mind_freeze cd=15 duration=3 gcd=0 offgcd=1 interrupt=1)
Define(obliterate 49020)
# A brutal attack ?owb==0[that deals <2hDamage> Physical damage.][with both weapons that deals a total of <dualWieldDamage> Physical damage.]
  SpellInfo(obliterate runes=2 runicpower=-20)
Define(outbreak 77575)
# Deals s1 Shadow damage to the target and infects all nearby enemies with Virulent Plague.rnrn|Tinterfaceiconsability_creature_disease_02.blp:24|t |cFFFFFFFFVirulent Plague|rrnA disease that deals o Shadow damage over 27 seconds. It erupts when the infected target dies, dealing 191685s1 Shadow damage to nearby enemies.
  SpellInfo(outbreak runes=1 runicpower=-10)
  # Suffering w1 Shadow damage every t1 sec.rnErupts for 191685s1 damage split among all nearby enemies when the infected dies.
  SpellAddTargetDebuff(outbreak virulent_plague add=1)
Define(pillar_of_frost 51271)
# The power of frost increases your Strength by s1 for 12 seconds.rnrnEach Rune spent while active increases your Strength by an additional s2.
  SpellInfo(pillar_of_frost cd=60 duration=12 gcd=0 offgcd=1)
  # Strength increased by w1.
  SpellAddBuff(pillar_of_frost pillar_of_frost add=1)
Define(raise_dead 46585)
# Raises a ?s58640[geist][ghoul] to fight by your side.  You can have a maximum of one ?s58640[geist][ghoul] at a time.  Lasts 60 seconds.
  SpellInfo(raise_dead cd=120 duration=60 gcd=0 offgcd=1)
  SpellRequire(raise_dead replaced_by set=raise_dead_unholy enabled=(specialization("unholy")))
Define(raise_dead_unholy 46584)
# Raises ?s207313[an abomination]?s58640[a geist][a ghoul] to fight by your side. You can have a maximum of one ?s207313[abomination]?s58640[geist][ghoul] at a time.
  SpellInfo(raise_dead_unholy cd=30)
  # A Risen Ally is in your service.
  SpellAddBuff(raise_dead_unholy raise_dead_unholy add=1)
Define(razorice 51714)
# Engrave your weapon with a rune that causes 50401s1 extra weapon damage as Frost damage and increases enemies' vulnerability to your Frost attacks by 51714s1, stacking up to 51714u times. ?a332944[][rnrnModifying your rune requires a Runeforge in Ebon Hold.]
  SpellInfo(razorice duration=20 max_stacks=5 gcd=0 offgcd=1 tick=1)
  # Frost damage taken from the Death Knight's abilities increased by s1.
  SpellAddTargetDebuff(razorice razorice add=1)
Define(remorseless_winter 196770)
# Drain the warmth of life from all nearby enemies within 196771A1 yards, dealing 9*196771s1*<CAP>/AP Frost damage over 8 seconds and reducing their movement speed by 211793s1.
  SpellInfo(remorseless_winter runes=1 runicpower=-10 cd=20 duration=8 tick=1)
  # Dealing 196771s1 Frost damage to enemies within 196771A1 yards each second.
  SpellAddBuff(remorseless_winter remorseless_winter add=1)
Define(rime_frost 316838)
# Increases Howling Blasts damage done by an additional s1.
  SpellInfo(rime_frost gcd=0 offgcd=1 unusable=1)
Define(runic_corruption 51460)
# Increases your rune regeneration rate for 3 seconds.
  SpellInfo(runic_corruption duration=3 gcd=0 offgcd=1)
  # Rune regeneration rate increased by w1.
  SpellAddBuff(runic_corruption runic_corruption add=1)
Define(sacrificial_pact 327574)
# Sacrifice your ghoul to deal 327611s1 Shadow damage to 327611s2 nearby enemies and heal for s1 of your maximum health.
  SpellInfo(sacrificial_pact runicpower=20 cd=120)
Define(scourge_strike 55090)
# An unholy strike that deals s2 Physical damage and 70890sw2 Shadow damage, and causes 1 Festering Wound to burst.
  SpellInfo(scourge_strike runes=1 runicpower=-10)
  SpellRequire(scourge_strike replaced_by set=clawing_shadows enabled=(hastalent(clawing_shadows_talent)))
Define(shackle_the_unworthy 312202)
# Admonish your target for their past transgressions, reducing the damage they deal to you by s2 and dealing o Arcane damage over 14 seconds.rnrnWhile Shackle the Unworthy is active on an enemy, your direct-damage attacks that spend runes have a s5 chance to spread Shackle the Unworthy to a nearby enemy.
  SpellInfo(shackle_the_unworthy cd=60 duration=14 tick=2)
  # Suffering w1 Arcane damage every t1 sec. Dealing s2 less damage to @auracaster.
  SpellAddBuff(shackle_the_unworthy shackle_the_unworthy add=1)
  # Suffering w1 Arcane damage every t1 sec. Dealing s2 less damage to @auracaster.
  SpellAddTargetDebuff(shackle_the_unworthy shackle_the_unworthy add=1)
Define(soul_reaper 343294)
# Strike an enemy for s1 Shadow damage and afflict the enemy with Soul Reaper. rnrnAfter 5 seconds, if the target is below s3 health this effect will explode dealing an additional 343295s1 Shadow damage to the target. If the enemy that yields experience or honor dies while afflicted by Soul Reaper, gain Runic Corruption.
  SpellInfo(soul_reaper runes=1 runicpower=-10 cd=6 duration=5 tick=5)
  SpellRequire(soul_reaper unusable set=1 enabled=(not hastalent(soul_reaper_talent)))
  # Afflicted by Soul Reaper, if the target is below s3 health this effect will explode dealing an additional 343295s1 Shadow damage.
  SpellAddTargetDebuff(soul_reaper soul_reaper add=1)
Define(sudden_doom_buff 81340)
# Your auto attacks have a chance to make your next Death Coil?s207317[ or Epidemic][] cost no Runic Power.
  SpellInfo(sudden_doom_buff duration=10 max_stacks=1 gcd=0 offgcd=1)
Define(summon_gargoyle 49206)
# Summon a Gargoyle into the area to bombard the target for 30 seconds.rnrnThe Gargoyle gains 211947s1 increased damage for every s4 Runic Power you spend.
  SpellInfo(summon_gargoyle cd=180 duration=35)
  SpellRequire(summon_gargoyle unusable set=1 enabled=(not hastalent(summon_gargoyle_talent)))
Define(swarming_mist 311648)
# A heavy mist surrounds you for 8 seconds, increasing your Dodge by s2. rnrnDeals 311730s1 Shadow damage every t1 sec to enemies within 311730A1 yds. Every time it deals damage you gain 312546s1/10 Runic Power, up to a maximum of 312546s1/10*s3 Runic Power. Deals reduced damage beyond s5 targets.
  SpellInfo(swarming_mist runes=1 runicpower=-10 cd=60 duration=8 tick=1)
  # Surrounded by a mist of Anima, increasing your chance to Dodge by s2 and dealing 311730s1 Shadow damage every t1 sec to nearby enemies.
  SpellAddBuff(swarming_mist swarming_mist add=1)
Define(tombstone 219809)
# Consume up to s5 Bone Shield charges. For each charge consumed, you gain s3 Runic Power and absorb damage equal to s4 of your maximum health for 8 seconds.
  SpellInfo(tombstone cd=60 duration=8 runicpower=0)
  SpellRequire(tombstone unusable set=1 enabled=(not hastalent(tombstone_talent)))
  # Absorbing w1 damage.
  SpellAddBuff(tombstone tombstone add=1)
Define(unholy_assault 207289)
# Strike your target dealing s2 Shadow damage, infecting the target with s3 Festering Wounds and sending you into an Unholy Frenzy increasing haste by s1 for 12 seconds.
  SpellInfo(unholy_assault cd=75 duration=12)
  SpellRequire(unholy_assault unusable set=1 enabled=(not hastalent(unholy_assault_talent)))
  # Haste increased by s1.
  SpellAddBuff(unholy_assault unholy_assault add=1)
Define(unholy_blight 115989)
# Surrounds yourself with a vile swarm of insects for 6 seconds, stinging all nearby enemies and infecting them with Virulent Plague and an unholy disease that deals 115994o1 damage over 14 seconds, stacking up to 115994u times.rnrnYour minions deal 115994s2 increased damage per stack to enemies infected by Unholy Blight.
  SpellInfo(unholy_blight runes=1 runicpower=-10 cd=45 duration=6 tick=1)
  SpellRequire(unholy_blight unusable set=1 enabled=(not hastalent(unholy_blight_talent)))
  # Suffering sw1 Shadow damage every t1 sec and taking increased damage from @auracaster's minions.
  SpellAddBuff(unholy_blight unholy_blight_buff add=1)
  # Surrounded by a vile swarm of insects, infecting enemies within 115994a1 yds with Virulent Plauge and an unholy disease that increases the damage your minions deal to them.
  SpellAddBuff(unholy_blight unholy_blight add=1)
Define(unholy_blight_buff 115994)
# Surrounds yourself with a vile swarm of insects for 6 seconds, stinging all nearby enemies and infecting them with Virulent Plague and an unholy disease that deals 115994o1 damage over 14 seconds, stacking up to 115994u times.rnrnYour minions deal 115994s2 increased damage per stack to enemies infected by Unholy Blight.
  SpellInfo(unholy_blight_buff duration=14 max_stacks=4 gcd=0 offgcd=1 tick=2)
Define(unholy_strength 53365)
# Affixes your rune weapon with a rune that has a chance to heal you for 53365s2 and increase total Strength by 53365s1 for 15 seconds.
  SpellInfo(unholy_strength duration=15 max_stacks=1 gcd=0 offgcd=1)
Define(unleashed_frenzy_buff 338501)
# Frost Strike increases your strength by |cFFFFFFFFs1.1|r for 6 seconds, stacks up to 338501u times.
  SpellInfo(unleashed_frenzy_buff duration=6 max_stacks=3 gcd=0 offgcd=1)
Define(virulent_plague 191587)
# A disease that deals o Shadow damage over 27 seconds. It erupts when the infected target dies, dealing 191685s1 Shadow damage to nearby enemies.
  SpellInfo(virulent_plague duration=27 gcd=0 offgcd=1 tick=3)
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp add=1)
Define(army_of_the_damned_talent 22030)
# ?s207317[Death Coil and Epidemic reduce][Death Coil reduces] the cooldown of Apocalypse by <cd1> sec and Army of the Dead by <cd2> sec. rnrnAdditionally Apocalypse and Army of the Dead summon a Magus of the Dead for 15 seconds who hurls Frostbolts and Shadow Bolts at your foes.rn
Define(avalanche_talent 22521)
# Casting Howling Blast with Rime active causes jagged icicles to fall on enemies nearby your target, dealing 207150s1 Frost damage.
Define(blinding_sleet_talent 22519)
# Targets in a cone in front of you are blinded, causing them to wander disoriented for 5 seconds. Damage may cancel the effect.rnrnWhen Blinding Sleet ends, enemies are slowed by 317898s1 for 6 seconds.
Define(blood_tap_talent 22135)
# Consume the essence around you to generate s1 Rune.rnrnRecharge time reduced by s2 sec whenever a Bone Shield charge is consumed.
Define(blooddrinker_talent 19166)
# Drains o1 health from the target over 3 seconds.rnrnYou can move, parry, dodge, and use defensive abilities while channeling this ability.
Define(bonestorm_talent 21209)
# A whirl of bone and gore batters up to 196528s2 nearby enemies, dealing 196528s1 Shadow damage every t3 sec, and healing you for 196545s1 of your maximum health every time it deals damage (up to s1*s4). Lasts t3 sec per s3 Runic Power spent.
Define(breath_of_sindragosa_talent 22537)
# Continuously deal 155166s2*<CAP>/AP Frost damage every t1 sec to enemies in a cone in front of you, until your Runic Power is exhausted. Deals reduced damage to secondary targets.rnrn|cFFFFFFFFGenerates 303753s1 lRune:Runes; at the start and end.|r
Define(clawing_shadows_talent 22026)
# Deals s2 Shadow damage and causes 1 Festering Wound to burst.
Define(cold_heart_talent 22018)
# Every t1 sec, gain a stack of Cold Heart, causing your next Chains of Ice to deal 281210s1 Frost damage. Stacks up to 281209u times.
Define(consumption_talent 19220)
# Strikes up to s3 enemies in front of you with a hungering attack that deals sw1 Physical damage and heals you for e1*100 of that damage.
Define(defile_talent 22536)
# Defile the targeted ground, dealing (156000s1*(10 seconds+1)/t3) Shadow damage to all enemies over 10 seconds.rnrnWhile you remain within your Defile, your ?s207311[Clawing Shadows][Scourge Strike] will hit 55090s4-1 enemies near the target?a315442|a331119[ and inflict Death's Due for 12 seconds.rnrnDeath's Due reduces damage enemies deal to you by 324164s1, up to a maximum of 324164s1*-324164u and their power is transferred to you as an equal amount of Strength.][.]rnrnIf any enemies are standing in the Defile, it grows in size and deals increasing damage every sec.
Define(frostscythe_talent 22525)
# A sweeping attack that strikes up to s5 enemies in front of you for s2 Frost damage. This attack benefits from Killing Machine. Critical strikes with Frostscythe deal s3 times normal damage.
Define(frozen_pulse_talent 22523)
# While you have fewer than m2 full LRune:Runes;, your auto attacks radiate intense cold, inflicting 195750s1 Frost damage on all nearby enemies.
Define(gathering_storm_talent 22531)
# Each Rune spent during Remorseless Winter increases its damage by 211805s1, and extends its duration by m1/10.1 sec.
Define(glacial_advance_talent 22535)
# Summon glacial spikes from the ground that advance forward, each dealing 195975s1*<CAP>/AP Frost damage and applying Razorice to enemies near their eruption point.
Define(heartbreaker_talent 19165)
# Heart Strike generates 210738s1/10 additional Runic Power per target hit.
Define(horn_of_winter_talent 22021)
# Blow the Horn of Winter, gaining s1 LRune:Runes; and generating s2/10 Runic Power.
Define(hypothermic_presence_talent 22533)
# Embrace the ice in your veins, reducing the Runic Power cost of your abilities by s1 for 8 seconds. Does not trigger the global cooldown.
Define(icecap_talent 22023)
# Your Frost Strike?s207230[, Frostscythe,][] and Obliterate critical strikes reduce the remaining cooldown of Pillar of Frost by <cd> sec.
Define(obliteration_talent 22109)
# While Pillar of Frost is active, Frost Strike?s194913[, Glacial Advance,][] and Howling Blast always grant Killing Machine and have a s2 chance to generate a Rune.
Define(rapid_decomposition_talent 19218)
# Your Blood Plague and Death and Decay deal damage s2 more often.rnrnAdditionally, your Blood Plague leeches s3 more Health.
Define(relish_in_blood_talent 22134)
# While Crimson Scourge is active, your next Death and Decay heals you for 317614s1 health per Bone Shield charge and you immediately gain 317614s2/10 Runic Power
Define(runic_attenuation_talent 22019)
# Auto attacks have a chance to generate 221322s1/10 Runic Power.
Define(soul_reaper_talent 22526)
# Strike an enemy for s1 Shadow damage and afflict the enemy with Soul Reaper. rnrnAfter 5 seconds, if the target is below s3 health this effect will explode dealing an additional 343295s1 Shadow damage to the target. If the enemy that yields experience or honor dies while afflicted by Soul Reaper, gain Runic Corruption.
Define(summon_gargoyle_talent 22110)
# Summon a Gargoyle into the area to bombard the target for 30 seconds.rnrnThe Gargoyle gains 211947s1 increased damage for every s4 Runic Power you spend.
Define(tombstone_talent 23454)
# Consume up to s5 Bone Shield charges. For each charge consumed, you gain s3 Runic Power and absorb damage equal to s4 of your maximum health for 8 seconds.
Define(unholy_assault_talent 22538)
# Strike your target dealing s2 Shadow damage, infecting the target with s3 Festering Wounds and sending you into an Unholy Frenzy increasing haste by s1 for 12 seconds.
Define(unholy_blight_talent 22029)
# Surrounds yourself with a vile swarm of insects for 6 seconds, stinging all nearby enemies and infecting them with Virulent Plague and an unholy disease that deals 115994o1 damage over 14 seconds, stacking up to 115994u times.rnrnYour minions deal 115994s2 increased damage per stack to enemies infected by Unholy Blight.
Define(fallen_crusader_enchant 3368)
Define(razorice_enchant 3370)
Define(potion_of_phantom_fire_item 171349)
    ItemInfo(potion_of_phantom_fire_item cd=300 shared_cd="item_cd_4" rppm=6 proc=307495)
Define(potion_of_spectral_strength_item 171275)
    ItemInfo(potion_of_spectral_strength_item cd=1 shared_cd="item_cd_4" proc=307164)
Define(inscrutable_quantum_device_item 179350)
    ItemInfo(inscrutable_quantum_device_item cd=180 proc=348098)
Define(biting_cold_runeforge 6945)
Define(phearomones_runeforge 6954)
Define(deadliest_coil_runeforge 6952)
Define(superstrain_runeforge 6953)
Define(eradicating_blow_conduit 83)
Define(everfrost_conduit 91)
Define(unleashed_frenzy_conduit 122)
Define(convocation_of_the_dead_conduit 124)
Define(lead_by_example_soulbind 342156)
    `;
    // END

    code += `
# raise_dead
  SpellInfo(raise_dead totem=1)
# raise_dead_unholy
  SpellRequire(raise_dead_unholy unusable set=1 enabled=(pet.present()))
# sacrificial_pact
  SpellRequire(sacrificial_pact unusable set=1 enabled=((specialization(unholy) and not pet.present()) or (not specialization(unholy) and totemexpires(raise_dead))))
# summon_gargoyle
  SpellInfo(summon_gargoyle totem=1)
`;

    OvaleScripts.RegisterScript(
        "DEATHKNIGHT",
        undefined,
        name,
        desc,
        code,
        "include"
    );
}
