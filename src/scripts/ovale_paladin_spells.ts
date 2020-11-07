import { OvaleScriptsClass } from "../Scripts";

export function registerPaladinSpells(OvaleScripts: OvaleScriptsClass) {
    let name = "ovale_paladin_spells";
    let desc = "[9.0] Ovale: Paladin spells";
    // THIS PART OF THIS FILE IS AUTOMATICALLY GENERATED
// ANY CHANGES MADE BELOW THIS POINT WILL BE LOST
    let code = `Define(arcane_torrent 25046)
# Remove s1 beneficial effect from all enemies within A1 yards and restore m2 Energy.
  SpellInfo(arcane_torrent cd=120 gcd=1 energy=-15)
Define(ashen_hallow 316958)
# Hallow the target area for 30 seconds. Enemies in the area suffer up to (55.00000000000001 of Spell Power)*30 seconds/t2 Shadow damage, and allies are healed for up to (42 of Spell Power)*30 seconds/t2, reduced if there are more than s1 targets.rnrnWithin the Hallow, you may use Hammer of Wrath on any target, and its damage is increased by 330382s2.
  SpellInfo(ashen_hallow cd=240 duration=30 tick=2)
  SpellAddBuff(ashen_hallow ashen_hallow=1)
Define(avengers_shield 31935)
# Hurls your shield at an enemy target, dealing s1 Holy damage?a231665[, interrupting and silencing the non-Player target for 3 seconds][], and then jumping to x1-1 additional nearby enemies.rnrn|cFFFFFFFFGenerates s4 Holy Power?s337261[, and 337270s1 additional when it damages a target for the first time][].
  SpellInfo(avengers_shield cd=15 duration=3 interrupt=1 holypower=-1)
  # Silenced.
  SpellAddTargetDebuff(avengers_shield avengers_shield=1)
Define(avenging_wrath 31884)
# Call upon the Light to become an avatar of retribution, increasing your damage, healing, and critical strike chance by s1 for 20 seconds.
  SpellInfo(avenging_wrath cd=180 duration=20 gcd=0 offgcd=1)
  # Damage, healing, and critical strike chance increased by w1.
  SpellAddBuff(avenging_wrath avenging_wrath=1)
Define(blade_of_justice 184575)
# Pierces an enemy with a blade of light, dealing s1 Physical damage.rnrn|cFFFFFFFFGenerates s2 Holy Power.|r
  SpellInfo(blade_of_justice cd=12 holypower=-1)
Define(blessed_hammer 204019)
# Throws a Blessed Hammer that spirals outward, dealing 204301s1 Holy damage to enemies and reducing the next damage they deal to you by <shield>.rnrn|cFFFFFFFFGenerates s2 Holy Power.
  SpellInfo(blessed_hammer cd=6 duration=5 holypower=-1 talent=blessed_hammer_talent)
Define(blinding_light 115750)
# Emits dazzling light in all directions, blinding enemies within 105421A1 yards, causing them to wander disoriented for 105421d. Non-Holy damage will break the disorient effect.
  SpellInfo(blinding_light cd=90 duration=6 talent=blinding_light_talent)
  SpellAddBuff(blinding_light blinding_light=1)
Define(consecration 26573)
# Consecrates the land beneath you, causing 81297s1*9 Holy damage over 12 seconds to enemies who enter the area. Limit s2.
  SpellInfo(consecration cd=9 duration=12 tick=1)
  # Damage every t1 sec.
  SpellAddBuff(consecration consecration=1)
Define(crusade 231895)
# Call upon the Light and begin a crusade, increasing your damage done and haste by <damage> for 25 seconds.rnrnEach Holy Power spent during Crusade increases damage done and haste by an additional <damage>.rnrnMaximum u stacks.
  SpellInfo(crusade cd=20 charge_cd=120 duration=25 max_stacks=10 gcd=0 offgcd=1 talent=crusade_talent)
  # ?a206338[Damage done increased by w1.rnHaste increased by w3.][Damage done and haste increased by <damage>.]
  SpellAddBuff(crusade crusade=1)
Define(crusader_strike 231667)
# Crusader Strike now has s1+1 charges.
  SpellInfo(crusader_strike gcd=0 offgcd=1)
  SpellAddBuff(crusader_strike crusader_strike=1)
Define(divine_purpose 223819)
# Holy Power abilities have a s1 chance to make your next Holy Power ability free and deal 223819s2 increased damage and healing.
  SpellInfo(divine_purpose duration=12 gcd=0 offgcd=1)
  # Your next Holy Power ability is free and deals s2 increased damage and healing.
  SpellAddBuff(divine_purpose divine_purpose=1)
Define(divine_storm 53385)
# Unleashes a whirl of divine energy, dealing s1 Holy damage to up to s2 nearby enemies.
  SpellInfo(divine_storm holypower=3)
Define(divine_toll 304971)
# Instantly cast Holy Shock, Avenger's Shield, or Judgment on up to s1 targets within A2 yds (based on your current specialization).
  SpellInfo(divine_toll cd=60)
Define(empyrean_power_buff 286393)
# Your attacks have a chance to make your next Divine Storm free and deal s1 additional damage.
  SpellInfo(empyrean_power_buff duration=15 gcd=0 offgcd=1)
  # Your next Divine Storm is free and deals w1 additional damage.
  SpellAddBuff(empyrean_power_buff empyrean_power_buff=1)

Define(execution_sentence 343527)
# A hammer slowly falls from the sky upon the target. After 8 seconds, they suffer s1*<mult> Holy damage, plus s2 of damage taken from your abilities in that time.
  SpellInfo(execution_sentence holypower=3 cd=60 duration=8 tick=8 talent=execution_sentence_talent)
  # Sentenced to suffer w1 Holy damage.
  SpellAddTargetDebuff(execution_sentence execution_sentence=1)
Define(final_reckoning 343721)
# Call down a blast of heavenly energy, dealing s2 Holy damage to all targets in the target area and causing them to take s3 increased damage from your Holy Power abilities for 8 seconds.rnrn|cFFFFFFFFPassive:|r While off cooldown, your attacks have a high chance to call down a bolt that deals 343724s1 Holy damage and causes the target to take 343724s2 increased damage from your next Holy Power ability.
  SpellInfo(final_reckoning cd=60 duration=8 talent=final_reckoning_talent)
  # Taking w3 increased damage from @auracaster's Holy Power abilities.
  SpellAddTargetDebuff(final_reckoning final_reckoning=1)
Define(fireblood 265221)
# Removes all poison, disease, curse, magic, and bleed effects and increases your ?a162700[Agility]?a162702[Strength]?a162697[Agility]?a162698[Strength]?a162699[Intellect]?a162701[Intellect][primary stat] by 265226s1*3 and an additional 265226s1 for each effect removed. Lasts 8 seconds. ?s195710[This effect shares a 30 sec cooldown with other similar effects.][]
  SpellInfo(fireblood cd=120 gcd=0 offgcd=1)
Define(focused_azerite_beam 295258)
# Focus excess Azerite energy into the Heart of Azeroth, then expel that energy outward, dealing m1*10 Fire damage to all enemies in front of you over 3 seconds.?a295263[ Castable while moving.][]
  SpellInfo(focused_azerite_beam cd=90 duration=3 channel=3 tick=0.33)
  SpellAddBuff(focused_azerite_beam focused_azerite_beam=1)
Define(guardian_of_azeroth 295840)
# Call upon Azeroth to summon a Guardian of Azeroth for 30 seconds who impales your target with spikes of Azerite every s1/10.1 sec that deal 295834m1*(1+@versadmg) Fire damage.?a295841[ Every 303347t1 sec, the Guardian launches a volley of Azerite Spikes at its target, dealing 295841s1 Fire damage to all nearby enemies.][]?a295843[rnrnEach time the Guardian of Azeroth casts a spell, you gain 295855s1 Haste, stacking up to 295855u times. This effect ends when the Guardian of Azeroth despawns.][]rn
  SpellInfo(guardian_of_azeroth cd=180 duration=30)
  SpellAddBuff(guardian_of_azeroth guardian_of_azeroth=1)
Define(hammer_of_justice 853)
# Stuns the target for 6 seconds.
  SpellInfo(hammer_of_justice cd=60 duration=6)
  # Stunned.
  SpellAddTargetDebuff(hammer_of_justice hammer_of_justice=1)
Define(hammer_of_the_righteous 53595)
# Hammers the current target for 53595sw1 Physical damage.?s26573&s203785[rnrnHammer of the Righteous also causes a wave of light that hits all other targets within 88263A1 yds for 88263sw1 Holy damage.]?s26573[rnrnWhile you are standing in your Consecration, Hammer of the Righteous also causes a wave of light that hits all other targets within 88263A1 yds for 88263sw1 Holy damage.][]rnrn|cFFFFFFFFGenerates s2 Holy Power.
  SpellInfo(hammer_of_the_righteous cd=6 holypower=-1)
Define(hammer_of_wrath 24275)
# Hurls a divine hammer that strikes an enemy for s1 Holy damage. Only usable on enemies that have less than 20 health?s326730[, or during Avenging Wrath][].rnrn|cFFFFFFFFGenerates s2 Holy Power.
  SpellInfo(hammer_of_wrath cd=7.5 holypower=-1)
Define(holy_avenger 105809)
# Your Holy Power generation is tripled for 20 seconds.
  SpellInfo(holy_avenger cd=180 duration=20 gcd=0 offgcd=1 talent=holy_avenger_talent)
  # Your Holy Power generation is tripled.
  SpellAddBuff(holy_avenger holy_avenger=1)
Define(judgment 275779)
# Judges the target, dealing (112.5 of Spell Power) Holy damage?s231663[, and causing them to take 197277s1 increased damage from your next Holy Power ability][].?a315867[rnrn|cFFFFFFFFGenerates 220637s1 Holy Power.][]rn
  SpellInfo(judgment cd=12)
Define(judgment_debuff 197277)
# Judges the target, dealing (63.4 of Spell Power) Holy damage?s231663[, and causing them to take 197277s1 increased damage from your next Holy Power ability.][]?s315867[rnrn|cFFFFFFFFGenerates 220637s1 Holy Power.][]
  SpellInfo(judgment_debuff duration=15 gcd=0 offgcd=1)
  # Taking w1 increased damage from @auracaster's next Holy Power ability.
  SpellAddTargetDebuff(judgment_debuff judgment_debuff=1)
Define(lights_judgment 255647)
# Call down a strike of Holy energy, dealing <damage> Holy damage to enemies within A1 yards after 3 sec.
  SpellInfo(lights_judgment cd=150)

Define(memory_of_lucid_dreams 299300)
# Infuse your Heart of Azeroth with Memory of Lucid Dreams.
  SpellInfo(memory_of_lucid_dreams)
Define(memory_of_lucid_dreams_buff 298357)
# Clear your mind and attune yourself with the Heart of Azeroth, ?a137020[causing Frostbolt and Flurry to generate an additional Icicle]?a137019[increasing your Fire Blast recharge rate by 303399s1*-2][increasing your ?a137033[Insanity]?(a137032|a137031|a137021|a137020|a137019|a137012|a137029|a137024|a137041|a137039)[Mana]?a137027|a137028[Holy Power]?(a137050|a137049|a137048|a137010)[Rage]?(a137017|a137015|a137016)[Focus]?(a137011|a137025|a137023|a137037|a137036|a137035)[Energy]?a212613[Pain]?a212612[Fury]?(a137046|a137044|a137043)[Soul Shard]?(a137008|a137007|a137006)[Rune]?a137040[Maelstrom]?a137013[Astral Power][] generation rate by s1]?a298377[ and ][]?a137020&a298377[increases ][]?a298377[your Leech by 298268s6][] for 12 seconds.
  SpellInfo(memory_of_lucid_dreams_buff cd=120 duration=12)
  # ?a303412[Frostbolt and Flurry will generate an additional Icicle]?a303399[Fire Blast recharge rate increased by 303399s1*-2][@spelldesc304633 generation increased by s1].?w2>0[rnLeech increased by w2.][]
  SpellAddBuff(memory_of_lucid_dreams_buff memory_of_lucid_dreams_buff=1)
Define(moment_of_glory 327193)
# Reset the cooldown of Avenger's Shield. Your next n Avenger's Shields have no cooldown and deal s2 additional damage.
  SpellInfo(moment_of_glory cd=90 duration=15 gcd=0 offgcd=1 talent=moment_of_glory_talent)
  # Your next n Avenger's Shields have no cooldown and deal w2 additional damage.
  SpellAddBuff(moment_of_glory moment_of_glory=1)
Define(purifying_blast 295337)
# Call down a purifying beam upon the target area, dealing 295293s3*(1+@versadmg)*s2 Fire damage over 6 seconds.?a295364[ Has a low chance to immediately annihilate any specimen deemed unworthy by MOTHER.][]?a295352[rnrnWhen an enemy dies within the beam, your damage is increased by 295354s1 for 8 seconds.][]rnrnAny Aberration struck by the beam is stunned for 3 seconds.
  SpellInfo(purifying_blast cd=60 duration=6)
Define(razor_coral_debuff 303568)
# ?a303565[Remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.][Deal 304877s1*(1+@versadmg) Physical damage and apply Razor Coral to your target, giving your damaging abilities against the target a high chance to deal 304877s1*(1+@versadmg) Physical damage and add a stack of Razor Coral.rnrnReactivating this ability will remove Razor Coral from your target, granting you 303573s1 Critical Strike per stack for 20 seconds.]rn
  SpellInfo(razor_coral_debuff duration=120 max_stacks=100 gcd=0 offgcd=1)
  # Withdrawing the Razor Coral will grant w1 Critical Strike.
  SpellAddTargetDebuff(razor_coral_debuff razor_coral_debuff=1)
Define(rebuke 96231)
# Interrupts spellcasting and prevents any spell in that school from being cast for 4 seconds.
  SpellInfo(rebuke cd=15 duration=4 gcd=0 offgcd=1 interrupt=1)
Define(reckless_force_buff 304038)
# When an ability fails to critically strike, you have a high chance to gain Reckless Force. When Reckless Force reaches 302917u stacks, your critical strike is increased by 302932s1 for 4 seconds.
  SpellInfo(reckless_force_buff gcd=0 offgcd=1)
  SpellAddBuff(reckless_force_buff reckless_force_buff=1)
Define(seething_rage 297126)
# Increases your critical hit damage by 297126m for 5 seconds.
  SpellInfo(seething_rage duration=5 gcd=0 offgcd=1)
  # Critical strike damage increased by w1.
  SpellAddBuff(seething_rage seething_rage=1)
Define(seraphim 152262)
# The Light magnifies your power for 15 seconds, granting s1 Haste, Critical Strike, and Versatility, and ?c1[s4*183997bc1]?c2[s4*76671bc1][s4*267316bc1] Mastery.
  SpellInfo(seraphim holypower=3 cd=45 duration=15 talent=seraphim_talent)
  # Haste, Critical Strike, and Versatility increased by s1, and Mastery increased by ?c1[s4*183997bc1]?c2[s4*76671bc1][s4*267316bc1].
  SpellAddBuff(seraphim seraphim=1)
Define(shield_of_the_righteous 53600)
# Slams enemies in front of you with your shield, causing s1 Holy damage, and increasing your Armor by ?c1[132403s1*INT/100][132403s1*STR/100] for 4.5 seconds.
  SpellInfo(shield_of_the_righteous holypower=3 cd=1 gcd=0 offgcd=1)
Define(shield_of_vengeance 184662)
# Creates a barrier of holy light that absorbs <shield> damage for 15 seconds.rnrnWhen the shield expires, it bursts to inflict Holy damage equal to the total amount absorbed, divided among all nearby enemies.
  SpellInfo(shield_of_vengeance cd=120 duration=15)
  # Absorbs w1 damage and deals damage when the barrier fades or is fully consumed.
  SpellAddBuff(shield_of_vengeance shield_of_vengeance=1)
Define(templars_verdict 85256)
# Unleashes a powerful weapon strike that deals 224266s1 Holy damage to an enemy target.
  SpellInfo(templars_verdict holypower=3)
Define(the_unbound_force 299321)
# Infuse your Heart of Azeroth with The Unbound Force.
  SpellInfo(the_unbound_force)
Define(vanquishers_hammer 328204)
# Throws a hammer at your target dealing (170 of Spell Power) Shadow damage, and empowering your next ?c3[Templar's Verdict to automatically trigger Divine Storm]?c1[Word of Glory to automatically trigger Light of Dawn][Word of Glory to automatically trigger Shield of the Righteous].
  SpellInfo(vanquishers_hammer holypower=1 cd=30 duration=20)
  # Your next ?c3[Templar's Verdict automatically triggers Divine Storm]?c1[Word of Glory automatically triggers Light of Dawn][Word of Glory automatically triggers Shield of the Righteous].
  SpellAddBuff(vanquishers_hammer vanquishers_hammer=1)
Define(vengeful_shock 340006)
# Avenger's Shield causes your target to take |cFFFFFFFFs1.1|r increased Holy damage from you for 5 seconds.
  SpellInfo(vengeful_shock gcd=0 offgcd=1)

Define(wake_of_ashes 255937)
# Lash out at your enemies, dealing s1 Radiant damage to all enemies within a1 yd in front of you and reducing their movement speed by s2 for 5 seconds. Damage reduced on secondary targets.rnrnDemon and Undead enemies are also stunned for 5 seconds.rnrn|cFFFFFFFFGenerates s3 Holy Power.
  SpellInfo(wake_of_ashes cd=45 duration=5 holypower=-3)
  # Movement speed reduced by s2.
  SpellAddTargetDebuff(wake_of_ashes wake_of_ashes=1)
Define(war_stomp 20549)
# Stuns up to i enemies within A1 yds for 2 seconds.
  SpellInfo(war_stomp cd=90 duration=2 gcd=0 offgcd=1)
  # Stunned.
  SpellAddTargetDebuff(war_stomp war_stomp=1)
Define(word_of_glory 85673)
# Calls down the Light to heal a friendly target for 130551s1.?a315921&!a315924[rnrn|cFFFFFFFFProtection:|r If cast on yourself, healing increased by up to 315921s1 based on your missing health.][]?a315924[rnrn|cFFFFFFFFProtection:|r Healing increased by up to 315921s1 based on the target's missing health.][]
  SpellInfo(word_of_glory holypower=3)
Define(worldvein_resonance 298606)
# Infuse your Heart of Azeroth with Worldvein Resonance.
  SpellInfo(worldvein_resonance)
Define(blessed_hammer_talent 3) #23469
# Throws a Blessed Hammer that spirals outward, dealing 204301s1 Holy damage to enemies and reducing the next damage they deal to you by <shield>.rnrn|cFFFFFFFFGenerates s2 Holy Power.
Define(blinding_light_talent 9) #21811
# Emits dazzling light in all directions, blinding enemies within 105421A1 yards, causing them to wander disoriented for 105421d. Non-Holy damage will break the disorient effect.
Define(crusade_talent 20) #22215
# Call upon the Light and begin a crusade, increasing your damage done and haste by <damage> for 25 seconds.rnrnEach Holy Power spent during Crusade increases damage done and haste by an additional <damage>.rnrnMaximum u stacks.
Define(crusaders_judgment_talent 5) #22604
# Judgment now has 1+s1 charges, and Grand Crusader now also grants a charge of Judgment.
Define(execution_sentence_talent 3) #23467
# A hammer slowly falls from the sky upon the target. After 8 seconds, they suffer s1*<mult> Holy damage, plus s2 of damage taken from your abilities in that time.
Define(final_reckoning_talent 21) #22634
# Call down a blast of heavenly energy, dealing s2 Holy damage to all targets in the target area and causing them to take s3 increased damage from your Holy Power abilities for 8 seconds.rnrn|cFFFFFFFFPassive:|r While off cooldown, your attacks have a high chance to call down a bolt that deals 343724s1 Holy damage and causes the target to take 343724s2 increased damage from your next Holy Power ability.
Define(holy_avenger_talent 14) #17599
# Your Holy Power generation is tripled for 20 seconds.
Define(moment_of_glory_talent 6) #23468
# Reset the cooldown of Avenger's Shield. Your next n Avenger's Shields have no cooldown and deal s2 additional damage.
Define(sanctified_wrath_talent_protection 19) #23457
# Avenging Wrath lasts s1 longer and causes Judgment to generate s2 additional Holy Power.
Define(seraphim_talent 15) #17601
# The Light magnifies your power for 15 seconds, granting s1 Haste, Critical Strike, and Versatility, and ?c1[s4*183997bc1]?c2[s4*76671bc1][s4*267316bc1] Mastery.
Define(condensed_lifeforce_essence_id 14)
Define(vengeful_shock_conduit 195)
    `;
// END
    code += `

    
    
Define(blinding_light_talent 9)
Define(divine_shield 642)
	SpellInfo(divine_shield cd=300 duration=8)
	SpellInfo(divine_shield add_cd=-90 talent=unbreakable_spirit_talent)
	SpellAddBuff(divine_shield divine_shield=1)
	SpellRequire(divine_shield unusable 1=debuff,forbearance_debuff)
Define(forbearance_debuff 25771)
    SpellInfo(forbearance_debuff duration=30)
#hammer_of_wrath
    SpellInfo(hammer_of_wrath target_health_pct=20)
Define(lay_on_hands 633)
    SpellInfo(lay_on_hands cd=600)
    SpellInfo(lay_on_hands add_cd=-180 talent=unbreakable_spirit_talent)
    SpellRequire(lay_on_hands unusable 1=target_debuff,forbearance_debuff)
    SpellAddTargetDebuff(lay_on_hands forbearance_debuff=1)

    SpellInfo(shield_of_the_righteous holypower=3)
    SpellAddBuff(shield_of_the_righteous shield_of_the_righteous_buff=1)
    SpellRequire(shield_of_the_righteous holypower_percent 0=buff,divine_purpose)
    SpellAddBuff(shield_of_the_righteous divine_purpose=0)
Define(shield_of_the_righteous_buff 132403)
    SpellInfo(shield_of_the_righteous_buff duration=4.5)
Define(unbreakable_spirit_talent 10)

    SpellRequire(word_of_glory holypower_percent 0=buff,divine_purpose)
    SpellAddBuff(word_of_glory divine_purpose=0)
    
Define(shining_light_free_buff 327510)
    `;
    OvaleScripts.RegisterScript(
        "PALADIN",
        undefined,
        name,
        desc,
        code,
        "include"
    );
}
