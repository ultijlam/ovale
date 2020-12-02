local __exports = LibStub:NewLibrary("ovale/scripts/ovale_deathknight_spells", 90000)
if not __exports then return end
__exports.registerDeathKnightSpells = function(OvaleScripts)
    local name = "ovale_deathknight_spells"
    local desc = "[9.0] Ovale: Death Knight spells"
    local code = [[Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you a random secondary stat for 15 seconds.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
Define(anima_of_death 294926)
# Draw upon your vitality to sear your foes, dealing s2 of your maximum health in Fire damage to all nearby enemies and heal for 294946s1 of your maximum health per enemy hit, up to ?a294945[294945s1*2][294945s1] of your maximum health.
  SpellInfo(anima_of_death cd=150)
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
  SpellAddBuff(army_of_the_dead army_of_the_dead_unused_0 add=1)
  # Summoning ghouls.
  SpellAddBuff(army_of_the_dead army_of_the_dead add=1)
Define(army_of_the_dead_unused_0 42651)
# Summons a legion of ghouls who swarms your enemies, fighting anything they can for 30 seconds.
  SpellInfo(army_of_the_dead_unused_0 duration=30 gcd=0 offgcd=1)
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
  SpellAddBuff(bone_shield marrowrend add=1)
Define(bonestorm 194844)
# A whirl of bone and gore batters up to 196528s2 nearby enemies, dealing 196528s1 Shadow damage every t3 sec, and healing you for 196545s1 of your maximum health every time it deals damage (up to s1*s4). Lasts t3 sec per s3 Runic Power spent.
  SpellInfo(bonestorm runicpower=10 cd=60 duration=1 tick=1)
  SpellRequire(bonestorm unusable set=1 enabled=(not hastalent(bonestorm_talent)))
  SpellAddBuff(bonestorm bonestorm_unused_0 add=1)
  # Dealing 196528s1 Shadow damage to nearby enemies every t3 sec, and healing for 196545s1 of maximum health for each target hit (up to s1*s4).
  SpellAddBuff(bonestorm bonestorm add=1)
Define(bonestorm_unused_0 196528)
# A whirl of bone and gore batters up to 196528s2 nearby enemies, dealing 196528s1 Shadow damage every t3 sec, and healing you for 196545s1 of your maximum health every time it deals damage (up to s1*s4). Lasts t3 sec per s3 Runic Power spent.
  SpellInfo(bonestorm_unused_0 gcd=0 offgcd=1)
Define(breath_of_sindragosa 152279)
# Continuously deal 155166s2*<CAP>/AP Frost damage every t1 sec to enemies in a cone in front of you, until your Runic Power is exhausted. Deals reduced damage to secondary targets.rnrn|cFFFFFFFFGenerates 303753s1 lRune:Runes; at the start and end.|r
  SpellInfo(breath_of_sindragosa cd=120 gcd=0 offgcd=1 tick=1)
  SpellRequire(breath_of_sindragosa unusable set=1 enabled=(not hastalent(breath_of_sindragosa_talent)))
  SpellAddBuff(breath_of_sindragosa breath_of_sindragosa_unused_0 add=1)
  SpellAddBuff(breath_of_sindragosa breath_of_sindragosa_unused_1 add=1)
  # Continuously dealing Frost damage every t1 sec to enemies in a cone in front of you.
  SpellAddBuff(breath_of_sindragosa breath_of_sindragosa add=1)
Define(breath_of_sindragosa_unused_0 155166)
# Continuously deal 155166s2*<CAP>/AP Frost damage every t1 sec to enemies in a cone in front of you, until your Runic Power is exhausted. Deals reduced damage to secondary targets.rnrn|cFFFFFFFFGenerates 303753s1 lRune:Runes; at the start and end.|r
  SpellInfo(breath_of_sindragosa_unused_0 gcd=0 offgcd=1)
Define(breath_of_sindragosa_unused_1 303753)
# Continuously deal 155166s2*<CAP>/AP Frost damage every t1 sec to enemies in a cone in front of you, until your Runic Power is exhausted. Deals reduced damage to secondary targets.rnrn|cFFFFFFFFGenerates 303753s1 lRune:Runes; at the start and end.|r
  SpellInfo(breath_of_sindragosa_unused_1 gcd=0 offgcd=1 runes=-2)
Define(chains_of_ice 45524)
# Shackles the target with frozen chains, reducing movement speed by s1 for 8 seconds.
  SpellInfo(chains_of_ice runes=1 runicpower=-10 duration=8)
  # Movement slowed s1 by frozen chains.
  SpellAddTargetDebuff(chains_of_ice chains_of_ice add=1)
Define(cold_heart_buff 235599)
# Every t1 sec, gain a stack of Cold Heart, causing your next Chains of Ice to deal 248397s1 Shadowfrost damage. Stacks up to 235599u times.rnrnIf Chains of Ice is used when you have 235599u stacks of Cold Heart, the target will also be stunned in a block of ice for 4 seconds.
  SpellInfo(cold_heart_buff max_stacks=20 gcd=0 offgcd=1)
  # Your next Chains of Ice will deal 248397s1 Shadowfrost damage.
  SpellAddBuff(cold_heart_buff cold_heart_buff add=1)
Define(concentrated_flame 295368)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame duration=6 gcd=0 offgcd=1 tick=2)
  # Suffering w1 damage every t1 sec.
  SpellAddTargetDebuff(concentrated_flame concentrated_flame add=1)
Define(consumption 274156)
# Strikes up to s3 enemies in front of you with a hungering attack that deals sw1 Physical damage and heals you for e1*100 of that damage.
  SpellInfo(consumption cd=30)
  SpellRequire(consumption unusable set=1 enabled=(not hastalent(consumption_talent)))
  SpellAddBuff(consumption consumption_unused_4 add=1)
Define(consumption_unused_4 274893)
  SpellInfo(consumption_unused_4 gcd=0 offgcd=1)
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
Define(death_coil 47541)
# Fires a blast of unholy energy at the target, causing 47632s1 Shadow damage to an enemy or healing an Undead ally for 47633s1 health.?s316941[rnrnReduces the cooldown of Dark Transformation by s2/1000 sec.][]
  SpellInfo(death_coil runicpower=40)
Define(death_strike 278223)
# Death Strike's cost is reduced by s3/-10, and its healing is increased by s1.
  SpellInfo(death_strike gcd=0 offgcd=1)
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
Define(festering_wound_debuff 194310)
# A pustulent lesion that will burst on death or when damaged by Scourge Strike, dealing 194311s1 Shadow damage and generating 195757s1 Runic Power.
  SpellInfo(festering_wound_debuff duration=30 max_stacks=6 gcd=0 offgcd=1)
  # Suffering from a wound that will deal 194311s1/s1 Shadow damage when damaged by Scourge Strike.
  SpellAddTargetDebuff(festering_wound_debuff festering_wound_debuff add=1)
Define(fireblood 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood cd=120 gcd=0 offgcd=1)
Define(frost_fever_debuff 55095)
# A disease that deals o1*<CAP>/AP Frost damage over 24 seconds and has a chance to grant the Death Knight 195617m1/10 Runic Power each time it deals damage.
  SpellInfo(frost_fever_debuff duration=24 gcd=0 offgcd=1 tick=3)
  # Suffering w1 Frost damage every t1 sec.
  SpellAddTargetDebuff(frost_fever_debuff frost_fever_debuff add=1)
Define(frost_strike 49143)
# Chill your ?owb==0[weapon with icy power and quickly strike the enemy, dealing <2hDamage> Frost damage.][weapons with icy power and quickly strike the enemy with both, dealing a total of <dualWieldDamage> Frost damage.]
  SpellInfo(frost_strike runicpower=25)
  SpellAddTargetDebuff(frost_strike frost_strike_unused_0 add=1)
  SpellAddTargetDebuff(frost_strike frost_strike_offhand add=1)
  SpellAddTargetDebuff(frost_strike frost_strike_unused_2 add=1)
Define(frost_strike_offhand 66196)
# Chill your ?owb==0[weapon with icy power and quickly strike the enemy, dealing <2hDamage> Frost damage.][weapons with icy power and quickly strike the enemy with both, dealing a total of <dualWieldDamage> Frost damage.]
  SpellInfo(frost_strike_offhand gcd=0 offgcd=1)
Define(frost_strike_unused_0 222026)
# Chill your ?owb==0[weapon with icy power and quickly strike the enemy, dealing <2hDamage> Frost damage.][weapons with icy power and quickly strike the enemy with both, dealing a total of <dualWieldDamage> Frost damage.]
  SpellInfo(frost_strike_unused_0 gcd=0 offgcd=1)
Define(frost_strike_unused_2 325464)
# Chill your ?owb==0[weapon with icy power and quickly strike the enemy, dealing <2hDamage> Frost damage.][weapons with icy power and quickly strike the enemy with both, dealing a total of <dualWieldDamage> Frost damage.]
  SpellInfo(frost_strike_unused_2 gcd=0 offgcd=1)
Define(frostscythe 207230)
# A sweeping attack that strikes up to s5 enemies in front of you for s2 Frost damage. This attack benefits from Killing Machine. Critical strikes with Frostscythe deal s3 times normal damage.
  SpellInfo(frostscythe runes=1 runicpower=-10)
  SpellRequire(frostscythe unusable set=1 enabled=(not hastalent(frostscythe_talent)))
Define(frostwyrms_fury 279302)
# Summons a frostwyrm who breathes on all enemies within s1 yd in front of you, dealing 279303s1 Frost damage and slowing movement speed by (25 of Spell Power) for 10 seconds.
  SpellInfo(frostwyrms_fury cd=180 duration=10)
Define(frozen_pulse 194909)
# While you have fewer than m2 full LRune:Runes;, your auto attacks radiate intense cold, inflicting 195750s1 Frost damage on all nearby enemies.
  SpellInfo(frozen_pulse gcd=0 offgcd=1)
  SpellRequire(frozen_pulse unusable set=1 enabled=(not hastalent(frozen_pulse_talent)))
  SpellAddBuff(frozen_pulse frozen_pulse_unused_0 add=1)
Define(frozen_pulse_unused_0 195750)
# While you have fewer than m2 full LRune:Runes;, your auto attacks radiate intense cold, inflicting 195750s1 Frost damage on all nearby enemies.
  SpellInfo(frozen_pulse_unused_0 gcd=0 offgcd=1)
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
Define(killing_machine_frost 317214)
# Your next Obliterate also deals Frost damage.
  SpellInfo(killing_machine_frost gcd=0 offgcd=1)
Define(lights_judgment 255647)
# Call down a strike of Holy energy, dealing <damage> Holy damage to enemies within A1 yards after 3 sec.
  SpellInfo(lights_judgment cd=150)
  SpellAddTargetDebuff(lights_judgment lights_judgment_unused_0 add=1)
Define(lights_judgment_unused_0 256893)
# Call down a strike of Holy energy, dealing <damage> Holy damage to enemies within A1 yards.
  SpellInfo(lights_judgment_unused_0 cd=150)
Define(marrowrend 195182)
# Smash the target, dealing s2 Physical damage and generating s3 charges of Bone Shield.rnrn|Tinterfaceiconsability_deathknight_boneshield.blp:24|t |cFFFFFFFFBone Shield|rrnSurrounds you with a barrier of whirling bones, increasing Armor by s1*STR/100?s316746[, and your Haste by s4][]. Each melee attack against you consumes a charge. Lasts 30 seconds or until all charges are consumed.
  SpellInfo(marrowrend runes=2 runicpower=-20)
Define(memory_of_lucid_dreams 299300)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams)
Define(mind_freeze 47528)
# Smash the target's mind with cold, interrupting spellcasting and preventing any spell in that school from being cast for 3 seconds.
  SpellInfo(mind_freeze cd=15 duration=3 gcd=0 offgcd=1 interrupt=1)
Define(obliterate 49020)
# A brutal attack ?owb==0[that deals <2hDamage> Physical damage.][with both weapons that deals a total of <dualWieldDamage> Physical damage.]
  SpellInfo(obliterate runes=2 runicpower=-20)
  SpellAddTargetDebuff(obliterate obliterate_unused_0 add=1)
  SpellAddTargetDebuff(obliterate obliterate_offhand add=1)
  SpellAddTargetDebuff(obliterate obliterate_unused_2 add=1)
Define(obliterate_offhand 66198)
# A brutal attack ?owb==0[that deals <2hDamage> Physical damage.][with both weapons that deals a total of <dualWieldDamage> Physical damage.]
  SpellInfo(obliterate_offhand gcd=0 offgcd=1)
Define(obliterate_unused_0 222024)
# A brutal attack ?owb==0[that deals <2hDamage> Physical damage.][with both weapons that deals a total of <dualWieldDamage> Physical damage.]rn
  SpellInfo(obliterate_unused_0 gcd=0 offgcd=1)
Define(obliterate_unused_2 325461)
# A brutal attack ?owb==0[that deals <2hDamage> Physical damage.][with both weapons that deals a total of <dualWieldDamage> Physical damage.]rn
  SpellInfo(obliterate_unused_2 gcd=0 offgcd=1)
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
Define(raise_dead 46584)
# Raises ?s207313[an abomination]?s58640[a geist][a ghoul] to fight by your side. You can have a maximum of one ?s207313[abomination]?s58640[geist][ghoul] at a time.
  SpellInfo(raise_dead cd=30)
  # A Risen Ally is in your service.
  SpellAddBuff(raise_dead raise_dead add=1)
Define(razor_coral_debuff 303568)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_debuff duration=120 max_stacks=100 gcd=0 offgcd=1)
  # Withdrawing the Razor Coral will grant w1 Critical Strike.
  SpellAddTargetDebuff(razor_coral_debuff razor_coral_debuff add=1)
Define(razorice 51714)
# Engrave your weapon with a rune that causes 50401s1 extra weapon damage as Frost damage and increases enemies' vulnerability to your Frost attacks by 51714s1, stacking up to 51714u times. ?a332944[][rnrnModifying your rune requires a Runeforge in Ebon Hold.]
  SpellInfo(razorice duration=20 max_stacks=5 gcd=0 offgcd=1 tick=1)
  # Frost damage taken from the Death Knight's abilities increased by s1.
  SpellAddTargetDebuff(razorice razorice add=1)
Define(remorseless_winter 196770)
# Drain the warmth of life from all nearby enemies within 196771A1 yards, dealing 9*196771s1*<CAP>/AP Frost damage over 8 seconds and reducing their movement speed by 211793s1.
  SpellInfo(remorseless_winter runes=1 runicpower=-10 cd=20 duration=8 tick=1)
  SpellAddBuff(remorseless_winter remorseless_winter_unused_0 add=1)
  # Dealing 196771s1 Frost damage to enemies within 196771A1 yards each second.
  SpellAddBuff(remorseless_winter remorseless_winter add=1)
Define(remorseless_winter_unused_0 196771)
# Drain the warmth of life from all nearby enemies within 196771A1 yards, dealing 9*196771s1*<CAP>/AP Frost damage over 8 seconds and reducing their movement speed by 211793s1.
  SpellInfo(remorseless_winter_unused_0 gcd=0 offgcd=1)
Define(rime_frost 316838)
# Increases Howling Blasts damage done by an additional s1.
  SpellInfo(rime_frost gcd=0 offgcd=1)
Define(ripple_in_space 299306)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space)
Define(scourge_strike 55090)
# An unholy strike that deals s2 Physical damage and 70890sw2 Shadow damage, and causes 1 Festering Wound to burst.
  SpellInfo(scourge_strike runes=1 runicpower=-10)
  SpellAddTargetDebuff(scourge_strike scourge_strike_unused_0 add=1)
Define(scourge_strike_unused_0 70890)
# An unholy strike that deals s2 Physical damage and 70890sw2 Shadow damage, and causes 1 Festering Wound to burst.
  SpellInfo(scourge_strike_unused_0 gcd=0 offgcd=1)
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
Define(vampiric_blood 55233)
# Embrace your undeath, increasing your maximum health by s4 and increasing all healing and absorbs received by s1 for 10 seconds.
  SpellInfo(vampiric_blood cd=90 duration=10 gcd=0 offgcd=1)
  # Maximum health increased by s4. Healing and absorbs received increased by s1.
  SpellAddBuff(vampiric_blood vampiric_blood add=1)
Define(virulent_plague 191587)
# A disease that deals o Shadow damage over 27 seconds. It erupts when the infected target dies, dealing 191685s1 Shadow damage to nearby enemies.
  SpellInfo(virulent_plague duration=27 gcd=0 offgcd=1 tick=3)
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp add=1)
Define(worldvein_resonance 298606)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance)
Define(army_of_the_damned_talent 22030)
# ?s207317[Death Coil and Epidemic reduce][Death Coil reduces] the cooldown of Apocalypse by <cd1> sec and Army of the Dead by <cd2> sec. rnrnAdditionally Apocalypse and Army of the Dead summon a Magus of the Dead for 15 seconds who hurls Frostbolts and Shadow Bolts at your foes.rn
Define(blinding_sleet_talent 22519)
# Targets in a cone in front of you are blinded, causing them to wander disoriented for 5 seconds. Damage may cancel the effect.rnrnWhen Blinding Sleet ends, enemies are slowed by 317898s1 for 6 seconds.
Define(blooddrinker_talent 19166)
# Drains o1 health from the target over 3 seconds.rnrnYou can move, parry, dodge, and use defensive abilities while channeling this ability.
Define(blooddrinker_talent 19166)
# Drains o1 health from the target over 3 seconds.rnrnYou can move, parry, dodge, and use defensive abilities while channeling this ability.
Define(bonestorm_talent 21209)
# A whirl of bone and gore batters up to 196528s2 nearby enemies, dealing 196528s1 Shadow damage every t3 sec, and healing you for 196545s1 of your maximum health every time it deals damage (up to s1*s4). Lasts t3 sec per s3 Runic Power spent.
Define(breath_of_sindragosa_talent 22537)
# Continuously deal 155166s2*<CAP>/AP Frost damage every t1 sec to enemies in a cone in front of you, until your Runic Power is exhausted. Deals reduced damage to secondary targets.rnrn|cFFFFFFFFGenerates 303753s1 lRune:Runes; at the start and end.|r
Define(breath_of_sindragosa_talent 22537)
# Continuously deal 155166s2*<CAP>/AP Frost damage every t1 sec to enemies in a cone in front of you, until your Runic Power is exhausted. Deals reduced damage to secondary targets.rnrn|cFFFFFFFFGenerates 303753s1 lRune:Runes; at the start and end.|r
Define(cold_heart_talent 22018)
# Every t1 sec, gain a stack of Cold Heart, causing your next Chains of Ice to deal 281210s1 Frost damage. Stacks up to 281209u times.
Define(consumption_talent 19220)
# Strikes up to s3 enemies in front of you with a hungering attack that deals sw1 Physical damage and heals you for e1*100 of that damage.
Define(defile_talent 22536)
# Defile the targeted ground, dealing (156000s1*(10 seconds+1)/t3) Shadow damage to all enemies over 10 seconds.rnrnWhile you remain within your Defile, your ?s207311[Clawing Shadows][Scourge Strike] will hit 55090s4-1 enemies near the target?a315442|a331119[ and inflict Death's Due for 12 seconds.rnrnDeath's Due reduces damage enemies deal to you by 324164s1, up to a maximum of 324164s1*-324164u and their power is transferred to you as an equal amount of Strength.][.]rnrnIf any enemies are standing in the Defile, it grows in size and deals increasing damage every sec.
Define(defile_talent 22536)
# Defile the targeted ground, dealing (156000s1*(10 seconds+1)/t3) Shadow damage to all enemies over 10 seconds.rnrnWhile you remain within your Defile, your ?s207311[Clawing Shadows][Scourge Strike] will hit 55090s4-1 enemies near the target?a315442|a331119[ and inflict Death's Due for 12 seconds.rnrnDeath's Due reduces damage enemies deal to you by 324164s1, up to a maximum of 324164s1*-324164u and their power is transferred to you as an equal amount of Strength.][.]rnrnIf any enemies are standing in the Defile, it grows in size and deals increasing damage every sec.
Define(frostscythe_talent 22525)
# A sweeping attack that strikes up to s5 enemies in front of you for s2 Frost damage. This attack benefits from Killing Machine. Critical strikes with Frostscythe deal s3 times normal damage.
Define(frostscythe_talent 22525)
# A sweeping attack that strikes up to s5 enemies in front of you for s2 Frost damage. This attack benefits from Killing Machine. Critical strikes with Frostscythe deal s3 times normal damage.
Define(frozen_pulse_talent 22523)
# While you have fewer than m2 full LRune:Runes;, your auto attacks radiate intense cold, inflicting 195750s1 Frost damage on all nearby enemies.
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
Define(runic_attenuation_talent 22019)
# Auto attacks have a chance to generate 221322s1/10 Runic Power.
Define(soul_reaper_talent 22526)
# Strike an enemy for s1 Shadow damage and afflict the enemy with Soul Reaper. rnrnAfter 5 seconds, if the target is below s3 health this effect will explode dealing an additional 343295s1 Shadow damage to the target. If the enemy that yields experience or honor dies while afflicted by Soul Reaper, gain Runic Corruption.
Define(summon_gargoyle_talent 22110)
# Summon a Gargoyle into the area to bombard the target for 30 seconds.rnrnThe Gargoyle gains 211947s1 increased damage for every s4 Runic Power you spend.
Define(summon_gargoyle_talent 22110)
# Summon a Gargoyle into the area to bombard the target for 30 seconds.rnrnThe Gargoyle gains 211947s1 increased damage for every s4 Runic Power you spend.
Define(tombstone_talent 23454)
# Consume up to s5 Bone Shield charges. For each charge consumed, you gain s3 Runic Power and absorb damage equal to s4 of your maximum health for 8 seconds.
Define(unholy_assault_talent 22538)
# Strike your target dealing s2 Shadow damage, infecting the target with s3 Festering Wounds and sending you into an Unholy Frenzy increasing haste by s1 for 12 seconds.
Define(unholy_blight_talent 22029)
# Surrounds yourself with a vile swarm of insects for 6 seconds, stinging all nearby enemies and infecting them with Virulent Plague and an unholy disease that deals 115994o1 damage over 14 seconds, stacking up to 115994u times.rnrnYour minions deal 115994s2 increased damage per stack to enemies infected by Unholy Blight.
Define(unholy_blight_talent 22029)
# Surrounds yourself with a vile swarm of insects for 6 seconds, stinging all nearby enemies and infecting them with Virulent Plague and an unholy disease that deals 115994o1 damage over 14 seconds, stacking up to 115994u times.rnrnYour minions deal 115994s2 increased damage per stack to enemies infected by Unholy Blight.
Define(unholy_pact_talent 22534)
# Dark Transformation creates an unholy pact between you and your pet, igniting flaming chains that deal 319236s1*s2 Shadow damage over s2 sec to enemies between you and your pet. rnrnWhile active, your strength is increased by 319255s1.
Define(fallen_crusader_enchant 3368)
Define(razorice_enchant 3370)
Define(dribbling_inkpod_item 169319)
Define(potion_of_unbridled_fury_item 169299)
Define(biting_cold_runeforge 6945)
Define(deadliest_coil_runeforge 6952)
Define(eradicating_blow_conduit 83)
Define(everfrost_conduit 91)
Define(unleashed_frenzy_conduit 122)
Define(convocation_of_the_dead_conduit 124)
    ]]
    OvaleScripts:RegisterScript("DEATHKNIGHT", nil, name, desc, code, "include")
end
