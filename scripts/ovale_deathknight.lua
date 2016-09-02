local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "icyveins_deathknight_blood"
	local desc = "[7.0] Icy-Veins: DeathKnight Blood"
	local code = [[

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_deathknight_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=blood)
AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=blood)
AddCheckBox(opt_legendary_ring_tank ItemName(legendary_ring_bonus_armor) default specialization=blood)

AddFunction BloodDefaultShortCDActions
{
	Spell(death_and_decay)
	if CheckBoxOn(opt_melee_range) and not target.InRange(death_strike) Texture(misc_arrowlup help=L(not_in_melee_range))
	if not BuffPresent(rune_tap_buff) Spell(rune_tap)
	if RuneCount() < 6 Spell(blood_tap)
}

AddFunction BloodDefaultMainActions
{
	BloodHealMe()
	if not Talent(soulgorge_talent) and target.DebuffRemaining(blood_plague_debuff) < 8 Spell(blood_boil)
	Spell(consumption)
	if BuffStacks(bone_shield_buff) <= 1 Spell(marrowrend)
	if target.DebuffRemaining(blood_plague_debuff) < 8 Spell(deaths_caress)
	if Talent(ossuary_talent) and BuffStacks(bone_shield_buff) <5 Spell(marrowrend)
	if Talent(mark_of_blood_talent) and not target.DebuffPresent(mark_of_blood_debuff) Spell(mark_of_blood)
	if RunicPower() >= 80 Spell(death_strike)
	if not Talent(soulgorge_talent) Spell(blood_boil)
	if target.TimeToDie() >= 8 Spell(death_and_decay)
	if BuffStacks(bone_shield_buff) <= 7 Spell(marrowrend)
	if BuffStacks(bone_shield_buff) >= 1 Spell(heart_strike)
	Spell(blood_boil)
}

AddFunction BloodDefaultAoEActions
{
	BloodHealMe()
	if not Talent(soulgorge_talent) and target.DebuffRemaining(blood_plague_debuff) < 8 Spell(blood_boil)
	Spell(consumption)
	if BuffStacks(bone_shield_buff) <= 1 Spell(marrowrend)
	if target.DebuffRemaining(blood_plague_debuff) < 8 Spell(deaths_caress)
	if Talent(ossuary_talent) and BuffStacks(bone_shield_buff) < 5 and Enemies() < 3 Spell(marrowrend)
	if Talent(mark_of_blood_talent) and not target.DebuffPresent(mark_of_blood_debuff) Spell(mark_of_blood)
	if RunicPower() >= 80 Spell(bonestorm)
	if RunicPower() >= 80 Spell(death_strike)
	if not Talent(soulgorge_talent) Spell(blood_boil)
	Spell(death_and_decay)
	if BuffStacks(bone_shield_buff) <= 7 and Enemies() < 3 Spell(marrowrend)
	if BuffStacks(bone_shield_buff) >= 1 Spell(heart_strike)
	Spell(blood_boil)
	Spell(death_strike)
}

AddFunction BloodHealMe
{
	if HealthPercent() <= 70 Spell(death_strike)
	if DamageTaken(5) * 0.2 > (Health() / 100 * 25) Spell(death_strike)
	if (BuffStacks(bone_shield_buff) * 3) > (100 - HealthPercent()) Spell(tombstone)
}

AddFunction BloodDefaultCdActions
{
	BloodInterruptActions()
	if IncomingDamage(1.5 magic=1) > 0 spell(antimagic_shell)
	if CheckBoxOn(opt_legendary_ring_tank) Item(legendary_ring_bonus_armor usable=1)
	Spell(vampiric_blood)
	if target.InRange(blood_mirror) Spell(blood_mirror)
	Spell(dancing_rune_weapon)
	if BuffStacks(bone_shield_buff) >= 5 Spell(tombstone)
}

AddFunction BloodInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.IsInterruptible()
	{
		if target.InRange(mind_freeze) Spell(mind_freeze)
		if not target.Classification(worldboss)
		{
			if target.InRange(asphyxiate) Spell(asphyxiate)
			Spell(arcane_torrent_runicpower)
			if target.InRange(quaking_palm) Spell(quaking_palm)
			Spell(war_stomp)
		}
	}
}

AddIcon help=shortcd specialization=blood
{
	BloodDefaultShortCDActions()
}

AddIcon enemies=1 help=main specialization=blood
{
	BloodDefaultMainActions()
}

AddIcon help=aoe specialization=blood
{
	if Enemies() <= 1 BloodDefaultMainActions()
	BloodDefaultAoEActions()
}

AddIcon help=cd specialization=blood
{
	#if not InCombat() ProtectionPrecombatCdActions()
	BloodDefaultCdActions()
}
]]
	OvaleScripts:RegisterScript("DEATHKNIGHT", "blood", name, desc, code, "script")
end

-- THE REST OF THIS FILE IS AUTOMATICALLY GENERATED.
-- ANY CHANGES MADE BELOW THIS POINT WILL BE LOST.

do
	local name = "simulationcraft_death_knight_frost_t18m"
	local desc = "[7.0] SimulationCraft: Death_Knight_Frost_T18M"
	local code = [[
# Based on SimulationCraft profile "Death_Knight_Frost_T18M".
#	class=deathknight
#	spec=frost
#	talents=1130023

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_deathknight_spells)

AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=frost)
AddCheckBox(opt_potion_strength ItemName(draenic_strength_potion) default specialization=frost)
AddCheckBox(opt_legendary_ring_strength ItemName(legendary_ring_strength) default specialization=frost)

AddFunction FrostUsePotionStrength
{
	if CheckBoxOn(opt_potion_strength) and target.Classification(worldboss) Item(draenic_strength_potion usable=1)
}

AddFunction FrostGetInMeleeRange
{
	if CheckBoxOn(opt_melee_range) and not target.InRange(death_strike) Texture(misc_arrowlup help=L(not_in_melee_range))
}

### actions.default

AddFunction FrostDefaultMainActions
{
	#run_action_list,name=bos,if=dot.breath_of_sindragosa.ticking
	if BuffPresent(breath_of_sindragosa_buff) FrostBosMainActions()

	unless BuffPresent(breath_of_sindragosa_buff) and FrostBosMainPostConditions()
	{
		#call_action_list,name=generic
		FrostGenericMainActions()
	}
}

AddFunction FrostDefaultMainPostConditions
{
	BuffPresent(breath_of_sindragosa_buff) and FrostBosMainPostConditions() or FrostGenericMainPostConditions()
}

AddFunction FrostDefaultShortCdActions
{
	#auto_attack
	FrostGetInMeleeRange()
	#pillar_of_frost
	Spell(pillar_of_frost)
	#obliteration
	Spell(obliteration)
	#run_action_list,name=bos,if=dot.breath_of_sindragosa.ticking
	if BuffPresent(breath_of_sindragosa_buff) FrostBosShortCdActions()

	unless BuffPresent(breath_of_sindragosa_buff) and FrostBosShortCdPostConditions()
	{
		#call_action_list,name=generic
		FrostGenericShortCdActions()
	}
}

AddFunction FrostDefaultShortCdPostConditions
{
	BuffPresent(breath_of_sindragosa_buff) and FrostBosShortCdPostConditions() or FrostGenericShortCdPostConditions()
}

AddFunction FrostDefaultCdActions
{
	#arcane_torrent,if=runic_power.deficit>20
	if RunicPowerDeficit() > 20 Spell(arcane_torrent_runicpower)
	#blood_fury,if=!talent.breath_of_sindragosa.enabled|dot.breath_of_sindragosa.ticking
	if not Talent(breath_of_sindragosa_talent) or BuffPresent(breath_of_sindragosa_buff) Spell(blood_fury_ap)
	#berserking
	Spell(berserking)
	#use_item,slot=finger1
	if CheckBoxOn(opt_legendary_ring_strength) Item(legendary_ring_strength usable=1)
	#potion,name=draenic_strength
	FrostUsePotionStrength()
	#sindragosas_fury
	Spell(sindragosas_fury)

	unless Spell(obliteration)
	{
		#breath_of_sindragosa,if=runic_power>=50
		if RunicPower() >= 50 Spell(breath_of_sindragosa)
		#run_action_list,name=bos,if=dot.breath_of_sindragosa.ticking
		if BuffPresent(breath_of_sindragosa_buff) FrostBosCdActions()

		unless BuffPresent(breath_of_sindragosa_buff) and FrostBosCdPostConditions()
		{
			#call_action_list,name=generic
			FrostGenericCdActions()
		}
	}
}

AddFunction FrostDefaultCdPostConditions
{
	Spell(obliteration) or BuffPresent(breath_of_sindragosa_buff) and FrostBosCdPostConditions() or FrostGenericCdPostConditions()
}

### actions.bos

AddFunction FrostBosMainActions
{
	#howling_blast,target_if=!dot.frost_fever.ticking
	if not target.DebuffPresent(frost_fever_debuff) Spell(howling_blast)
	#call_action_list,name=core
	FrostCoreMainActions()

	unless FrostCoreMainPostConditions()
	{
		#howling_blast,if=buff.rime.react
		if BuffPresent(rime_buff) Spell(howling_blast)
	}
}

AddFunction FrostBosMainPostConditions
{
	FrostCoreMainPostConditions()
}

AddFunction FrostBosShortCdActions
{
	unless not target.DebuffPresent(frost_fever_debuff) and Spell(howling_blast)
	{
		#call_action_list,name=core
		FrostCoreShortCdActions()

		unless FrostCoreShortCdPostConditions()
		{
			#horn_of_winter
			if BuffExpires(attack_power_multiplier_buff any=1) Spell(horn_of_winter)
		}
	}
}

AddFunction FrostBosShortCdPostConditions
{
	not target.DebuffPresent(frost_fever_debuff) and Spell(howling_blast) or FrostCoreShortCdPostConditions() or BuffPresent(rime_buff) and Spell(howling_blast)
}

AddFunction FrostBosCdActions
{
	unless not target.DebuffPresent(frost_fever_debuff) and Spell(howling_blast)
	{
		#call_action_list,name=core
		FrostCoreCdActions()

		unless FrostCoreCdPostConditions() or BuffExpires(attack_power_multiplier_buff any=1) and Spell(horn_of_winter)
		{
			#empower_rune_weapon,if=runic_power<=70
			if RunicPower() <= 70 Spell(empower_rune_weapon)
			#hungering_rune_weapon
			Spell(hungering_rune_weapon)
		}
	}
}

AddFunction FrostBosCdPostConditions
{
	not target.DebuffPresent(frost_fever_debuff) and Spell(howling_blast) or FrostCoreCdPostConditions() or BuffExpires(attack_power_multiplier_buff any=1) and Spell(horn_of_winter) or BuffPresent(rime_buff) and Spell(howling_blast)
}

### actions.core

AddFunction FrostCoreMainActions
{
	#glacial_advance
	Spell(glacial_advance)
	#frost_strike,if=buff.obliteration.up&!buff.killing_machine.react
	if BuffPresent(obliteration_buff) and not BuffPresent(killing_machine_buff) Spell(frost_strike)
	#frostscythe,if=!talent.breath_of_sindragosa.enabled&(buff.killing_machine.react|spell_targets.frostscythe>=4)
	if not Talent(breath_of_sindragosa_talent) and { BuffPresent(killing_machine_buff) or Enemies() >= 4 } Spell(frostscythe)
	#obliterate,if=buff.killing_machine.react
	if BuffPresent(killing_machine_buff) Spell(obliterate)
	#remorseless_winter,if=spell_targets.remorseless_winter>=2
	if Enemies() >= 2 Spell(remorseless_winter)
	#obliterate
	Spell(obliterate)
	#frostscythe,if=talent.frozen_pulse.enabled
	if Talent(frozen_pulse_talent) Spell(frostscythe)
	#howling_blast,if=talent.frozen_pulse.enabled
	if Talent(frozen_pulse_talent) Spell(howling_blast)
}

AddFunction FrostCoreMainPostConditions
{
}

AddFunction FrostCoreShortCdActions
{
}

AddFunction FrostCoreShortCdPostConditions
{
	Spell(glacial_advance) or BuffPresent(obliteration_buff) and not BuffPresent(killing_machine_buff) and Spell(frost_strike) or not Talent(breath_of_sindragosa_talent) and { BuffPresent(killing_machine_buff) or Enemies() >= 4 } and Spell(frostscythe) or BuffPresent(killing_machine_buff) and Spell(obliterate) or Enemies() >= 2 and Spell(remorseless_winter) or Spell(obliterate) or Talent(frozen_pulse_talent) and Spell(frostscythe) or Talent(frozen_pulse_talent) and Spell(howling_blast)
}

AddFunction FrostCoreCdActions
{
}

AddFunction FrostCoreCdPostConditions
{
	Spell(glacial_advance) or BuffPresent(obliteration_buff) and not BuffPresent(killing_machine_buff) and Spell(frost_strike) or not Talent(breath_of_sindragosa_talent) and { BuffPresent(killing_machine_buff) or Enemies() >= 4 } and Spell(frostscythe) or BuffPresent(killing_machine_buff) and Spell(obliterate) or Enemies() >= 2 and Spell(remorseless_winter) or Spell(obliterate) or Talent(frozen_pulse_talent) and Spell(frostscythe) or Talent(frozen_pulse_talent) and Spell(howling_blast)
}

### actions.generic

AddFunction FrostGenericMainActions
{
	#howling_blast,target_if=!dot.frost_fever.ticking
	if not target.DebuffPresent(frost_fever_debuff) Spell(howling_blast)
	#howling_blast,if=buff.rime.react
	if BuffPresent(rime_buff) Spell(howling_blast)
	#frost_strike,if=runic_power>=80
	if RunicPower() >= 80 Spell(frost_strike)
	#call_action_list,name=core
	FrostCoreMainActions()

	unless FrostCoreMainPostConditions()
	{
		#frost_strike,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
		if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 Spell(frost_strike)
		#frost_strike,if=!talent.breath_of_sindragosa.enabled
		if not Talent(breath_of_sindragosa_talent) Spell(frost_strike)
	}
}

AddFunction FrostGenericMainPostConditions
{
	FrostCoreMainPostConditions()
}

AddFunction FrostGenericShortCdActions
{
	unless not target.DebuffPresent(frost_fever_debuff) and Spell(howling_blast) or BuffPresent(rime_buff) and Spell(howling_blast) or RunicPower() >= 80 and Spell(frost_strike)
	{
		#call_action_list,name=core
		FrostCoreShortCdActions()

		unless FrostCoreShortCdPostConditions()
		{
			#horn_of_winter,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
			if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 and BuffExpires(attack_power_multiplier_buff any=1) Spell(horn_of_winter)
			#horn_of_winter,if=!talent.breath_of_sindragosa.enabled
			if not Talent(breath_of_sindragosa_talent) and BuffExpires(attack_power_multiplier_buff any=1) Spell(horn_of_winter)
		}
	}
}

AddFunction FrostGenericShortCdPostConditions
{
	not target.DebuffPresent(frost_fever_debuff) and Spell(howling_blast) or BuffPresent(rime_buff) and Spell(howling_blast) or RunicPower() >= 80 and Spell(frost_strike) or FrostCoreShortCdPostConditions() or Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 and Spell(frost_strike) or not Talent(breath_of_sindragosa_talent) and Spell(frost_strike)
}

AddFunction FrostGenericCdActions
{
	unless not target.DebuffPresent(frost_fever_debuff) and Spell(howling_blast) or BuffPresent(rime_buff) and Spell(howling_blast) or RunicPower() >= 80 and Spell(frost_strike)
	{
		#call_action_list,name=core
		FrostCoreCdActions()

		unless FrostCoreCdPostConditions() or Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 and BuffExpires(attack_power_multiplier_buff any=1) and Spell(horn_of_winter) or not Talent(breath_of_sindragosa_talent) and BuffExpires(attack_power_multiplier_buff any=1) and Spell(horn_of_winter) or Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 and Spell(frost_strike) or not Talent(breath_of_sindragosa_talent) and Spell(frost_strike)
		{
			#empower_rune_weapon,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
			if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 Spell(empower_rune_weapon)
			#hungering_rune_weapon,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>15
			if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 Spell(hungering_rune_weapon)
			#empower_rune_weapon,if=!talent.breath_of_sindragosa.enabled
			if not Talent(breath_of_sindragosa_talent) Spell(empower_rune_weapon)
			#hungering_rune_weapon,if=!talent.breath_of_sindragosa.enabled
			if not Talent(breath_of_sindragosa_talent) Spell(hungering_rune_weapon)
		}
	}
}

AddFunction FrostGenericCdPostConditions
{
	not target.DebuffPresent(frost_fever_debuff) and Spell(howling_blast) or BuffPresent(rime_buff) and Spell(howling_blast) or RunicPower() >= 80 and Spell(frost_strike) or FrostCoreCdPostConditions() or Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 and BuffExpires(attack_power_multiplier_buff any=1) and Spell(horn_of_winter) or not Talent(breath_of_sindragosa_talent) and BuffExpires(attack_power_multiplier_buff any=1) and Spell(horn_of_winter) or Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 15 and Spell(frost_strike) or not Talent(breath_of_sindragosa_talent) and Spell(frost_strike)
}

### actions.precombat

AddFunction FrostPrecombatMainActions
{
}

AddFunction FrostPrecombatMainPostConditions
{
}

AddFunction FrostPrecombatShortCdActions
{
}

AddFunction FrostPrecombatShortCdPostConditions
{
}

AddFunction FrostPrecombatCdActions
{
	#flask,type=greater_draenic_strength_flask
	#food,type=pickled_eel
	#snapshot_stats
	#potion,name=draenic_strength
	FrostUsePotionStrength()
}

AddFunction FrostPrecombatCdPostConditions
{
}

### Frost icons.

AddCheckBox(opt_deathknight_frost_aoe L(AOE) default specialization=frost)

AddIcon checkbox=!opt_deathknight_frost_aoe enemies=1 help=shortcd specialization=frost
{
	if not InCombat() FrostPrecombatShortCdActions()
	unless not InCombat() and FrostPrecombatShortCdPostConditions()
	{
		FrostDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_deathknight_frost_aoe help=shortcd specialization=frost
{
	if not InCombat() FrostPrecombatShortCdActions()
	unless not InCombat() and FrostPrecombatShortCdPostConditions()
	{
		FrostDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=frost
{
	if not InCombat() FrostPrecombatMainActions()
	unless not InCombat() and FrostPrecombatMainPostConditions()
	{
		FrostDefaultMainActions()
	}
}

AddIcon checkbox=opt_deathknight_frost_aoe help=aoe specialization=frost
{
	if not InCombat() FrostPrecombatMainActions()
	unless not InCombat() and FrostPrecombatMainPostConditions()
	{
		FrostDefaultMainActions()
	}
}

AddIcon checkbox=!opt_deathknight_frost_aoe enemies=1 help=cd specialization=frost
{
	if not InCombat() FrostPrecombatCdActions()
	unless not InCombat() and FrostPrecombatCdPostConditions()
	{
		FrostDefaultCdActions()
	}
}

AddIcon checkbox=opt_deathknight_frost_aoe help=cd specialization=frost
{
	if not InCombat() FrostPrecombatCdActions()
	unless not InCombat() and FrostPrecombatCdPostConditions()
	{
		FrostDefaultCdActions()
	}
}

### Required symbols
# arcane_torrent_runicpower
# berserking
# blood_fury_ap
# breath_of_sindragosa
# breath_of_sindragosa_buff
# breath_of_sindragosa_talent
# death_strike
# draenic_strength_potion
# empower_rune_weapon
# frost_fever_debuff
# frost_strike
# frostscythe
# frozen_pulse_talent
# glacial_advance
# horn_of_winter
# howling_blast
# hungering_rune_weapon
# killing_machine_buff
# legendary_ring_strength
# obliterate
# obliteration
# obliteration_buff
# pillar_of_frost
# remorseless_winter
# rime_buff
# sindragosas_fury
]]
	OvaleScripts:RegisterScript("DEATHKNIGHT", "frost", name, desc, code, "script")
end

do
	local name = "simulationcraft_death_knight_unholy_t18m"
	local desc = "[7.0] SimulationCraft: Death_Knight_Unholy_T18M"
	local code = [[
# Based on SimulationCraft profile "Death_Knight_Unholy_T18M".
#	class=deathknight
#	spec=unholy
#	talents=2220013

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_deathknight_spells)

AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=unholy)
AddCheckBox(opt_potion_strength ItemName(draenic_strength_potion) default specialization=unholy)
AddCheckBox(opt_legendary_ring_strength ItemName(legendary_ring_strength) default specialization=unholy)

AddFunction UnholyUsePotionStrength
{
	if CheckBoxOn(opt_potion_strength) and target.Classification(worldboss) Item(draenic_strength_potion usable=1)
}

AddFunction UnholyGetInMeleeRange
{
	if CheckBoxOn(opt_melee_range) and not target.InRange(death_strike) Texture(misc_arrowlup help=L(not_in_melee_range))
}

### actions.default

AddFunction UnholyDefaultMainActions
{
	#outbreak,target_if=!dot.virulent_plague.ticking
	if not target.DebuffPresent(virulent_plague_debuff) Spell(outbreak)
	#run_action_list,name=valkyr,if=talent.dark_arbiter.enabled&pet.valkyr_battlemaiden.active
	if Talent(dark_arbiter_talent) and pet.Present() UnholyValkyrMainActions()

	unless Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrMainPostConditions()
	{
		#call_action_list,name=generic
		UnholyGenericMainActions()
	}
}

AddFunction UnholyDefaultMainPostConditions
{
	Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrMainPostConditions() or UnholyGenericMainPostConditions()
}

AddFunction UnholyDefaultShortCdActions
{
	#auto_attack
	UnholyGetInMeleeRange()

	unless not target.DebuffPresent(virulent_plague_debuff) and Spell(outbreak)
	{
		#dark_transformation
		Spell(dark_transformation)
		#blighted_rune_weapon
		Spell(blighted_rune_weapon)
		#run_action_list,name=valkyr,if=talent.dark_arbiter.enabled&pet.valkyr_battlemaiden.active
		if Talent(dark_arbiter_talent) and pet.Present() UnholyValkyrShortCdActions()

		unless Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrShortCdPostConditions()
		{
			#call_action_list,name=generic
			UnholyGenericShortCdActions()
		}
	}
}

AddFunction UnholyDefaultShortCdPostConditions
{
	not target.DebuffPresent(virulent_plague_debuff) and Spell(outbreak) or Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrShortCdPostConditions() or UnholyGenericShortCdPostConditions()
}

AddFunction UnholyDefaultCdActions
{
	#arcane_torrent,if=runic_power.deficit>20
	if RunicPowerDeficit() > 20 Spell(arcane_torrent_runicpower)
	#blood_fury
	Spell(blood_fury_ap)
	#berserking
	Spell(berserking)
	#use_item,slot=finger1
	if CheckBoxOn(opt_legendary_ring_strength) Item(legendary_ring_strength usable=1)
	#potion,name=draenic_strength,if=buff.unholy_strength.react
	if BuffPresent(unholy_strength_buff) UnholyUsePotionStrength()

	unless not target.DebuffPresent(virulent_plague_debuff) and Spell(outbreak) or Spell(dark_transformation) or Spell(blighted_rune_weapon)
	{
		#run_action_list,name=valkyr,if=talent.dark_arbiter.enabled&pet.valkyr_battlemaiden.active
		if Talent(dark_arbiter_talent) and pet.Present() UnholyValkyrCdActions()

		unless Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrCdPostConditions()
		{
			#call_action_list,name=generic
			UnholyGenericCdActions()
		}
	}
}

AddFunction UnholyDefaultCdPostConditions
{
	not target.DebuffPresent(virulent_plague_debuff) and Spell(outbreak) or Spell(dark_transformation) or Spell(blighted_rune_weapon) or Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrCdPostConditions() or UnholyGenericCdPostConditions()
}

### actions.aoe

AddFunction UnholyAoeMainActions
{
	#death_and_decay,if=spell_targets.death_and_decay>=2
	if Enemies() >= 2 Spell(death_and_decay)
	#epidemic,if=spell_targets.epidemic>4
	if Enemies() > 4 Spell(epidemic)
	#scourge_strike,if=spell_targets.scourge_strike>=2&(dot.death_and_decay.ticking|dot.defile.ticking)
	if Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } Spell(scourge_strike)
	#clawing_shadows,if=spell_targets.clawing_shadows>=2&(dot.death_and_decay.ticking|dot.defile.ticking)
	if Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } Spell(clawing_shadows)
	#epidemic,if=spell_targets.epidemic>2
	if Enemies() > 2 Spell(epidemic)
}

AddFunction UnholyAoeMainPostConditions
{
}

AddFunction UnholyAoeShortCdActions
{
}

AddFunction UnholyAoeShortCdPostConditions
{
	Enemies() >= 2 and Spell(death_and_decay) or Enemies() > 4 and Spell(epidemic) or Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } and Spell(scourge_strike) or Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } and Spell(clawing_shadows) or Enemies() > 2 and Spell(epidemic)
}

AddFunction UnholyAoeCdActions
{
}

AddFunction UnholyAoeCdPostConditions
{
	Enemies() >= 2 and Spell(death_and_decay) or Enemies() > 4 and Spell(epidemic) or Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } and Spell(scourge_strike) or Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } and Spell(clawing_shadows) or Enemies() > 2 and Spell(epidemic)
}

### actions.generic

AddFunction UnholyGenericMainActions
{
	#death_coil,if=runic_power>80
	if RunicPower() > 80 Spell(death_coil)
	#death_coil,if=talent.dark_arbiter.enabled&buff.sudden_doom.react&cooldown.dark_arbiter.remains>5
	if Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 Spell(death_coil)
	#death_coil,if=!talent.dark_arbiter.enabled&buff.sudden_doom.react
	if not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) Spell(death_coil)
	#festering_strike,if=debuff.festering_wound.stack<8&cooldown.apocalypse.remains<5
	if target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 Spell(festering_strike)
	#festering_strike,if=debuff.soul_reaper.up&!debuff.festering_wound.up
	if target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) Spell(festering_strike)
	#scourge_strike,if=debuff.soul_reaper.up&debuff.festering_wound.stack>=1
	if target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 Spell(scourge_strike)
	#clawing_shadows,if=debuff.soul_reaper.up&debuff.festering_wound.stack>=1
	if target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 Spell(clawing_shadows)
	#call_action_list,name=aoe,if=active_enemies>=2
	if Enemies() >= 2 UnholyAoeMainActions()

	unless Enemies() >= 2 and UnholyAoeMainPostConditions()
	{
		#festering_strike,if=debuff.festering_wound.stack<=3
		if target.DebuffStacks(festering_wound_debuff) <= 3 Spell(festering_strike)
		#scourge_strike,if=buff.necrosis.react
		if BuffPresent(necrosis_buff) Spell(scourge_strike)
		#clawing_shadows,if=buff.necrosis.react
		if BuffPresent(necrosis_buff) Spell(clawing_shadows)
		#scourge_strike,if=buff.unholy_strength.react
		if BuffPresent(unholy_strength_buff) Spell(scourge_strike)
		#clawing_shadows,if=buff.unholy_strength.react
		if BuffPresent(unholy_strength_buff) Spell(clawing_shadows)
		#scourge_strike,if=rune>=2
		if Rune() >= 2 Spell(scourge_strike)
		#clawing_shadows,if=rune>=2
		if Rune() >= 2 Spell(clawing_shadows)
		#death_coil,if=talent.shadow_infusion.enabled&talent.dark_arbiter.enabled&!buff.dark_transformation.up&cooldown.dark_arbiter.remains>15
		if Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 Spell(death_coil)
		#death_coil,if=talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled&!buff.dark_transformation.up
		if Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) Spell(death_coil)
		#death_coil,if=talent.dark_arbiter.enabled&cooldown.dark_arbiter.remains>15
		if Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 Spell(death_coil)
		#death_coil,if=!talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled
		if not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) Spell(death_coil)
	}
}

AddFunction UnholyGenericMainPostConditions
{
	Enemies() >= 2 and UnholyAoeMainPostConditions()
}

AddFunction UnholyGenericShortCdActions
{
	#apocalypse,if=debuff.festering_wound.stack=8
	if target.DebuffStacks(festering_wound_debuff) == 8 Spell(apocalypse)

	unless RunicPower() > 80 and Spell(death_coil) or Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Spell(death_coil) or not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike)
	{
		#soul_reaper,if=debuff.festering_wound.stack>=3
		if target.DebuffStacks(festering_wound_debuff) >= 3 Spell(soul_reaper_unholy)

		unless target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(scourge_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(clawing_shadows)
		{
			#defile
			Spell(defile)
			#call_action_list,name=aoe,if=active_enemies>=2
			if Enemies() >= 2 UnholyAoeShortCdActions()
		}
	}
}

AddFunction UnholyGenericShortCdPostConditions
{
	RunicPower() > 80 and Spell(death_coil) or Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Spell(death_coil) or not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(scourge_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(clawing_shadows) or Enemies() >= 2 and UnholyAoeShortCdPostConditions() or target.DebuffStacks(festering_wound_debuff) <= 3 and Spell(festering_strike) or BuffPresent(necrosis_buff) and Spell(scourge_strike) or BuffPresent(necrosis_buff) and Spell(clawing_shadows) or BuffPresent(unholy_strength_buff) and Spell(scourge_strike) or BuffPresent(unholy_strength_buff) and Spell(clawing_shadows) or Rune() >= 2 and Spell(scourge_strike) or Rune() >= 2 and Spell(clawing_shadows) or Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and Spell(death_coil) or Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and Spell(death_coil)
}

AddFunction UnholyGenericCdActions
{
	#dark_arbiter,if=runic_power>80
	if RunicPower() > 80 Spell(dark_arbiter)
	#summon_gargoyle
	Spell(summon_gargoyle)

	unless target.DebuffStacks(festering_wound_debuff) == 8 and Spell(apocalypse) or RunicPower() > 80 and Spell(death_coil) or Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Spell(death_coil) or not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike) or target.DebuffStacks(festering_wound_debuff) >= 3 and Spell(soul_reaper_unholy) or target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(scourge_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(clawing_shadows) or Spell(defile)
	{
		#call_action_list,name=aoe,if=active_enemies>=2
		if Enemies() >= 2 UnholyAoeCdActions()
	}
}

AddFunction UnholyGenericCdPostConditions
{
	target.DebuffStacks(festering_wound_debuff) == 8 and Spell(apocalypse) or RunicPower() > 80 and Spell(death_coil) or Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Spell(death_coil) or not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike) or target.DebuffStacks(festering_wound_debuff) >= 3 and Spell(soul_reaper_unholy) or target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(scourge_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(clawing_shadows) or Spell(defile) or Enemies() >= 2 and UnholyAoeCdPostConditions() or target.DebuffStacks(festering_wound_debuff) <= 3 and Spell(festering_strike) or BuffPresent(necrosis_buff) and Spell(scourge_strike) or BuffPresent(necrosis_buff) and Spell(clawing_shadows) or BuffPresent(unholy_strength_buff) and Spell(scourge_strike) or BuffPresent(unholy_strength_buff) and Spell(clawing_shadows) or Rune() >= 2 and Spell(scourge_strike) or Rune() >= 2 and Spell(clawing_shadows) or Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and Spell(death_coil) or Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and Spell(death_coil)
}

### actions.precombat

AddFunction UnholyPrecombatMainActions
{
}

AddFunction UnholyPrecombatMainPostConditions
{
}

AddFunction UnholyPrecombatShortCdActions
{
	#raise_dead
	Spell(raise_dead)
}

AddFunction UnholyPrecombatShortCdPostConditions
{
}

AddFunction UnholyPrecombatCdActions
{
	#flask,type=greater_draenic_strength_flask
	#food,type=buttered_sturgeon
	#snapshot_stats
	#potion,name=draenic_strength
	UnholyUsePotionStrength()

	unless Spell(raise_dead)
	{
		#army_of_the_dead
		Spell(army_of_the_dead)
	}
}

AddFunction UnholyPrecombatCdPostConditions
{
	Spell(raise_dead)
}

### actions.valkyr

AddFunction UnholyValkyrMainActions
{
	#death_coil
	Spell(death_coil)
	#festering_strike,if=debuff.festering_wound.stack<8&cooldown.apocalypse.remains<5
	if target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 Spell(festering_strike)
	#call_action_list,name=aoe,if=active_enemies>=2
	if Enemies() >= 2 UnholyAoeMainActions()

	unless Enemies() >= 2 and UnholyAoeMainPostConditions()
	{
		#festering_strike,if=debuff.festering_wound.stack<=3
		if target.DebuffStacks(festering_wound_debuff) <= 3 Spell(festering_strike)
		#scourge_strike,if=debuff.festering_wound.up
		if target.DebuffPresent(festering_wound_debuff) Spell(scourge_strike)
		#clawing_shadows,if=debuff.festering_wound.up
		if target.DebuffPresent(festering_wound_debuff) Spell(clawing_shadows)
	}
}

AddFunction UnholyValkyrMainPostConditions
{
	Enemies() >= 2 and UnholyAoeMainPostConditions()
}

AddFunction UnholyValkyrShortCdActions
{
	unless Spell(death_coil)
	{
		#apocalypse,if=debuff.festering_wound.stack=8
		if target.DebuffStacks(festering_wound_debuff) == 8 Spell(apocalypse)

		unless target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike)
		{
			#call_action_list,name=aoe,if=active_enemies>=2
			if Enemies() >= 2 UnholyAoeShortCdActions()
		}
	}
}

AddFunction UnholyValkyrShortCdPostConditions
{
	Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike) or Enemies() >= 2 and UnholyAoeShortCdPostConditions() or target.DebuffStacks(festering_wound_debuff) <= 3 and Spell(festering_strike) or target.DebuffPresent(festering_wound_debuff) and Spell(scourge_strike) or target.DebuffPresent(festering_wound_debuff) and Spell(clawing_shadows)
}

AddFunction UnholyValkyrCdActions
{
	unless Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) == 8 and Spell(apocalypse) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike)
	{
		#call_action_list,name=aoe,if=active_enemies>=2
		if Enemies() >= 2 UnholyAoeCdActions()
	}
}

AddFunction UnholyValkyrCdPostConditions
{
	Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) == 8 and Spell(apocalypse) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike) or Enemies() >= 2 and UnholyAoeCdPostConditions() or target.DebuffStacks(festering_wound_debuff) <= 3 and Spell(festering_strike) or target.DebuffPresent(festering_wound_debuff) and Spell(scourge_strike) or target.DebuffPresent(festering_wound_debuff) and Spell(clawing_shadows)
}

### Unholy icons.

AddCheckBox(opt_deathknight_unholy_aoe L(AOE) default specialization=unholy)

AddIcon checkbox=!opt_deathknight_unholy_aoe enemies=1 help=shortcd specialization=unholy
{
	if not InCombat() UnholyPrecombatShortCdActions()
	unless not InCombat() and UnholyPrecombatShortCdPostConditions()
	{
		UnholyDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=shortcd specialization=unholy
{
	if not InCombat() UnholyPrecombatShortCdActions()
	unless not InCombat() and UnholyPrecombatShortCdPostConditions()
	{
		UnholyDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=unholy
{
	if not InCombat() UnholyPrecombatMainActions()
	unless not InCombat() and UnholyPrecombatMainPostConditions()
	{
		UnholyDefaultMainActions()
	}
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=aoe specialization=unholy
{
	if not InCombat() UnholyPrecombatMainActions()
	unless not InCombat() and UnholyPrecombatMainPostConditions()
	{
		UnholyDefaultMainActions()
	}
}

AddIcon checkbox=!opt_deathknight_unholy_aoe enemies=1 help=cd specialization=unholy
{
	if not InCombat() UnholyPrecombatCdActions()
	unless not InCombat() and UnholyPrecombatCdPostConditions()
	{
		UnholyDefaultCdActions()
	}
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=cd specialization=unholy
{
	if not InCombat() UnholyPrecombatCdActions()
	unless not InCombat() and UnholyPrecombatCdPostConditions()
	{
		UnholyDefaultCdActions()
	}
}

### Required symbols
# apocalypse
# arcane_torrent_runicpower
# army_of_the_dead
# berserking
# blighted_rune_weapon
# blood_fury_ap
# clawing_shadows
# dark_arbiter
# dark_arbiter_talent
# dark_transformation
# dark_transformation_buff
# death_and_decay
# death_and_decay_debuff
# death_coil
# death_strike
# defile
# defile_debuff
# draenic_strength_potion
# epidemic
# festering_strike
# festering_wound_debuff
# legendary_ring_strength
# necrosis_buff
# outbreak
# raise_dead
# scourge_strike
# shadow_infusion_talent
# soul_reaper_unholy
# soul_reaper_unholy_debuff
# sudden_doom_buff
# summon_gargoyle
# unholy_strength_buff
# valkyr_battlemaiden
# virulent_plague_debuff
]]
	OvaleScripts:RegisterScript("DEATHKNIGHT", "unholy", name, desc, code, "script")
end
