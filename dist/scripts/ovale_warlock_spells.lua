local __exports = LibStub:NewLibrary("ovale/scripts/ovale_warlock_spells", 80300)
if not __exports then return end
__exports.registerWarlockSpells = function(OvaleScripts)
    local name = "ovale_warlock_spells"
    local desc = "[9.0] Ovale: Warlock spells"
    local code = [[Define(agony 980)
# Inflicts increasing agony on the target, causing up to ((1.1199999999999999 of Spell Power)+0.1)*18 seconds/t1*u Shadow damage over 18 seconds. Damage starts low and increases over the duration. Refreshing Agony maintains its current damage level.rnrn|cFFFFFFFFAgony damage sometimes generates 1 Soul Shard.|r
  SpellInfo(agony duration=18 max_stacks=6 tick=2)
  # Suffering w1 Shadow damage every t1 sec. Damage increases over time.
  SpellAddTargetDebuff(agony agony=1)
Define(backdraft_buff 117828)
# Conflagrate reduces the cast time of your next Incinerate or Chaos Bolt by 117828s1. Maximum ?s267115[s2][s1] charges.
  SpellInfo(backdraft_buff duration=10 max_stacks=2 gcd=0 offgcd=1)
  # Incinerate and Chaos Bolt cast times reduced by s1.
  SpellAddBuff(backdraft_buff backdraft_buff=1)
Define(berserking 59621)
# Permanently enchant a melee weapon to sometimes increase your attack power by 59620s1, but at the cost of reduced armor. Cannot be applied to items higher than level ecix
  SpellInfo(berserking gcd=0 offgcd=1)
Define(berserking_buff 26297)
# Increases your haste by s1 for 12 seconds.
  SpellInfo(berserking_buff cd=180 duration=12 gcd=0 offgcd=1)
  # Haste increased by s1.
  SpellAddBuff(berserking_buff berserking_buff=1)
Define(bilescourge_bombers 267211)
# Tear open a portal to the nether above the target location, from which several Bilescourge will pour out of and crash into the ground over 6 seconds, dealing (23 of Spell Power) Shadow damage to all enemies within 267213A1 yards.
  SpellInfo(bilescourge_bombers soulshards=2 cd=30 duration=6 talent=bilescourge_bombers_talent)
Define(blood_fury 20572)
# Increases your attack power by s1 for 15 seconds.
  SpellInfo(blood_fury cd=120 duration=15 gcd=0 offgcd=1)
  # Attack power increased by w1.
  SpellAddBuff(blood_fury blood_fury=1)
Define(blood_of_the_enemy 297969)
# Infuse your Heart of Azeroth with Blood of the Enemy.
  SpellInfo(blood_of_the_enemy)
Define(call_dreadstalkers 104316)
# Summons s1 ferocious Dreadstalkers to attack the target for 12 seconds.
  SpellInfo(call_dreadstalkers soulshards=2 cd=20)
Define(cascading_calamity_buff 275378)
# Casting Unstable Affliction on a target affected by your Unstable Affliction increases your Haste by s1 for 15 seconds
  SpellInfo(cascading_calamity_buff duration=15 gcd=0 offgcd=1)
  # Grants w1 Haste.
  SpellAddBuff(cascading_calamity_buff cascading_calamity_buff=1)

Define(cataclysm 152108)
# Calls forth a cataclysm at the target location, dealing (180 of Spell Power) Shadowflame damage to all enemies within A1 yards and afflicting them with ?s980[Agony and Unstable Affliction][]?s104315[Corruption][]?s348[Immolate][]?!s980&!s104315&!s348[Agony, Unstable Affliction, Corruption, or Immolate][].
  SpellInfo(cataclysm cd=30 talent=cataclysm_talent)
Define(channel_demonfire 196447)
# Launches s1 bolts of felfire over 3 seconds at random targets afflicted by your Immolate within 196449A1 yds. Each bolt deals (19.36 of Spell Power) Fire damage to the target and (7.7 of Spell Power) Fire damage to nearby enemies.
  SpellInfo(channel_demonfire cd=25 duration=3 channel=3 tick=0.2 talent=channel_demonfire_talent)
  SpellAddBuff(channel_demonfire channel_demonfire=1)
Define(chaos_bolt 116858)
# Unleashes a devastating blast of chaos, dealing a critical strike for 2*(120 of Spell Power) Chaos damage. Damage is further increased by your critical strike chance.
  SpellInfo(chaos_bolt soulshards=2)
Define(concentrated_flame 295368)
# Blast your target with a ball of concentrated flame, dealing 295365s2*(1+@versadmg) Fire damage to an enemy or healing an ally for 295365s2*(1+@versadmg)?a295377[, then burn the target for an additional 295377m1 of the damage or healing done over 6 seconds][]. rnrnEach cast of Concentrated Flame deals s3 increased damage or healing. This bonus resets after every third cast.
  SpellInfo(concentrated_flame duration=6 gcd=0 offgcd=1 tick=2)
  # Suffering w1 damage every t1 sec.
  SpellAddTargetDebuff(concentrated_flame concentrated_flame=1)
Define(conflagrate 17962)
# Triggers an explosion on the target, dealing (100 of Spell Power) Fire damage.?s196406[rnrnReduces the cast time of your next Incinerate or Chaos Bolt by 117828s1 for 10 seconds.][]rnrn|cFFFFFFFFGenerates 245330s1 Soul Shard Fragments.|r
  SpellInfo(conflagrate cd=12.96)
Define(corruption 172)
# Corrupts the target, causing?s334342[ (12 of Spell Power) Shadow damage and an additional][] 146739o1 Shadow damage over 14 seconds.
  SpellInfo(corruption)

Define(corruption_debuff 13530)
# Corrupts the target, causing o1 damage over 3 seconds.
  SpellInfo(corruption_debuff duration=3 tick=1)
  # Inflicts s1 Shadow damage every t1 sec.
  SpellAddTargetDebuff(corruption_debuff corruption_debuff=1)
Define(dark_soul_instability 113858)
# Infuses your soul with unstable power, increasing your critical strike chance by 113858s1 for 20 seconds.?s56228[rnrn|cFFFFFFFFPassive:|rrnIncreases your critical strike chance by 113858m1/56228m1. This effect is disabled while on cooldown.][]
  SpellInfo(dark_soul_instability cd=120 charge_cd=120 duration=20 gcd=0 offgcd=1 talent=dark_soul_instability_talent)
  # Critical strike chance increased by w1.
  SpellAddBuff(dark_soul_instability dark_soul_instability=1)
Define(dark_soul_misery 113860)
# Infuses your soul with the misery of fallen foes, increasing haste by (25 of Spell Power) for 20 seconds.
  SpellInfo(dark_soul_misery cd=120 duration=20 gcd=0 offgcd=1 talent=dark_soul_misery_talent)
  # Haste increased by s1.
  SpellAddBuff(dark_soul_misery dark_soul_misery=1)
Define(demonbolt 264178)
# Send the fiery soul of a fallen demon at the enemy, causing (73.4 of Spell Power) Shadowflame damage.?c2[rnrn|cFFFFFFFFGenerates 2 Soul Shards.|r][]
  SpellInfo(demonbolt)
Define(demonic_core_buff 264173)
# When your Wild Imps expend all of their energy or are imploded, you have a s1 chance to absorb their life essence, granting you a stack of Demonic Core. rnrnWhen your summoned Dreadstalkers fade away, you have a s2 chance to absorb their life essence, granting you a stack of Demonic Core.rnrnDemonic Core reduces the cast time of Demonbolt by 264173s1. Maximum 264173u stacks.
  SpellInfo(demonic_core_buff duration=20 max_stacks=4 gcd=0 offgcd=1)
  # The cast time of Demonbolt is reduced by s1. ?a334581[Demonbolt damage is increased by 334581s1.][]
  SpellAddBuff(demonic_core_buff demonic_core_buff=1)
Define(demonic_strength 267171)
# Infuse your Felguard with demonic strength and command it to charge your target and unleash a Felstorm that will deal s2 increased damage.
  SpellInfo(demonic_strength cd=60 duration=20 talent=demonic_strength_talent)
  # Your next Felstorm will deal s2 increased damage.
  SpellAddBuff(demonic_strength demonic_strength=1)
Define(doom 603)
# Inflicts impending doom upon the target, causing o1 Shadow damage after 20 seconds.rnrn|cFFFFFFFFDoom damage generates 1 Soul Shard.|r
  SpellInfo(doom duration=20 tick=20 talent=doom_talent)
  # Doomed to take w1 Shadow damage.
  SpellAddTargetDebuff(doom doom=1)
Define(drain_life 234153)
# ?a334320[Drains life from the target, causing o1 * 334320s1 Shadow damage over 5 seconds, and healing you for e1*100 of the damage done.][Drains life from the target, causing o1 Shadow damage over 5 seconds, and healing you for e1*100 of the damage done.]
  SpellInfo(drain_life duration=5 channel=5 tick=1)
  # Suffering s1 Shadow damage every t1 seconds.rnRestoring health to the Warlock.
  SpellAddTargetDebuff(drain_life drain_life=1)
Define(drain_soul 198590)
# Drains the target's soul, causing o1 Shadow damage over 5 seconds.rnrnDamage is increased by s2 against enemies below s3 health.rnrn|cFFFFFFFFGenerates 1 Soul Shard if the target dies during this effect.|r
  SpellInfo(drain_soul duration=5 channel=5 tick=1 talent=drain_soul_talent)
  # Suffering w1 Shadow damage every t1 seconds.
  SpellAddTargetDebuff(drain_soul drain_soul=1)
Define(eradication 196412)
# Chaos Bolt increases the damage you deal to the target by 196414s1 for 7 seconds.
  SpellInfo(eradication gcd=0 offgcd=1 talent=eradication_talent)

Define(explosive_potential 275398)
# When your Implosion consumes 3 or more Imps, gain s1 Haste for 15 seconds.
  SpellInfo(explosive_potential duration=15 gcd=0 offgcd=1)
  # Haste increased by w1.
  SpellAddBuff(explosive_potential explosive_potential=1)

Define(fireblood 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood cd=120 gcd=0 offgcd=1)
Define(focused_azerite_beam 295258)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds.?a295263[ Castable while moving.][]
  SpellInfo(focused_azerite_beam cd=90 duration=3 channel=3 tick=0.33)
  SpellAddBuff(focused_azerite_beam focused_azerite_beam=1)
Define(grimoire_felguard 111898)
# Summons a Felguard who attacks the target for 17 seconds that deals 216187s1 increased damage.rnrnThis Felguard will stun their target when summoned.
  SpellInfo(grimoire_felguard soulshards=1 cd=120 duration=17 talent=grimoire_felguard_talent)
Define(grimoire_of_sacrifice 108503)
# Sacrifices your demon pet for power, gaining its command demon ability, and causing your spells to sometimes also deal (43.75 of Spell Power) additional Shadow damage.rnrnLasts 3600 seconds or until you summon a demon pet.
  SpellInfo(grimoire_of_sacrifice cd=30 talent=grimoire_of_sacrifice_talent)

Define(guardian_of_azeroth 295840)
# Call upon Azeroth to summon a Guardian of Azeroth for 30 seconds who impales your target with spikes of Azerite every s1/10.1 sec that deal 295834m1*(1+@versadmg) Fire damage.?a295841[ Every 303347t1 sec, the Guardian launches a volley of Azerite Spikes at its target, dealing 295841s1 Fire damage to all nearby enemies.][]?a295843[rnrnEach time the Guardian of Azeroth casts a spell, you gain 295855s1 Haste, stacking up to 295855u times. This effect ends when the Guardian of Azeroth despawns.][]rn
  SpellInfo(guardian_of_azeroth cd=180 duration=30)
  SpellAddBuff(guardian_of_azeroth guardian_of_azeroth=1)
Define(hand_of_guldan 105174)
# Calls down a demonic meteor full of Wild Imps which burst forth to attack the target.rnrnDeals up to m1*86040m1 Shadowflame damage on impact to all enemies within 86040A1 yds of the target?s196283[, applies Doom to each target,][] and summons up to m1*104317m2 Wild Imps, based on Soul Shards consumed.
  SpellInfo(hand_of_guldan soulshards=1)
Define(haunt 48181)
# A ghostly soul haunts the target, dealing (68.75 of Spell Power) Shadow damage and increasing your damage dealt to the target by s2 for 18 seconds.rnrnIf the target dies, Haunt's cooldown is reset.
  SpellInfo(haunt cd=15 duration=18 talent=haunt_talent)
  # Taking s2 increased damage from the Warlock. Haunt's cooldown will be reset on death.
  SpellAddTargetDebuff(haunt haunt=1)
Define(havoc 80240)
# Marks a target with Havoc for 10 seconds, causing your single target spells to also strike the Havoc victim for s1 of normal initial damage.
  SpellInfo(havoc cd=30 duration=10 max_stacks=1)
  # Spells cast by the Warlock also hit this target for s1 of normal initial damage.
  SpellAddTargetDebuff(havoc havoc=1)
Define(immolate 348)
# Burns the enemy, causing (40 of Spell Power) Fire damage immediately and an additional 157736o1 Fire damage over 18 seconds.rnrn|cFFFFFFFFPeriodic damage generates 1 Soul Shard Fragment and has a s2 chance to generate an additional 1 on critical strikes.|r
  SpellInfo(immolate)
Define(immolate_debuff 118297)
# Burns an enemy, then inflicts additional Fire damage every t1 sec. for 21 seconds.
  SpellInfo(immolate_debuff mana=0.95 cd=10 duration=21 gcd=0 offgcd=1 tick=3)
  # Fire damage inflicted every t1 sec.
  SpellAddTargetDebuff(immolate_debuff immolate_debuff=1)
Define(implosion 196277)
# Demonic forces suck all of your Wild Imps toward the target, and then cause them to violently explode, dealing 196278s2 Shadowflame damage to all enemies within 196278A3 yards.
  SpellInfo(implosion)
Define(incinerate 29722)
# Draws fire toward the enemy, dealing (64.1 of Spell Power) Fire damage.rnrn|cFFFFFFFFGenerates 244670s1 Soul Shard Fragments and an additional 1 on critical strikes.|r
  SpellInfo(incinerate max_stacks=5)
  SpellInfo(shadow_bolt replaced_by=incinerate)
Define(inevitable_demise_buff 273522)
# Damaging an enemy with Agony increases the damage of your next Drain Life by s1. This effect stacks up to 273525u times.
  SpellInfo(inevitable_demise_buff gcd=0 offgcd=1)
  SpellAddBuff(inevitable_demise_buff inevitable_demise_buff=1)
Define(inner_demons 267216)
# You passively summon a Wild Imp to fight for you every t1 sec, and have a s1 chance to also summon an additional Demon to fight for you for s2 sec.
  SpellInfo(inner_demons gcd=0 offgcd=1 tick=12 talent=inner_demons_talent)
  SpellAddBuff(inner_demons inner_demons=1)
Define(malefic_rapture 324536)
# Your damaging periodic effects erupt on all targets, causing <damage> Shadow damage per effect.
  SpellInfo(malefic_rapture soulshards=1)
Define(memory_of_lucid_dreams 299300)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams)
Define(nether_portal 267217)
# Tear open a portal to the Twisting Nether for 15 seconds. Every time you spend Soul Shards, you will also command demons from the Nether to come out and fight for you.
  SpellInfo(nether_portal soulshards=1 cd=180 duration=15 talent=nether_portal_talent)
Define(phantom_singularity 205179)
# Places a phantom singularity above the target, which consumes the life of all enemies within 205246A2 yards, dealing 8*(22.5 of Spell Power) damage over 16 seconds, healing you for 205246e2*100 of the damage done.
  SpellInfo(phantom_singularity cd=45 duration=16 tick=2 talent=phantom_singularity_talent)
  # Dealing damage to all nearby targets every t1 sec and healing the casting Warlock.
  SpellAddTargetDebuff(phantom_singularity phantom_singularity=1)
Define(power_siphon 264130)
# Instantly sacrifice up to s1 Wild Imps, generating s1 charges of Demonic Core that cause Demonbolt to deal 334581s1 additional damage.
  SpellInfo(power_siphon cd=30 talent=power_siphon_talent)
Define(purifying_blast 295337)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds.?a295364[ Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.][]?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast cd=60 duration=6)
Define(rain_of_fire 5740)
# Calls down a rain of hellfire, dealing 42223m1*8 Fire damage over 8 seconds to enemies in the area.
  SpellInfo(rain_of_fire soulshards=3 duration=8 tick=1)
  # 42223s1 Fire damage every 5740t2 sec.
  SpellAddBuff(rain_of_fire rain_of_fire=1)
Define(reaping_flames 310690)
# Burn your target with a bolt of Azerite, dealing 310712s3 Fire damage. If the target has less than s2 health?a310705[ or more than 310705s1 health][], the cooldown is reduced by s3 sec.?a310710[rnrnIf Reaping Flames kills an enemy, its cooldown is lowered to 310710s2 sec and it will deal 310710s1 increased damage on its next use.][]
  SpellInfo(reaping_flames cd=45)
Define(reckless_force_buff 304038)
# When an ability fails to critically strike, you have a high chance to gain Reckless Force. When Reckless Force reaches 302917u stacks, your critical strike is increased by 302932s1 for 4 seconds.
  SpellInfo(reckless_force_buff gcd=0 offgcd=1)
  SpellAddBuff(reckless_force_buff reckless_force_buff=1)
Define(ripple_in_space 299306)
# Infuse your Heart of Azeroth with Ripple in Space.
  SpellInfo(ripple_in_space)
Define(seed_of_corruption 27243)
# Embeds a demon seed in the enemy target that will explode after 12 seconds, dealing (40 of Spell Power) Shadow damage to all enemies within 27285A1 yards and applying Corruption to them.rnrnThe seed will detonate early if the target is hit by other detonations, or takes SPS*s1/100 damage from your spells.
  SpellInfo(seed_of_corruption soulshards=1 duration=12 tick=12)
  # Embeded with a demon seed that will soon explode, dealing Shadow damage to the caster's enemies within 27285A1 yards, and applying Corruption to them.rnrnThe seed will detonate early if the target is hit by other detonations, or takes w3 damage from your spells.
  SpellAddTargetDebuff(seed_of_corruption seed_of_corruption=1)
Define(shadow_bolt 686)
# Sends a shadowy bolt at the enemy, causing (34.5 of Spell Power) Shadow damage.?c2[rnrn|cFFFFFFFFGenerates 1 Soul Shard.|r][]?a32388[rnrnApplies Shadow Embrace, increasing your damage dealt to the target by 32390s1 for 12 seconds. Stacks up to 32390u times.][] 
  SpellInfo(shadow_bolt)
Define(shadowburn 17877)
# Blasts a target for (130 of Spell Power) Shadowflame damage, gaining s3 critical strike chance on targets that have 20 or less health.rnrn|cFFFFFFFFRestores 245731s1/10 Soul Shard if the target dies within 5 seconds.|r
  SpellInfo(shadowburn soulshards=1 cd=12 duration=5 talent=shadowburn_talent)
  # If the target dies and yields experience or honor, Shadowburn restores 245731s1/10 Soul Shard.
  SpellAddTargetDebuff(shadowburn shadowburn=1)
Define(siphon_life 63106)
# Siphons the target's life essence, dealing o1 Shadow damage over 15 seconds and healing you for e1*100 of the damage done.
  SpellInfo(siphon_life duration=15 tick=3 talent=siphon_life_talent)
  # Suffering w1 Shadow damage every t1 sec and siphoning life to the casting Warlock.
  SpellAddTargetDebuff(siphon_life siphon_life=1)
Define(soul_fire 6353)
# Burns the enemy's soul, dealing (420 of Spell Power) Fire damage and applying Immolate.rnrn|cFFFFFFFFGenerates 281490s1/10 Soul Shard.|r
  SpellInfo(soul_fire cd=45 talent=soul_fire_talent)
Define(soul_strike 264057)
# Command your Felguard to strike into the soul of its enemy, dealing <damage> Shadow damage.?c2[rnrn|cFFFFFFFFGenerates 1 Soul Shard.|r][]
  SpellInfo(soul_strike cd=10 talent=soul_strike_talent)
Define(summon_darkglare 205180)
# Summons a Darkglare from the Twisting Nether that extends the duration of your damage over time effects on all enemies by s2 sec.rnrnThe Darkglare will serve you for 20 seconds, blasting its target for (32 of Spell Power) Shadow damage, increased by s3 for every damage over time effect you have active on any target.
  SpellInfo(summon_darkglare cd=180 duration=20)
  # Summons a Darkglare from the Twisting Nether that blasts its target for Shadow damage, dealing increased damage for every damage over time effect you have active on any target.
  SpellAddBuff(summon_darkglare summon_darkglare=1)
Define(summon_demonic_tyrant 265187)
# Summon a Demonic Tyrant to increase the duration of all of your current lesser demons by 265273m3/1000 sec, and increase the damage of all of your other demons by 265273s2, while damaging your target.?s334585[rnrn|cFFFFFFFFGenerates s2/10 Soul Shards.|r][]
  SpellInfo(summon_demonic_tyrant cd=90 duration=15 soulshards=0)
Define(summon_felguard 30146)
# Summons a Felguard under your command as a powerful melee combatant.
  SpellInfo(summon_felguard soulshards=1)
Define(summon_imp 688)
# Summons an Imp under your command that casts ranged Firebolts.
  SpellInfo(summon_imp soulshards=1)
Define(summon_infernal 1122)
# Summons an Infernal from the Twisting Nether, impacting for (60 of Spell Power) Fire damage and stunning all enemies in the area for 2 seconds.rnrnThe Infernal will serve you for 30 seconds, dealing (50 of Spell Power)*(100+137046s3)/100 damage to all nearby enemies every 19483t1 sec and generating 264365s1 Soul Shard Fragment every 264364t1 sec.
  SpellInfo(summon_infernal cd=180 duration=0.25)

Define(summon_vilefiend 264119)
# Summon a Vilefiend to fight for you for the next 15 seconds.
  SpellInfo(summon_vilefiend soulshards=1 cd=45 duration=15 talent=summon_vilefiend_talent)
Define(the_unbound_force 299321)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force)
Define(unstable_affliction 316099)
# Afflicts one target with o2 Shadow damage over 16 seconds. rnrnIf dispelled, deals m2*s1/100 damage to the dispeller and silences them for 4 seconds.rnrn|cFFFFFFFFGenerates 231791m1 Soul LShard:Shards; if the target dies while afflicted.|r
  SpellInfo(unstable_affliction duration=16 max_stacks=1 tick=2)
  # Suffering w2 Shadow damage every t2 sec. If dispelled, will cause w2*s1/100 damage to the dispeller and silence them for 196364d.
  SpellAddTargetDebuff(unstable_affliction unstable_affliction=1)
Define(unstable_affliction_debuff 196364)
# Afflicts one target with o2 Shadow damage over 16 seconds. rnrnIf dispelled, deals m2*s1/100 damage to the dispeller and silences them for 4 seconds.rnrn|cFFFFFFFFGenerates 231791m1 Soul LShard:Shards; if the target dies while afflicted.|r
  SpellInfo(unstable_affliction_debuff duration=4 gcd=0 offgcd=1)
  # Silenced.
  SpellAddTargetDebuff(unstable_affliction_debuff unstable_affliction_debuff=1)
Define(vile_taint 278350)
# Unleashes a vile explosion at the target location, dealing o1 Shadow damage over 10 seconds to all enemies within a1 yds and reducing their movement speed by s2.
  SpellInfo(vile_taint soulshards=1 cd=20 duration=10 tick=2 talent=vile_taint_talent)
  # Suffering w1 Shadow damage every t1 sec.rnMovement slowed by s2.
  SpellAddTargetDebuff(vile_taint vile_taint=1)
Define(wild_imp 104317)
# Calls down a demonic meteor full of Wild Imps which burst forth to attack the target.rnrnDeals up to m1*86040m1 Shadowflame damage on impact to all enemies within 86040A1 yds of the target?s196283[, applies Doom to each target,][] and summons up to m1*104317m2 Wild Imps, based on Soul Shards consumed.
  SpellInfo(wild_imp duration=20 gcd=0 offgcd=1)
Define(worldvein_resonance 298606)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance)
Define(bilescourge_bombers_talent 2) #22048
# Tear open a portal to the nether above the target location, from which several Bilescourge will pour out of and crash into the ground over 6 seconds, dealing (23 of Spell Power) Shadow damage to all enemies within 267213A1 yards.
Define(cataclysm_talent 12) #23143
# Calls forth a cataclysm at the target location, dealing (180 of Spell Power) Shadowflame damage to all enemies within A1 yards and afflicting them with ?s980[Agony and Unstable Affliction][]?s104315[Corruption][]?s348[Immolate][]?!s980&!s104315&!s348[Agony, Unstable Affliction, Corruption, or Immolate][].
Define(channel_demonfire_talent 20) #23144
# Launches s1 bolts of felfire over 3 seconds at random targets afflicted by your Immolate within 196449A1 yds. Each bolt deals (19.36 of Spell Power) Fire damage to the target and (7.7 of Spell Power) Fire damage to nearby enemies.
Define(dark_soul_instability_talent 21) #23092
# Infuses your soul with unstable power, increasing your critical strike chance by 113858s1 for 20 seconds.?s56228[rnrn|cFFFFFFFFPassive:|rrnIncreases your critical strike chance by 113858m1/56228m1. This effect is disabled while on cooldown.][]
Define(dark_soul_misery_talent 21) #19293
# Infuses your soul with the misery of fallen foes, increasing haste by (25 of Spell Power) for 20 seconds.
Define(demonic_consumption_talent 20) #22479
# Your Demon Commander now drains 267971s2 of the life from your demon servants to empower himself.
Define(demonic_strength_talent 3) #23138
# Infuse your Felguard with demonic strength and command it to charge your target and unleash a Felstorm that will deal s2 increased damage.
Define(doom_talent 6) #23158
# Inflicts impending doom upon the target, causing o1 Shadow damage after 20 seconds.rnrn|cFFFFFFFFDoom damage generates 1 Soul Shard.|r
Define(drain_soul_talent 3) #23141
# Drains the target's soul, causing o1 Shadow damage over 5 seconds.rnrnDamage is increased by s2 against enemies below s3 health.rnrn|cFFFFFFFFGenerates 1 Soul Shard if the target dies during this effect.|r
Define(eradication_talent 2) #22090
# Chaos Bolt increases the damage you deal to the target by 196414s1 for 7 seconds.
Define(fire_and_brimstone_talent 11) #22043
# Incinerate now also hits all enemies near your target for s1 damage and generates s2 Soul Shard LFragment:Fragments; for each additional enemy hit.
Define(flashover_talent 1) #22038
# Conflagrate deals s3 increased damage and grants an additional charge of Backdraft.
Define(grimoire_of_sacrifice_talent 18) #19295
# Sacrifices your demon pet for power, gaining its command demon ability, and causing your spells to sometimes also deal (43.75 of Spell Power) additional Shadow damage.rnrnLasts 3600 seconds or until you summon a demon pet.
Define(grimoire_felguard_talent 18) #21717
# Summons a Felguard who attacks the target for 17 seconds that deals 216187s1 increased damage.rnrnThis Felguard will stun their target when summoned.
Define(haunt_talent 17) #23159
# A ghostly soul haunts the target, dealing (68.75 of Spell Power) Shadow damage and increasing your damage dealt to the target by s2 for 18 seconds.rnrnIf the target dies, Haunt's cooldown is reset.
Define(inferno_talent 10) #22480
# Rain of Fire damage is increased by s2 and has a s1 chance to generate a Soul Shard Fragment.
Define(inner_demons_talent 17) #23146
# You passively summon a Wild Imp to fight for you every t1 sec, and have a s1 chance to also summon an additional Demon to fight for you for s2 sec.
Define(internal_combustion_talent 5) #21695
# Chaos Bolt consumes up to s1 sec of Immolate's damage over time effect on your target, instantly dealing that much damage.
Define(nether_portal_talent 21) #23091
# Tear open a portal to the Twisting Nether for 15 seconds. Every time you spend Soul Shards, you will also command demons from the Nether to come out and fight for you.
Define(phantom_singularity_talent 11) #19292
# Places a phantom singularity above the target, which consumes the life of all enemies within 205246A2 yards, dealing 8*(22.5 of Spell Power) damage over 16 seconds, healing you for 205246e2*100 of the damage done.
Define(power_siphon_talent 5) #21694
# Instantly sacrifice up to s1 Wild Imps, generating s1 charges of Demonic Core that cause Demonbolt to deal 334581s1 additional damage.
Define(shadowburn_talent 6) #23157
# Blasts a target for (130 of Spell Power) Shadowflame damage, gaining s3 critical strike chance on targets that have 20 or less health.rnrn|cFFFFFFFFRestores 245731s1/10 Soul Shard if the target dies within 5 seconds.|r
Define(siphon_life_talent 6) #22089
# Siphons the target's life essence, dealing o1 Shadow damage over 15 seconds and healing you for e1*100 of the damage done.
Define(soul_fire_talent 3) #22040
# Burns the enemy's soul, dealing (420 of Spell Power) Fire damage and applying Immolate.rnrn|cFFFFFFFFGenerates 281490s1/10 Soul Shard.|r
Define(soul_strike_talent 11) #22042
# Command your Felguard to strike into the soul of its enemy, dealing <damage> Shadow damage.?c2[rnrn|cFFFFFFFFGenerates 1 Soul Shard.|r][]
Define(sow_the_seeds_talent 10) #19279
# Seed of Corruption now @switch<s2>[][consumes a Soul Shard, if available, to ]embeds demon seeds into s1 additional nearby enemies.
Define(summon_vilefiend_talent 12) #23160
# Summon a Vilefiend to fight for you for the next 15 seconds.
Define(vile_taint_talent 12) #22046
# Unleashes a vile explosion at the target location, dealing o1 Shadow damage over 10 seconds to all enemies within a1 yds and reducing their movement speed by s2.
Define(unbridled_fury_item 139327)
Define(cascading_calamity_trait 275372)
Define(explosive_potential_trait 275395)
    ]]
    code = code .. [[
# Demons
Define(vilefiend 135816)
Define(demonic_tyrant 135002)
Define(wild_imp 55659)
Define(wild_imp_inner_demons 143622)
Define(dreadstalker 98035)
Define(darkglare 103673)
Define(infernal 89)
Define(felguard 17252)

# Azerite
Define(inevitable_demise_az_buff 273521)
  ]]
    OvaleScripts:RegisterScript("WARLOCK", nil, name, desc, code, "include")
end
