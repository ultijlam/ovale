local __exports = LibStub:NewLibrary("ovale/scripts/ovale_shaman_spells", 80300)
if not __exports then return end
__exports.registerShamanSpells = function(OvaleScripts)
    local name = "ovale_shaman_spells"
    local desc = "[9.0] Ovale: Shaman spells"
    local code = [[Define(ancestral_call 274738)
# Invoke the spirits of your ancestors, granting you a random secondary stat for 15 seconds.
  SpellInfo(ancestral_call cd=120 duration=15 gcd=0 offgcd=1)
  SpellAddBuff(ancestral_call ancestral_call=1)
Define(ascendance 114050)
# Transform into a Flame Ascendant for 15 seconds, replacing Chain Lightning with Lava Beam, removing the cooldown on Lava Burst, and increasing the damage of Lava Burst by an amount equal to your critical strike chance.
  SpellInfo(ascendance cd=180 duration=15 talent=ascendance_talent)
  # Transformed into a powerful Fire ascendant. Chain Lightning is transformed into Lava Beam.
  SpellAddBuff(ascendance ascendance=1)
Define(ascendance_enhancement 114051)
# Transform into an Air Ascendant for 15 seconds, reducing the cooldown and cost of Stormstrike by s4, and transforming your auto attack and Stormstrike into Wind attacks which bypass armor and have a s1 yd range.
  SpellInfo(ascendance_enhancement cd=180 duration=15 talent=ascendance_talent_enhancement)
  # Transformed into a powerful Air ascendant. Auto attacks have a 114089r yard range. Stormstrike is empowered and has a 114089r yard range.
  SpellAddBuff(ascendance_enhancement ascendance_enhancement=1)
Define(bag_of_tricks 312411)
# Pull your chosen trick from the bag and use it on target enemy or ally. Enemies take <damage> damage, while allies are healed for <healing>. 
  SpellInfo(bag_of_tricks cd=90)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
Define(blood_fury_0 20572)
# Increases your attack power by s1 for 15 seconds.
  SpellInfo(blood_fury_0 cd=120 duration=15 gcd=0 offgcd=1)
  # Attack power increased by w1.
  SpellAddBuff(blood_fury_0 blood_fury_0=1)
Define(blood_fury_1 24571)
# Instantly increases your rage by 300/10.
  SpellInfo(blood_fury_1 gcd=0 offgcd=1 rage=-30)
Define(blood_fury_2 33697)
# Increases your attack power and Intellect by s1 for 15 seconds.
  SpellInfo(blood_fury_2 cd=120 duration=15 gcd=0 offgcd=1)
  # Attack power and Intellect increased by w1.
  SpellAddBuff(blood_fury_2 blood_fury_2=1)
Define(blood_fury_3 33702)
# Increases your Intellect by s1 for 15 seconds.
  SpellInfo(blood_fury_3 cd=120 duration=15 gcd=0 offgcd=1)
  # Intellect increased by w1.
  SpellAddBuff(blood_fury_3 blood_fury_3=1)
Define(blood_of_the_enemy_0 297969)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy_0)
Define(blood_of_the_enemy_1 297970)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy_1)
Define(blood_of_the_enemy_2 297971)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy_2)
Define(blood_of_the_enemy_3 299039)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy_3)
Define(bloodlust 2825)
# Increases haste by (25 of Spell Power) for all party and raid members for 40 seconds.rnrnAllies receiving this effect will become Sated and unable to benefit from Bloodlust or Time Warp again for 600 seconds.
  SpellInfo(bloodlust cd=300 duration=40 channel=40 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(bloodlust bloodlust=1)
Define(capacitor_totem 192058)
# Summons a totem at the target location that gathers electrical energy from the surrounding air and explodes after s2 sec, stunning all enemies within 118905A1 yards for 3 seconds.
  SpellInfo(capacitor_totem cd=60 duration=3 gcd=1)
Define(chain_lightning_0 231722)
# Chain Lightning jumps to s1 additional targets.
  SpellInfo(chain_lightning_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(chain_lightning_0 chain_lightning_0=1)
Define(chain_lightning_1 334308)
# Each target hit by Chain Lightning reduces the cooldown of Crash Lightning by m1/1000.1 sec.
  SpellInfo(chain_lightning_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(chain_lightning_1 chain_lightning_1=1)
Define(concentrated_flame_0 295368)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_0 duration=6 channel=6 gcd=0 offgcd=1 tick=2)
  # Suffering w1 damage every t1 sec.
  SpellAddTargetDebuff(concentrated_flame_0 concentrated_flame_0=1)
Define(concentrated_flame_1 295373)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_1 cd=30 channel=0)
  SpellAddTargetDebuff(concentrated_flame_1 concentrated_flame_3=1)
Define(concentrated_flame_2 295374)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_2 channel=0 gcd=0 offgcd=1)
Define(concentrated_flame_3 295376)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_3 channel=0 gcd=0 offgcd=1)
Define(concentrated_flame_4 295380)
# Concentrated Flame gains an enhanced appearance.
  SpellInfo(concentrated_flame_4 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(concentrated_flame_4 concentrated_flame_4=1)
Define(concentrated_flame_5 299349)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg), then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds.rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame_5 cd=30 channel=0 gcd=1)
  SpellAddTargetDebuff(concentrated_flame_5 concentrated_flame_3=1)
Define(concentrated_flame_6 299353)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg), then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds.rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.rn|cFFFFFFFFMax s1 Charges.|r
  SpellInfo(concentrated_flame_6 cd=30 channel=0 gcd=1)
  SpellAddTargetDebuff(concentrated_flame_6 concentrated_flame_3=1)
Define(conductive_ink_debuff 302597)
# Your damaging abilities against enemies above M3 health have a very high chance to apply Conductive Ink. When an enemy falls below M3 health, Conductive Ink inflicts s1*(1+@versadmg) Nature damage per stack.
  SpellInfo(conductive_ink_debuff channel=0 gcd=0 offgcd=1)

Define(crackling_surge 224127)
# Reduces the cooldown of Feral Spirit by m1/-1000 sec and causes your Feral Spirits to be imbued with Fire, Frost, or Lightning, enhancing your abilities.
  SpellInfo(crackling_surge duration=15 gcd=0 offgcd=1)
  # The damage of Stormstrike and Windfury is increased by s1.
  SpellAddBuff(crackling_surge crackling_surge=1)
Define(crash_lightning 187874)
# Electrocutes all enemies in front of you, dealing s1*<CAP>/AP Nature damage. Hitting 2 or more targets enhances your weapons for 10 seconds, causing Stormstrike and Lava Lash to also deal 195592s1*<CAP>/AP Nature damage to all targets in front of you.  rnrnEach target hit by Crash Lightning increases the damage of your next Stormstrike by s2.
  SpellInfo(crash_lightning cd=9)
  # Stormstrike and Lava Lash deal an additional 195592s1 damage to all targets in front of you.
  SpellAddBuff(crash_lightning crash_lightning=1)
Define(earth_elemental_0 188616)
# Calls forth a Greater Earth Elemental to protect you and your allies for 60 seconds.
  SpellInfo(earth_elemental_0 duration=60 gcd=0 offgcd=1)
Define(earth_elemental_1 198103)
# Calls forth a Greater Earth Elemental to protect you and your allies for 60 seconds.
  SpellInfo(earth_elemental_1 cd=300)
Define(earth_shock 8042)
# Instantly shocks the target with concussive force, causing (210 of Spell Power) Nature damage.?a190493[rnrnEarth Shock will consume all stacks of Fulmination to deal extra Nature damage to your target.][]
  SpellInfo(earth_shock maelstrom=60)
Define(earthen_spike 188089)
# Summons an Earthen Spike under an enemy, dealing s1 Physical damage and increasing Physical and Nature damage you deal to the target by s2 for 10 seconds.
  SpellInfo(earthen_spike cd=20 duration=10 talent=earthen_spike_talent)
  # Suffering s2 increased Nature and Physical damage from the Shaman.
  SpellAddTargetDebuff(earthen_spike earthen_spike=1)
Define(earthquake 61882)
# Causes the earth within a1 yards of the target location to tremble and break, dealing <damage> Physical damage over 6 seconds and sometimes knocking down enemies.
  SpellInfo(earthquake maelstrom=60 duration=6 tick=1)
  SpellAddBuff(earthquake earthquake=1)
Define(elemental_blast 117014)
# Harnesses the raw power of the elements, dealing (140 of Spell Power) Elemental damage and increasing your Critical Strike or Haste by 118522s1 or Mastery by 173184s1*168534bc1 for 10 seconds.?a190493[rnrnElemental Blast will consume all stacks of Fulmination to deal extra Nature damage to your target.][]
  SpellInfo(elemental_blast maelstrom=30 cd=12 talent=elemental_blast_talent_elemental)
Define(feral_lunge 196884)
# Lunge at your enemy as a ghostly wolf, biting them to deal 215802s1 Physical damage.
  SpellInfo(feral_lunge cd=30 gcd=0.5 talent=feral_lunge_talent)

Define(feral_spirit 51533)
# Summons two Spirit ?s147783[Raptors][Wolves] that aid you in battle for 15 seconds. They are immune to movement-impairing effects.rnrnFeral Spirit generates one stack of Maelstrom Weapon immediately, and one stack every 333957t1 sec for 15 seconds.
  SpellInfo(feral_spirit cd=120)
Define(fire_elemental 198067)
# Calls forth a Greater Fire Elemental to rain destruction on your enemies for 30 seconds. rnrnWhile the Fire Elemental is active, Flame Shock deals damage 188592s2 faster?a343226[, and newly applied Flame Shocks last 343226s1 longer][].
  SpellInfo(fire_elemental cd=150)
Define(fireblood_0 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood_0 cd=120 gcd=0 offgcd=1)
Define(fireblood_1 265226)
# Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by s1.
  SpellInfo(fireblood_1 duration=8 max_stacks=6 gcd=0 offgcd=1)
  # Increases ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by w1.
  SpellAddBuff(fireblood_1 fireblood_1=1)
Define(flame_shock 188389)
# Sears the target with fire, causing (19.5 of Spell Power) Fire damage and then an additional o2 Fire damage over 18 seconds.
  SpellInfo(flame_shock cd=6 duration=18 tick=3)
  # Suffering w2 Fire damage every t2 sec.
  SpellAddTargetDebuff(flame_shock flame_shock=1)
Define(flametongue 193796)
# Scorches your target, dealing s2 Fire damage, and enhances your weapons with fire for 16 seconds, causing each weapon attack to deal up to <coeff>*AP Fire damage.
  SpellInfo(flametongue cd=12)
  # Each of your weapon attacks causes up to <coeff>*AP additional Fire damage.
  SpellAddBuff(flametongue flametongue_buff=1)
Define(flametongue_buff 194084)
# Scorches your target, dealing s2 Fire damage, and enhances your weapons with fire for 16 seconds, causing each weapon attack to deal up to <coeff>*AP Fire damage.
  SpellInfo(flametongue_buff duration=16 gcd=0 offgcd=1 tick=8)
  # Each of your weapon attacks causes up to <coeff>*AP additional Fire damage.
  SpellAddBuff(flametongue_buff flametongue_buff=1)
Define(focused_azerite_beam_0 295258)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds.?a295263[ Castable while moving.][]
  SpellInfo(focused_azerite_beam_0 cd=90 duration=3 channel=3 tick=0.33)
  SpellAddBuff(focused_azerite_beam_0 focused_azerite_beam_0=1)
  SpellAddBuff(focused_azerite_beam_0 focused_azerite_beam_1=1)
Define(focused_azerite_beam_1 295261)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds.?a295263[ Castable while moving.][]
  SpellInfo(focused_azerite_beam_1 cd=90)
Define(focused_azerite_beam_2 299336)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds.
  SpellInfo(focused_azerite_beam_2 cd=90 duration=3 channel=3 tick=0.33)
  SpellAddBuff(focused_azerite_beam_2 focused_azerite_beam_0=1)
  SpellAddBuff(focused_azerite_beam_2 focused_azerite_beam_1=1)
Define(focused_azerite_beam_3 299338)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds. Castable while moving.
  SpellInfo(focused_azerite_beam_3 cd=90 duration=3 channel=3 tick=0.33)
  SpellAddBuff(focused_azerite_beam_3 focused_azerite_beam_0=1)
  SpellAddBuff(focused_azerite_beam_3 focused_azerite_beam_1=1)
Define(frost_shock 196840)
# Chills the target with frost, causing (45 of Spell Power) Frost damage and reducing the target's movement speed by s2 for 6 seconds.?s33757[rnrnFrost Shock shares a cooldown with Flame Shock.][]
  SpellInfo(frost_shock duration=6)
  # Movement speed reduced by s2.
  SpellAddTargetDebuff(frost_shock frost_shock=1)
Define(gathering_storms 198300)
# Each target hit by Crash Lightning increases damage dealt by your next Stormstrike within 12 seconds by s1.
  SpellInfo(gathering_storms duration=12 gcd=0 offgcd=1)
  # Damage of Stormstrike increased by w1.
  SpellAddBuff(gathering_storms gathering_storms=1)
Define(guardian_of_azeroth_0 295840)
# Call upon Azeroth to summon a Guardian of Azeroth for 30 seconds who impales your target with spikes of Azerite every s1/10.1 sec that deal 295834m1*(1+@versadmg) Fire damage.?a295841[ Every 303347t1 sec, the Guardian launches a volley of Azerite Spikes at its target, dealing 295841s1 Fire damage to all nearby enemies.][]?a295843[rnrnEach time the Guardian of Azeroth casts a spell, you gain 295855s1 Haste, stacking up to 295855u times. This effect ends when the Guardian of Azeroth despawns.][]rn
  SpellInfo(guardian_of_azeroth_0 cd=180 duration=30)
  SpellAddBuff(guardian_of_azeroth_0 guardian_of_azeroth_0=1)
Define(guardian_of_azeroth_1 295855)
# Each time the Guardian of Azeroth casts a spell, you gain 295855s1 Haste, stacking up to 295855u times. This effect ends when the Guardian of Azeroth despawns.
  SpellInfo(guardian_of_azeroth_1 duration=60 max_stacks=5 gcd=0 offgcd=1)
  # Haste increased by s1.
  SpellAddBuff(guardian_of_azeroth_1 guardian_of_azeroth_1=1)
Define(guardian_of_azeroth_2 299355)
# Call upon Azeroth to summon a Guardian of Azeroth for 30 seconds who impales your target with spikes of Azerite every 295840s1/10.1 sec that deal 295834m1*(1+@versadmg)*(1+(295836m1/100)) Fire damage. Every 303347t1 sec, the Guardian launches a volley of Azerite Spikes at its target, dealing 295841s1 Fire damage to all nearby enemies.
  SpellInfo(guardian_of_azeroth_2 cd=180 duration=30 gcd=1)
  SpellAddBuff(guardian_of_azeroth_2 guardian_of_azeroth_2=1)
Define(guardian_of_azeroth_3 299358)
# Call upon Azeroth to summon a Guardian of Azeroth for 30 seconds who impales your target with spikes of Azerite every 295840s1/10.1 sec that deal 295834m1*(1+@versadmg)*(1+(295836m1/100)) Fire damage. Every 303347t1 sec, the Guardian launches a volley of Azerite Spikes at its target, dealing 295841s1 Fire damage to all nearby enemies.rnrnEach time the Guardian of Azeroth casts a spell, you gain 295855s1 Haste, stacking up to 295855u times. This effect ends when the Guardian of Azeroth despawns.
  SpellInfo(guardian_of_azeroth_3 cd=180 duration=20 gcd=1)
  SpellAddBuff(guardian_of_azeroth_3 guardian_of_azeroth_3=1)
Define(guardian_of_azeroth_4 300091)
# Call upon Azeroth to summon a Guardian of Azeroth to aid you in combat for 30 seconds.
  SpellInfo(guardian_of_azeroth_4 cd=300 duration=30 gcd=1)
Define(guardian_of_azeroth_5 303347)
  SpellInfo(guardian_of_azeroth_5 gcd=0 offgcd=1 tick=8)

Define(heroism 32182)
# Increases haste by (25 of Spell Power) for all party and raid members for 40 seconds.rnrnAllies receiving this effect will become Exhausted and unable to benefit from Heroism or Time Warp again for 600 seconds.
  SpellInfo(heroism cd=300 duration=40 channel=40 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(heroism heroism=1)
Define(hot_hand_buff 215785)
# Melee auto-attacks with Flametongue Weapon active have a h chance to reduce the cooldown of Lava Lash by 215785m2/4 and increase the damage of Lava Lash by 215785m1 for 8 seconds.
  SpellInfo(hot_hand_buff duration=8 gcd=0 offgcd=1)
  # Lava Lash damage increased by s1 and cooldown reduced by s2/4.
  SpellAddBuff(hot_hand_buff hot_hand_buff=1)
Define(icefury 210714)
# Hurls frigid ice at the target, dealing (82.5 of Spell Power) Frost damage and causing your next n Frost Shocks to deal s2 increased damage.rnrn|cFFFFFFFFGenerates 343725s8 Maelstrom.|r
  SpellInfo(icefury cd=30 duration=15 maelstrom=0 talent=icefury_talent)
  # Frost Shock damage increased by s2.
  SpellAddBuff(icefury icefury=1)
Define(icy_edge_0 224126)
# Reduces the cooldown of Feral Spirit by m1/-1000 sec and causes your Feral Spirits to be imbued with Fire, Frost, or Lightning, enhancing your abilities.
  SpellInfo(icy_edge_0 duration=15 gcd=0 offgcd=1)
  # All melee attacks now also strike the target with an Icy Edge, causing bonus Frost damage and snaring them by 271920s2 for 271920d.
  SpellAddBuff(icy_edge_0 icy_edge_0=1)
Define(icy_edge_1 271920)
# Reduces the cooldown of Feral Spirit by m1/-1000 sec and causes your Feral Spirits to be imbued with Fire, Frost, or Lightning, enhancing your abilities.
  SpellInfo(icy_edge_1 duration=3 gcd=0 offgcd=1)
  # Movement speed reduced by s2.
  SpellAddTargetDebuff(icy_edge_1 icy_edge_1=1)
Define(landslide_buff 214397)
# Your melee attacks have a chance to trigger a Landslide, dealing 214397s1 Physical damage to all enemies directly in front of you. 
  SpellInfo(landslide_buff channel=0 gcd=0 offgcd=1)
Define(lava_beam 114074)
# Unleashes a blast of superheated flame at the enemy, dealing (47 of Spell Power) Fire damage and then jumping to additional nearby enemies. Damage is increased by s2 after each jump. Affects x1 total targets.  rnrn|cFFFFFFFFGenerates 343725s6 Maelstrom per target hit.|r 
  SpellInfo(lava_beam)
Define(lava_burst 51505)
# Hurls molten lava at the target, dealing (108 of Spell Power) Fire damage.?a231721[ Lava Burst will always critically strike if the target is affected by Flame Shock.][]?a343725[rnrn|cFFFFFFFFGenerates 343725s3 Maelstrom.|r][]
# Rank 2: Lava Burst will always critically strike if the target is affected by Flame Shock.
  SpellInfo(lava_burst cd=8 maelstrom=0)

Define(lava_lash 60103)
# Charges your off-hand weapon with lava and burns your target, dealing s1 Fire damage.rnrnDamage is increased by s2 if your offhand weapon is imbued with Flametongue Weapon.
# Rank 2: Lava Lash cooldown reduced by m1/-1000.1 sec.
  SpellInfo(lava_lash cd=18)
Define(lava_shock_buff 273449)
# Flame Shock damage increases the damage of your next Earth Shock by s1, stacking up to 273453u times.
  SpellInfo(lava_shock_buff channel=-0.001 gcd=0 offgcd=1)

Define(lava_surge 77756)
# Your Flame Shock damage over time has a <chance> chance to reset the remaining cooldown on Lava Burst and cause your next Lava Burst to be instant.
  SpellInfo(lava_surge channel=0 gcd=0 offgcd=1)
  SpellAddBuff(lava_surge lava_surge=1)
Define(lightning_bolt_0 188196)
# Hurls a bolt of lightning at the target, dealing (95 of Spell Power) Nature damage.?a343725[rnrn|cFFFFFFFFGenerates 343725s1 Maelstrom.|r][]
# Rank 2: Reduces the cast time of Lightning Bolt by m1/-1000.1 sec.
  SpellInfo(lightning_bolt_0)
Define(lightning_bolt_1 214815)
# Hurls a bolt of lightning at the target, dealing (95 of Spell Power) Nature damage.?a343725[rnrn|cFFFFFFFFGenerates 343725s1 Maelstrom.|r][]
  SpellInfo(lightning_bolt_1 gcd=0 offgcd=1 maelstrom=-6)
Define(lightning_conduit_debuff 275388)
# Stormstrike marks the target as a Lightning Conduit for 60 seconds. Stormstrike deals s1 Nature damage to all enemies you've marked as Conduits.
  SpellInfo(lightning_conduit_debuff channel=0 gcd=0 offgcd=1)

Define(lightning_lasso_0 305483)
# Grips the target in lightning, stunning and dealing 305485o1 Nature damage over 5 seconds while the target is lassoed. Can move while channeling.
  SpellInfo(lightning_lasso_0 cd=30)
Define(lightning_lasso_1 305485)
# Grips the target in lightning, stunning and dealing 305485o1 Nature damage over 5 seconds while the target is lassoed. Can move while channeling.
  SpellInfo(lightning_lasso_1 duration=5 channel=5 gcd=0 offgcd=1 tick=1)
  # Stunned. Suffering w1 Nature damage every t1 sec.
  SpellAddTargetDebuff(lightning_lasso_1 lightning_lasso_1=1)
Define(lightning_shield 192106)
# Surround yourself with a shield of lightning for 1800 seconds.rnrnMelee attackers have a h chance to suffer 192109s1 Nature damage?a137041[ and have a s3 chance to generate a stack of Maelstrom Weapon]?a137040[ and have a s4 chance to generate s5 Maelstrom][].rnrnOnly one Elemental Shield can be active on the Shaman at a time.
  SpellInfo(lightning_shield duration=1800 channel=1800)
  # Chance to deal 192109s1 Nature damage when you take melee damage.
  SpellAddBuff(lightning_shield lightning_shield=1)
Define(liquid_magma_totem 192222)
# Summons a totem at the target location for 15 seconds that hurls liquid magma at a random nearby target every 192226t1 sec, dealing (15 of Spell Power)*(1+(137040s3/100)) Fire damage to all enemies within 192223A1 yards.
  SpellInfo(liquid_magma_totem cd=60 duration=15 gcd=1 talent=liquid_magma_totem_talent)
Define(master_of_the_elements_buff 260734)
# Casting Lava Burst increases the damage of your next Nature, Physical, or Frost spell by 260734s1.
  SpellInfo(master_of_the_elements_buff duration=15 channel=15 gcd=0 offgcd=1)
  # Your next Nature, Physical, or Frost spell will deal s1 increased damage.
  SpellAddBuff(master_of_the_elements_buff master_of_the_elements_buff=1)
Define(memory_of_lucid_dreams_0 299300)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_0)
Define(memory_of_lucid_dreams_1 299302)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_1)
Define(memory_of_lucid_dreams_2 299304)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams_2)
Define(molten_weapon_0 224125)
# Reduces the cooldown of Feral Spirit by m1/-1000 sec and causes your Feral Spirits to be imbued with Fire, Frost, or Lightning, enhancing your abilities.
  SpellInfo(molten_weapon_0 duration=15 gcd=0 offgcd=1)
  # Increases fire damage dealt from your abilities by s1, and Lava Lash now causes the target to burn for an additional s2 of the direct damage done over 271924d.
  SpellAddBuff(molten_weapon_0 molten_weapon_0=1)
Define(molten_weapon_1 271924)
# Reduces the cooldown of Feral Spirit by m1/-1000 sec and causes your Feral Spirits to be imbued with Fire, Frost, or Lightning, enhancing your abilities.
  SpellInfo(molten_weapon_1 duration=4 gcd=0 offgcd=1 tick=2)
  # Suffering w1 Fire damage every t1 sec.
  SpellAddTargetDebuff(molten_weapon_1 molten_weapon_1=1)
Define(natural_harmony_fire 279028)
# Dealing Fire damage grants s1 Critical Strike for 12 seconds. rnDealing Frost damage grants s2 Mastery for 12 seconds.rnDealing Nature damage grants s3 Haste for 12 seconds.
  SpellInfo(natural_harmony_fire duration=12 channel=12 gcd=0 offgcd=1)
  # Critical Strike increased by w1.
  SpellAddBuff(natural_harmony_fire natural_harmony_fire=1)

Define(natural_harmony_frost 279029)
# Dealing Fire damage grants s1 Critical Strike for 12 seconds. rnDealing Frost damage grants s2 Mastery for 12 seconds.rnDealing Nature damage grants s3 Haste for 12 seconds.
  SpellInfo(natural_harmony_frost duration=12 channel=12 gcd=0 offgcd=1)
  # Mastery increased by w1.
  SpellAddBuff(natural_harmony_frost natural_harmony_frost=1)

Define(natural_harmony_nature 279033)
# Dealing Fire damage grants s1 Critical Strike for 12 seconds. rnDealing Frost damage grants s2 Mastery for 12 seconds.rnDealing Nature damage grants s3 Haste for 12 seconds.
  SpellInfo(natural_harmony_nature duration=12 channel=12 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(natural_harmony_nature natural_harmony_nature=1)

Define(primal_primer 273006)
# Melee attacks with Flametongue active increase the damage the target takes from your next Lava Lash by s1/2, stacking up to 273006u times.
  SpellInfo(primal_primer duration=30 channel=30 max_stacks=10 gcd=0 offgcd=1)
  # Increases damage taken from Lava Lash by w1/2.
  SpellAddTargetDebuff(primal_primer primal_primer=1)
Define(purifying_blast_0 295337)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds.?a295364[ Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.][]?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_0 cd=60 duration=6)
Define(purifying_blast_1 295338)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds.?a295364[ Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.][]?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_1 channel=0 gcd=0 offgcd=1)
Define(purifying_blast_2 295354)
# When an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.
  SpellInfo(purifying_blast_2 duration=8 gcd=0 offgcd=1)
  # Damage dealt increased by s1.
  SpellAddBuff(purifying_blast_2 purifying_blast_2=1)
Define(purifying_blast_3 295366)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds.?a295364[ Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.][]?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_3 duration=3 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(purifying_blast_3 purifying_blast_3=1)
Define(purifying_blast_4 299345)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds. Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_4 cd=60 duration=6 channel=6 gcd=1)
Define(purifying_blast_5 299347)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds. Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast_5 cd=60 duration=6 gcd=1)
Define(quaking_palm 107079)
# Strikes the target with lightning speed, incapacitating them for 4 seconds, and turns off your attack.
  SpellInfo(quaking_palm cd=120 duration=4 gcd=1)
  # Incapacitated.
  SpellAddTargetDebuff(quaking_palm quaking_palm=1)
Define(razor_coral_0 303564)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]
  SpellInfo(razor_coral_0 cd=20 channel=0 gcd=0 offgcd=1)
Define(razor_coral_1 303565)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_1 duration=120 max_stacks=100 gcd=0 offgcd=1)
  SpellAddBuff(razor_coral_1 razor_coral_1=1)
Define(razor_coral_2 303568)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_2 duration=120 max_stacks=100 gcd=0 offgcd=1)
  # Withdrawing the Razor Coral will grant w1 Critical Strike.
  SpellAddTargetDebuff(razor_coral_2 razor_coral_2=1)
Define(razor_coral_3 303570)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_3 duration=20 channel=20 max_stacks=100 gcd=0 offgcd=1)
  # Critical Strike increased by w1.
  SpellAddBuff(razor_coral_3 razor_coral_3=1)
Define(razor_coral_4 303572)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_4 channel=0 gcd=0 offgcd=1)
Define(reaping_flames_0 310690)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health?a310705[ or more than 310705s1 health][], the cooldown is reduced by s3 sec.?a310710[rnrnIf Reaping Flames kills an enemy, its cooldown is lowered to 310710s2 sec and it will deal 310710s1 increased damage on its next use.][]
  SpellInfo(reaping_flames_0 cd=45 channel=0)
Define(reaping_flames_1 311194)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health or more than 310705s1 health, the cooldown is reduced by m3 sec.
  SpellInfo(reaping_flames_1 cd=45 channel=0)
Define(reaping_flames_2 311195)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health or more than 310705s1 health, the cooldown is reduced by m3 sec.rnrnIf Reaping Flames kills an enemy, its cooldown is lowered to 310710s2 sec and it will deal 310710s1 increased damage on its next use. 
  SpellInfo(reaping_flames_2 cd=45 channel=0)
Define(reaping_flames_3 311202)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health?a310705[ or more than 310705s1 health][], the cooldown is reduced by s3 sec.?a310710[rnrnIf Reaping Flames kills an enemy, its cooldown is lowered to 310710s2 sec and it will deal 310710s1 increased damage on its next use.][]
  SpellInfo(reaping_flames_3 duration=30 gcd=0 offgcd=1)
  # Damage of next Reaping Flames increased by w1.
  SpellAddBuff(reaping_flames_3 reaping_flames_3=1)
Define(reaping_flames_4 311947)
  SpellInfo(reaping_flames_4 duration=2 gcd=0 offgcd=1)
  SpellAddTargetDebuff(reaping_flames_4 reaping_flames_4=1)
Define(reckless_force_buff_0 298409)
# When an ability fails to critically strike, you have a high chance to gain Reckless Force. When Reckless Force reaches 302917u stacks, your critical strike is increased by 302932s1 for 4 seconds.
  SpellInfo(reckless_force_buff_0 max_stacks=5 gcd=0 offgcd=1 tick=10)
  # Gaining unstable Azerite energy.
  SpellAddBuff(reckless_force_buff_0 reckless_force_buff_0=1)
Define(reckless_force_buff_1 304038)
# When an ability fails to critically strike, you have a high chance to gain Reckless Force. When Reckless Force reaches 302917u stacks, your critical strike is increased by 302932s1 for 4 seconds.
  SpellInfo(reckless_force_buff_1 channel=-0.001 gcd=0 offgcd=1)
  SpellAddBuff(reckless_force_buff_1 reckless_force_buff_1=1)
Define(ripple_in_space_0 299306)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space_0)
Define(ripple_in_space_1 299307)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space_1)
Define(ripple_in_space_2 299309)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space_2)
Define(ripple_in_space_3 299310)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space_3)
Define(seething_rage 297126)
# Increases your critical hit damage by 297126m for 5 seconds.
  SpellInfo(seething_rage duration=5 gcd=0 offgcd=1)
  # Critical strike damage increased by w1.
  SpellAddBuff(seething_rage seething_rage=1)
Define(spiritwalkers_grace 79206)
# Calls upon the guidance of the spirits for 15 seconds, permitting movement while casting Shaman spells. Castable while casting.?a192088[ Increases movement speed by 192088s2.][]
  SpellInfo(spiritwalkers_grace cd=120 duration=15 gcd=0 offgcd=1)
  # Able to move while casting all Shaman spells.
  SpellAddBuff(spiritwalkers_grace spiritwalkers_grace=1)
Define(storm_elemental 192249)
# Calls forth a Greater Storm Elemental to hurl gusts of wind that damage the Shaman's enemies for 30 seconds.rnrnWhile the Storm Elemental is active, each time you cast Lightning Bolt or Chain Lightning, the cast time of Lightning Bolt and Chain Lightning is reduced by 263806s1, stacking up to 263806u times.
  SpellInfo(storm_elemental cd=150 talent=storm_elemental_talent)
Define(stormbringer_0 201845)
# Your special attacks have a h.1 chance to reset the remaining cooldown on Stormstrike?a319930[ and increase the damage of your next Stormstrike by 319930s1][].
  SpellInfo(stormbringer_0 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(stormbringer_0 stormbringer_0=1)
Define(stormbringer_1 319930)
# Stormbringer now also increases the damage of your next Stormstrike by s1.
  SpellInfo(stormbringer_1 channel=0 gcd=0 offgcd=1)
  SpellAddBuff(stormbringer_1 stormbringer_1=1)
Define(stormkeeper 191634)
# Charge yourself with lightning, causing your next n Lightning Bolts to deal s2 more damage, and also causes your next n Lightning Bolts or Chain Lightnings to be instant cast and trigger an Elemental Overload on every target.
  SpellInfo(stormkeeper cd=60 duration=15 talent=stormkeeper_talent)
  # Your next Lightning Bolt will deal s2 increased damage, and your next Lightning Bolt or Chain Lightning will be instant cast and cause an Elemental Overload to trigger on every target hit.
  SpellAddBuff(stormkeeper stormkeeper=1)
Define(stormstrike 17364)
# Energizes both your weapons with lightning and delivers a massive blow to your target, dealing a total of 32175sw1+32176sw1 Physical damage.
  SpellInfo(stormstrike cd=7.5)


Define(strength_of_earth_buff 273463)
# Rockbiter causes your next melee ability, other than Rockbiter, to deal an additional s1 Nature damage.
  SpellInfo(strength_of_earth_buff channel=-0.001 gcd=0 offgcd=1)

Define(strike 138537)
# Strike the enemy, causing damage.
  SpellInfo(strike energy=40 gcd=1)
Define(sundering 197214)
# Shatters a line of earth in front of you with your main hand weapon, causing s1 Flamestrike damage and Incapacitating any enemy hit for 2 seconds.
  SpellInfo(sundering cd=40 duration=2 talent=sundering_talent)
  # Incapacitated.
  SpellAddTargetDebuff(sundering sundering=1)
Define(surge_of_power_buff 285514)
# Casting Earth Shock?s117014[ or Elemental Blast][] also enhances your next spell cast within 15 seconds:rnrn|cFFFFFFFFFlame Shock|r: The next cast also applies Flame Shock to 287185s1 additional target within 287185A1 yards of the target.rn|cFFFFFFFFLightning Bolt|r: Your next cast will cause an additional s2-s3 Elemental Overloads.rn|cFFFFFFFFLava Burst|r: Reduces the cooldown of your ?s192249[Storm][Fire] Elemental by m1/1000.1 sec.rn|cFFFFFFFFFrost Shock|r: Freezes the target in place for 6 seconds.rn
  SpellInfo(surge_of_power_buff duration=15 channel=15 gcd=0 offgcd=1)
  # Your next spell cast will be enhanced.
  SpellAddBuff(surge_of_power_buff surge_of_power_buff=1)
Define(tectonic_thunder 286976)
# Earthquake deals s1 Physical damage instantly, and has a s2 chance to make your next Chain Lightning be instant cast.
  SpellInfo(tectonic_thunder duration=15 channel=15 gcd=0 offgcd=1)
  # Your next Chain Lightning will be instant cast.
  SpellAddBuff(tectonic_thunder tectonic_thunder=1)
Define(the_unbound_force_0 299321)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force_0)
Define(the_unbound_force_1 299322)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force_1)
Define(the_unbound_force_2 299323)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force_2)
Define(the_unbound_force_3 299324)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force_3)
Define(thundercharge 204366)
# You call down bolts of lightning, charging you and your target's weapons.  The cooldown recovery rate of all abilities is increased by m1 for 10 seconds.
  SpellInfo(thundercharge cd=45 duration=10)
  # Cooldown recovery rate increased by ?w1>w3[w1][w3].
  SpellAddBuff(thundercharge thundercharge=1)
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
Define(wind_gust 157331)
# Conjures a gust of wind that deals (15 of Spell Power) Nature damage to an enemy.
  SpellInfo(wind_gust gcd=0.5)
Define(wind_shear 57994)
# Disrupts the target's concentration with a burst of wind, interrupting spellcasting and preventing any spell in that school from being cast for 3 seconds.
  SpellInfo(wind_shear cd=12 duration=3 gcd=0 offgcd=1 interrupt=1)
Define(windstrike 115356)
# Hurl a staggering blast of wind at an enemy, dealing a total of 115357sw1+115360sw1 Physical damage, bypassing armor.
  SpellInfo(windstrike cd=9)

Define(worldvein_resonance_0 298606)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance_0)
Define(worldvein_resonance_1 298607)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance_1)
Define(worldvein_resonance_2 298609)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance_2)
Define(worldvein_resonance_3 298611)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance_3)
SpellList(blood_fury blood_fury_0 blood_fury_1 blood_fury_2 blood_fury_3)
SpellList(blood_of_the_enemy blood_of_the_enemy_0 blood_of_the_enemy_1 blood_of_the_enemy_2 blood_of_the_enemy_3)
SpellList(chain_lightning chain_lightning_0 chain_lightning_1)
SpellList(concentrated_flame concentrated_flame_0 concentrated_flame_1 concentrated_flame_2 concentrated_flame_3 concentrated_flame_4 concentrated_flame_5 concentrated_flame_6)
SpellList(earth_elemental earth_elemental_0 earth_elemental_1)
SpellList(fireblood fireblood_0 fireblood_1)
SpellList(focused_azerite_beam focused_azerite_beam_0 focused_azerite_beam_1 focused_azerite_beam_2 focused_azerite_beam_3)
SpellList(guardian_of_azeroth guardian_of_azeroth_0 guardian_of_azeroth_1 guardian_of_azeroth_2 guardian_of_azeroth_3 guardian_of_azeroth_4 guardian_of_azeroth_5)
SpellList(lightning_bolt lightning_bolt_0 lightning_bolt_1)
SpellList(lightning_lasso lightning_lasso_0 lightning_lasso_1)
SpellList(memory_of_lucid_dreams memory_of_lucid_dreams_0 memory_of_lucid_dreams_1 memory_of_lucid_dreams_2)
SpellList(purifying_blast purifying_blast_0 purifying_blast_1 purifying_blast_2 purifying_blast_3 purifying_blast_4 purifying_blast_5)
SpellList(reaping_flames reaping_flames_0 reaping_flames_1 reaping_flames_2 reaping_flames_3 reaping_flames_4)
SpellList(ripple_in_space ripple_in_space_0 ripple_in_space_1 ripple_in_space_2 ripple_in_space_3)
SpellList(the_unbound_force the_unbound_force_0 the_unbound_force_1 the_unbound_force_2 the_unbound_force_3)
SpellList(worldvein_resonance worldvein_resonance_0 worldvein_resonance_1 worldvein_resonance_2 worldvein_resonance_3)
SpellList(icy_edge icy_edge_0 icy_edge_1)
SpellList(molten_weapon molten_weapon_0 molten_weapon_1)
SpellList(razor_coral razor_coral_0 razor_coral_1 razor_coral_2 razor_coral_3 razor_coral_4)
SpellList(reckless_force_buff reckless_force_buff_0 reckless_force_buff_1)
SpellList(stormbringer stormbringer_0 stormbringer_1)
Define(ascendance_talent_enhancement 21) #21972
# Transform into an Air Ascendant for 15 seconds, reducing the cooldown and cost of Stormstrike by s4, and transforming your auto attack and Stormstrike into Wind attacks which bypass armor and have a s1 yd range.
Define(ascendance_talent 21) #21675
# Transform into a Flame Ascendant for 15 seconds, replacing Chain Lightning with Lava Beam, removing the cooldown on Lava Burst, and increasing the damage of Lava Burst by an amount equal to your critical strike chance.
Define(crashing_storm_talent 16) #21973
# Crash Lightning also electrifies the ground, leaving an electrical field behind which damages enemies within it for 7*210801s1 Nature damage over 6 seconds. 
Define(earthen_spike_talent 20) #22977
# Summons an Earthen Spike under an enemy, dealing s1 Physical damage and increasing Physical and Nature damage you deal to the target by s2 for 10 seconds.
Define(echo_of_the_elements_talent_elemental 2) #22357
# ?c1[Lava Burst now has s2+1][Riptide, Healing Stream Totem, and Lava Burst now have s2+1] charges. Effects that reset ?c1[its][their] remaining cooldown will instead grant 1 charge.
Define(elemental_blast_talent_elemental 6) #23190
# Harnesses the raw power of the elements, dealing (140 of Spell Power) Elemental damage and increasing your Critical Strike or Haste by 118522s1 or Mastery by 173184s1*168534bc1 for 10 seconds.?a190493[rnrnElemental Blast will consume all stacks of Fulmination to deal extra Nature damage to your target.][]
Define(feral_lunge_talent 14) #22149
# Lunge at your enemy as a ghostly wolf, biting them to deal 215802s1 Physical damage.
Define(forceful_winds_talent 2) #22355
# Windfury causes each successive Windfury attack within 15 seconds to increase the damage of Windfury by 262652s1, stacking up to 262652u times.
Define(hailstorm_talent 11) #23090
# Each stack of Maelstrom Weapon consumed increases the damage of your next Frost Shock by 334196s1, and causes your next Frost Shock to hit 334196m2 additional target per Maelstrom Weapon stack consumed.
Define(hot_hand_talent 5) #23462
# Melee auto-attacks with Flametongue Weapon active have a h chance to reduce the cooldown of Lava Lash by 215785m2/4 and increase the damage of Lava Lash by 215785m1 for 8 seconds.
Define(icefury_talent 18) #23111
# Hurls frigid ice at the target, dealing (82.5 of Spell Power) Frost damage and causing your next n Frost Shocks to deal s2 increased damage.rnrn|cFFFFFFFFGenerates 343725s8 Maelstrom.|r
Define(liquid_magma_totem_talent 12) #19273
# Summons a totem at the target location for 15 seconds that hurls liquid magma at a random nearby target every 192226t1 sec, dealing (15 of Spell Power)*(1+(137040s3/100)) Fire damage to all enemies within 192223A1 yards.
Define(master_of_the_elements_talent 10) #19271
# Casting Lava Burst increases the damage of your next Nature, Physical, or Frost spell by 260734s1.
Define(primal_elementalist_talent 17) #19266
# Your Earth, Fire, and Storm Elementals are drawn from primal elementals s1 more powerful than regular elementals, with additional abilities, and you gain direct control over them.
Define(storm_elemental_talent 11) #19272
# Calls forth a Greater Storm Elemental to hurl gusts of wind that damage the Shaman's enemies for 30 seconds.rnrnWhile the Storm Elemental is active, each time you cast Lightning Bolt or Chain Lightning, the cast time of Lightning Bolt and Chain Lightning is reduced by 263806s1, stacking up to 263806u times.
Define(stormkeeper_talent 20) #22153
# Charge yourself with lightning, causing your next n Lightning Bolts to deal s2 more damage, and also causes your next n Lightning Bolts or Chain Lightnings to be instant cast and trigger an Elemental Overload on every target.
Define(sundering_talent 18) #22351
# Shatters a line of earth in front of you with your main hand weapon, causing s1 Flamestrike damage and Incapacitating any enemy hit for 2 seconds.
Define(surge_of_power_talent 16) #22145
# Casting Earth Shock?s117014[ or Elemental Blast][] also enhances your next spell cast within 15 seconds:rnrn|cFFFFFFFFFlame Shock|r: The next cast also applies Flame Shock to 287185s1 additional target within 287185A1 yards of the target.rn|cFFFFFFFFLightning Bolt|r: Your next cast will cause an additional s2-s3 Elemental Overloads.rn|cFFFFFFFFLava Burst|r: Reduces the cooldown of your ?s192249[Storm][Fire] Elemental by m1/1000.1 sec.rn|cFFFFFFFFFrost Shock|r: Freezes the target in place for 6 seconds.rn
Define(unlimited_power_talent 19) #21198
# When your spells cause an elemental overload, you gain 272737s1 Haste for 10 seconds. Gaining a stack does not refresh the duration.
Define(unbridled_fury_item 169299)
Define(ancestral_resonance_trait 277666)
Define(echo_of_the_elementals_trait 275381)
Define(igneous_potential_trait 279829)
Define(lava_shock_trait 273448)
Define(natural_harmony_trait 278697)
Define(tectonic_thunder_trait 286949)
Define(lightning_conduit_trait 275388)
Define(primal_primer_trait 272992)
Define(strength_of_earth_trait 273461)
Define(blood_of_the_enemy_essence_id 23)
    ]]
    OvaleScripts:RegisterScript("SHAMAN", nil, name, desc, code, "include")
end
