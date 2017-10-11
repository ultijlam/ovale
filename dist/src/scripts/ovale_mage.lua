local __addonName, __addon = ...
__addon.require(__addonName, __addon, "./src/scripts\ovale_mage", { "./src/Scripts" }, function(__exports, __Scripts)
do
    local name = "simulationcraft_mage_arcane_t19p"
    local desc = "[7.0] SimulationCraft: Mage_Arcane_T19P"
    local code = [[
# Based on SimulationCraft profile "Mage_Arcane_T19P".
#	class=mage
#	spec=arcane
#	talents=1021012

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_mage_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=arcane)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=arcane)
AddCheckBox(opt_arcane_mage_burn_phase L(arcane_mage_burn_phase) default specialization=arcane)
AddCheckBox(opt_time_warp SpellName(time_warp) specialization=arcane)

AddFunction ArcaneInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
	{
		if target.InRange(counterspell) and target.IsInterruptible() Spell(counterspell)
		if target.Distance(less 8) and target.IsInterruptible() Spell(arcane_torrent_mana)
		if target.InRange(quaking_palm) and not target.Classification(worldboss) Spell(quaking_palm)
	}
}

### actions.default

AddFunction ArcaneDefaultMainActions
{
	#stop_burn_phase,if=prev_gcd.1.evocation&burn_phase_duration>gcd.max
	if PreviousGCDSpell(evocation) and GetStateDuration(burn_phase) > GCD() and GetState(burn_phase) > 0 SetState(burn_phase 0)
	#call_action_list,name=build,if=buff.arcane_charge.stack<4
	if DebuffStacks(arcane_charge_debuff) < 4 ArcaneBuildMainActions()

	unless DebuffStacks(arcane_charge_debuff) < 4 and ArcaneBuildMainPostConditions()
	{
		#call_action_list,name=init_burn,if=buff.arcane_power.down&buff.arcane_charge.stack=4&(cooldown.mark_of_aluneth.remains=0|cooldown.mark_of_aluneth.remains>20)&(!talent.rune_of_power.enabled|(cooldown.arcane_power.remains<=action.rune_of_power.cast_time|action.rune_of_power.recharge_time<cooldown.arcane_power.remains))|target.time_to_die<45
		if { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneInitBurnMainActions()

		unless { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneInitBurnMainPostConditions()
		{
			#call_action_list,name=burn,if=burn_phase
			if GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneBurnMainActions()

			unless GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnMainPostConditions()
			{
				#call_action_list,name=rop_phase,if=buff.rune_of_power.up&!burn_phase
				if BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 ArcaneRopPhaseMainActions()

				unless BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 and ArcaneRopPhaseMainPostConditions()
				{
					#call_action_list,name=conserve
					ArcaneConserveMainActions()
				}
			}
		}
	}
}

AddFunction ArcaneDefaultMainPostConditions
{
	DebuffStacks(arcane_charge_debuff) < 4 and ArcaneBuildMainPostConditions() or { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneInitBurnMainPostConditions() or GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnMainPostConditions() or BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 and ArcaneRopPhaseMainPostConditions() or ArcaneConserveMainPostConditions()
}

AddFunction ArcaneDefaultShortCdActions
{
	#stop_burn_phase,if=prev_gcd.1.evocation&burn_phase_duration>gcd.max
	if PreviousGCDSpell(evocation) and GetStateDuration(burn_phase) > GCD() and GetState(burn_phase) > 0 SetState(burn_phase 0)
	#mark_of_aluneth,if=cooldown.arcane_power.remains>20
	if SpellCooldown(arcane_power) > 20 Spell(mark_of_aluneth)
	#call_action_list,name=build,if=buff.arcane_charge.stack<4
	if DebuffStacks(arcane_charge_debuff) < 4 ArcaneBuildShortCdActions()

	unless DebuffStacks(arcane_charge_debuff) < 4 and ArcaneBuildShortCdPostConditions()
	{
		#call_action_list,name=init_burn,if=buff.arcane_power.down&buff.arcane_charge.stack=4&(cooldown.mark_of_aluneth.remains=0|cooldown.mark_of_aluneth.remains>20)&(!talent.rune_of_power.enabled|(cooldown.arcane_power.remains<=action.rune_of_power.cast_time|action.rune_of_power.recharge_time<cooldown.arcane_power.remains))|target.time_to_die<45
		if { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneInitBurnShortCdActions()

		unless { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneInitBurnShortCdPostConditions()
		{
			#call_action_list,name=burn,if=burn_phase
			if GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneBurnShortCdActions()

			unless GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnShortCdPostConditions()
			{
				#call_action_list,name=rop_phase,if=buff.rune_of_power.up&!burn_phase
				if BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 ArcaneRopPhaseShortCdActions()

				unless BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 and ArcaneRopPhaseShortCdPostConditions()
				{
					#call_action_list,name=conserve
					ArcaneConserveShortCdActions()
				}
			}
		}
	}
}

AddFunction ArcaneDefaultShortCdPostConditions
{
	DebuffStacks(arcane_charge_debuff) < 4 and ArcaneBuildShortCdPostConditions() or { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneInitBurnShortCdPostConditions() or GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnShortCdPostConditions() or BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 and ArcaneRopPhaseShortCdPostConditions() or ArcaneConserveShortCdPostConditions()
}

AddFunction ArcaneDefaultCdActions
{
	#counterspell,if=target.debuff.casting.react
	if target.IsInterruptible() ArcaneInterruptActions()
	#time_warp,if=(buff.bloodlust.down)&((time=0)|(equipped.132410&buff.arcane_power.up&prev_off_gcd.arcane_power)|(target.time_to_die<40))
	if BuffExpires(burst_haste_buff any=1) and { TimeInCombat() == 0 or HasEquippedItem(132410) and BuffPresent(arcane_power_buff) and PreviousOffGCDSpell(arcane_power) or target.TimeToDie() < 40 } and CheckBoxOn(opt_time_warp) and DebuffExpires(burst_haste_debuff any=1) Spell(time_warp)
	#mirror_image,if=buff.arcane_power.down
	if BuffExpires(arcane_power_buff) Spell(mirror_image)
	#stop_burn_phase,if=prev_gcd.1.evocation&burn_phase_duration>gcd.max
	if PreviousGCDSpell(evocation) and GetStateDuration(burn_phase) > GCD() and GetState(burn_phase) > 0 SetState(burn_phase 0)

	unless SpellCooldown(arcane_power) > 20 and Spell(mark_of_aluneth)
	{
		#call_action_list,name=build,if=buff.arcane_charge.stack<4
		if DebuffStacks(arcane_charge_debuff) < 4 ArcaneBuildCdActions()

		unless DebuffStacks(arcane_charge_debuff) < 4 and ArcaneBuildCdPostConditions()
		{
			#call_action_list,name=init_burn,if=buff.arcane_power.down&buff.arcane_charge.stack=4&(cooldown.mark_of_aluneth.remains=0|cooldown.mark_of_aluneth.remains>20)&(!talent.rune_of_power.enabled|(cooldown.arcane_power.remains<=action.rune_of_power.cast_time|action.rune_of_power.recharge_time<cooldown.arcane_power.remains))|target.time_to_die<45
			if { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneInitBurnCdActions()

			unless { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneInitBurnCdPostConditions()
			{
				#call_action_list,name=burn,if=burn_phase
				if GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneBurnCdActions()

				unless GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnCdPostConditions()
				{
					#call_action_list,name=rop_phase,if=buff.rune_of_power.up&!burn_phase
					if BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 ArcaneRopPhaseCdActions()

					unless BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 and ArcaneRopPhaseCdPostConditions()
					{
						#call_action_list,name=conserve
						ArcaneConserveCdActions()
					}
				}
			}
		}
	}
}

AddFunction ArcaneDefaultCdPostConditions
{
	SpellCooldown(arcane_power) > 20 and Spell(mark_of_aluneth) or DebuffStacks(arcane_charge_debuff) < 4 and ArcaneBuildCdPostConditions() or { BuffExpires(arcane_power_buff) and DebuffStacks(arcane_charge_debuff) == 4 and { not SpellCooldown(mark_of_aluneth) > 0 or SpellCooldown(mark_of_aluneth) > 20 } and { not Talent(rune_of_power_talent) or SpellCooldown(arcane_power) <= CastTime(rune_of_power) or SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) } or target.TimeToDie() < 45 } and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneInitBurnCdPostConditions() or GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnCdPostConditions() or BuffPresent(rune_of_power_buff) and not GetState(burn_phase) > 0 and ArcaneRopPhaseCdPostConditions() or ArcaneConserveCdPostConditions()
}

### actions.build

AddFunction ArcaneBuildMainActions
{
	#charged_up,if=buff.arcane_charge.stack<=1
	if DebuffStacks(arcane_charge_debuff) <= 1 Spell(charged_up)
	#arcane_missiles,if=buff.arcane_missiles.react=3
	if BuffStacks(arcane_missiles_buff) == 3 Spell(arcane_missiles)
	#arcane_explosion,if=active_enemies>1
	if Enemies() > 1 Spell(arcane_explosion)
	#arcane_blast
	Spell(arcane_blast)
}

AddFunction ArcaneBuildMainPostConditions
{
}

AddFunction ArcaneBuildShortCdActions
{
	unless DebuffStacks(arcane_charge_debuff) <= 1 and Spell(charged_up) or BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles)
	{
		#arcane_orb
		Spell(arcane_orb)
	}
}

AddFunction ArcaneBuildShortCdPostConditions
{
	DebuffStacks(arcane_charge_debuff) <= 1 and Spell(charged_up) or BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or Enemies() > 1 and Spell(arcane_explosion) or Spell(arcane_blast)
}

AddFunction ArcaneBuildCdActions
{
}

AddFunction ArcaneBuildCdPostConditions
{
	DebuffStacks(arcane_charge_debuff) <= 1 and Spell(charged_up) or BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or Spell(arcane_orb) or Enemies() > 1 and Spell(arcane_explosion) or Spell(arcane_blast)
}

### actions.burn

AddFunction ArcaneBurnMainActions
{
	#call_action_list,name=cooldowns
	ArcaneCooldownsMainActions()

	unless ArcaneCooldownsMainPostConditions()
	{
		#charged_up,if=(equipped.132451&buff.arcane_charge.stack<=1)
		if HasEquippedItem(132451) and DebuffStacks(arcane_charge_debuff) <= 1 Spell(charged_up)
		#arcane_missiles,if=buff.arcane_missiles.react=3
		if BuffStacks(arcane_missiles_buff) == 3 Spell(arcane_missiles)
		#nether_tempest,if=dot.nether_tempest.remains<=2|!ticking
		if target.DebuffRemaining(nether_tempest_debuff) <= 2 or not target.DebuffPresent(nether_tempest_debuff) Spell(nether_tempest)
		#arcane_explosion,if=active_enemies>1&mana.pct%10*execute_time>target.time_to_die
		if Enemies() > 1 and ManaPercent() / 10 * ExecuteTime(arcane_explosion) > target.TimeToDie() Spell(arcane_explosion)
		#arcane_missiles,if=buff.arcane_missiles.react>1
		if BuffStacks(arcane_missiles_buff) > 1 Spell(arcane_missiles)
		#arcane_explosion,if=active_enemies>1&buff.arcane_power.remains>cast_time
		if Enemies() > 1 and BuffRemaining(arcane_power_buff) > CastTime(arcane_explosion) Spell(arcane_explosion)
		#arcane_blast,if=buff.presence_of_mind.up|buff.arcane_power.remains>cast_time
		if BuffPresent(presence_of_mind_buff) or BuffRemaining(arcane_power_buff) > CastTime(arcane_blast) Spell(arcane_blast)
		#supernova,if=mana.pct<100
		if ManaPercent() < 100 Spell(supernova)
		#arcane_missiles,if=mana.pct>10&(talent.overpowered.enabled|buff.arcane_power.down)
		if ManaPercent() > 10 and { Talent(overpowered_talent) or BuffExpires(arcane_power_buff) } Spell(arcane_missiles)
		#arcane_explosion,if=active_enemies>1
		if Enemies() > 1 Spell(arcane_explosion)
		#arcane_barrage,if=talent.charged_up.enabled&(equipped.132451&cooldown.charged_up.remains=0&mana.pct<(100-(buff.arcane_charge.stack*0.03)))
		if Talent(charged_up_talent) and HasEquippedItem(132451) and not SpellCooldown(charged_up) > 0 and ManaPercent() < 100 - DebuffStacks(arcane_charge_debuff) * 0.03 Spell(arcane_barrage)
		#arcane_blast
		Spell(arcane_blast)
	}
}

AddFunction ArcaneBurnMainPostConditions
{
	ArcaneCooldownsMainPostConditions()
}

AddFunction ArcaneBurnShortCdActions
{
	#call_action_list,name=cooldowns
	ArcaneCooldownsShortCdActions()

	unless ArcaneCooldownsShortCdPostConditions() or HasEquippedItem(132451) and DebuffStacks(arcane_charge_debuff) <= 1 and Spell(charged_up) or BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or { target.DebuffRemaining(nether_tempest_debuff) <= 2 or not target.DebuffPresent(nether_tempest_debuff) } and Spell(nether_tempest) or Enemies() > 1 and ManaPercent() / 10 * ExecuteTime(arcane_explosion) > target.TimeToDie() and Spell(arcane_explosion)
	{
		#presence_of_mind,if=buff.rune_of_power.remains<=2*action.arcane_blast.execute_time
		if TotemRemaining(rune_of_power) <= 2 * ExecuteTime(arcane_blast) Spell(presence_of_mind)
	}
}

AddFunction ArcaneBurnShortCdPostConditions
{
	ArcaneCooldownsShortCdPostConditions() or HasEquippedItem(132451) and DebuffStacks(arcane_charge_debuff) <= 1 and Spell(charged_up) or BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or { target.DebuffRemaining(nether_tempest_debuff) <= 2 or not target.DebuffPresent(nether_tempest_debuff) } and Spell(nether_tempest) or Enemies() > 1 and ManaPercent() / 10 * ExecuteTime(arcane_explosion) > target.TimeToDie() and Spell(arcane_explosion) or BuffStacks(arcane_missiles_buff) > 1 and Spell(arcane_missiles) or Enemies() > 1 and BuffRemaining(arcane_power_buff) > CastTime(arcane_explosion) and Spell(arcane_explosion) or { BuffPresent(presence_of_mind_buff) or BuffRemaining(arcane_power_buff) > CastTime(arcane_blast) } and Spell(arcane_blast) or ManaPercent() < 100 and Spell(supernova) or ManaPercent() > 10 and { Talent(overpowered_talent) or BuffExpires(arcane_power_buff) } and Spell(arcane_missiles) or Enemies() > 1 and Spell(arcane_explosion) or Talent(charged_up_talent) and HasEquippedItem(132451) and not SpellCooldown(charged_up) > 0 and ManaPercent() < 100 - DebuffStacks(arcane_charge_debuff) * 0.03 and Spell(arcane_barrage) or Spell(arcane_blast)
}

AddFunction ArcaneBurnCdActions
{
	#call_action_list,name=cooldowns
	ArcaneCooldownsCdActions()

	unless ArcaneCooldownsCdPostConditions() or HasEquippedItem(132451) and DebuffStacks(arcane_charge_debuff) <= 1 and Spell(charged_up) or BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or { target.DebuffRemaining(nether_tempest_debuff) <= 2 or not target.DebuffPresent(nether_tempest_debuff) } and Spell(nether_tempest) or Enemies() > 1 and ManaPercent() / 10 * ExecuteTime(arcane_explosion) > target.TimeToDie() and Spell(arcane_explosion) or BuffStacks(arcane_missiles_buff) > 1 and Spell(arcane_missiles) or Enemies() > 1 and BuffRemaining(arcane_power_buff) > CastTime(arcane_explosion) and Spell(arcane_explosion) or { BuffPresent(presence_of_mind_buff) or BuffRemaining(arcane_power_buff) > CastTime(arcane_blast) } and Spell(arcane_blast) or ManaPercent() < 100 and Spell(supernova) or ManaPercent() > 10 and { Talent(overpowered_talent) or BuffExpires(arcane_power_buff) } and Spell(arcane_missiles) or Enemies() > 1 and Spell(arcane_explosion) or Talent(charged_up_talent) and HasEquippedItem(132451) and not SpellCooldown(charged_up) > 0 and ManaPercent() < 100 - DebuffStacks(arcane_charge_debuff) * 0.03 and Spell(arcane_barrage) or Spell(arcane_blast)
	{
		#evocation,interrupt_if=mana.pct>99
		Spell(evocation)
	}
}

AddFunction ArcaneBurnCdPostConditions
{
	ArcaneCooldownsCdPostConditions() or HasEquippedItem(132451) and DebuffStacks(arcane_charge_debuff) <= 1 and Spell(charged_up) or BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or { target.DebuffRemaining(nether_tempest_debuff) <= 2 or not target.DebuffPresent(nether_tempest_debuff) } and Spell(nether_tempest) or Enemies() > 1 and ManaPercent() / 10 * ExecuteTime(arcane_explosion) > target.TimeToDie() and Spell(arcane_explosion) or BuffStacks(arcane_missiles_buff) > 1 and Spell(arcane_missiles) or Enemies() > 1 and BuffRemaining(arcane_power_buff) > CastTime(arcane_explosion) and Spell(arcane_explosion) or { BuffPresent(presence_of_mind_buff) or BuffRemaining(arcane_power_buff) > CastTime(arcane_blast) } and Spell(arcane_blast) or ManaPercent() < 100 and Spell(supernova) or ManaPercent() > 10 and { Talent(overpowered_talent) or BuffExpires(arcane_power_buff) } and Spell(arcane_missiles) or Enemies() > 1 and Spell(arcane_explosion) or Talent(charged_up_talent) and HasEquippedItem(132451) and not SpellCooldown(charged_up) > 0 and ManaPercent() < 100 - DebuffStacks(arcane_charge_debuff) * 0.03 and Spell(arcane_barrage) or Spell(arcane_blast)
}

### actions.conserve

AddFunction ArcaneConserveMainActions
{
	#arcane_missiles,if=buff.arcane_missiles.react=3
	if BuffStacks(arcane_missiles_buff) == 3 Spell(arcane_missiles)
	#arcane_blast,if=mana.pct>99
	if ManaPercent() > 99 Spell(arcane_blast)
	#nether_tempest,if=(refreshable|!ticking)
	if target.Refreshable(nether_tempest_debuff) or not target.DebuffPresent(nether_tempest_debuff) Spell(nether_tempest)
	#arcane_blast,if=buff.rhonins_assaulting_armwraps.up&equipped.132413
	if BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) Spell(arcane_blast)
	#arcane_missiles
	Spell(arcane_missiles)
	#supernova,if=mana.pct<100
	if ManaPercent() < 100 Spell(supernova)
	#arcane_explosion,if=mana.pct>=82&equipped.132451&active_enemies>1
	if ManaPercent() >= 82 and HasEquippedItem(132451) and Enemies() > 1 Spell(arcane_explosion)
	#arcane_blast,if=mana.pct>=82&equipped.132451
	if ManaPercent() >= 82 and HasEquippedItem(132451) Spell(arcane_blast)
	#arcane_barrage,if=mana.pct<100&cooldown.arcane_power.remains>5
	if ManaPercent() < 100 and SpellCooldown(arcane_power) > 5 Spell(arcane_barrage)
	#arcane_explosion,if=active_enemies>1
	if Enemies() > 1 Spell(arcane_explosion)
	#arcane_blast
	Spell(arcane_blast)
}

AddFunction ArcaneConserveMainPostConditions
{
}

AddFunction ArcaneConserveShortCdActions
{
}

AddFunction ArcaneConserveShortCdPostConditions
{
	BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or ManaPercent() > 99 and Spell(arcane_blast) or { target.Refreshable(nether_tempest_debuff) or not target.DebuffPresent(nether_tempest_debuff) } and Spell(nether_tempest) or BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast) or Spell(arcane_missiles) or ManaPercent() < 100 and Spell(supernova) or ManaPercent() >= 82 and HasEquippedItem(132451) and Enemies() > 1 and Spell(arcane_explosion) or ManaPercent() >= 82 and HasEquippedItem(132451) and Spell(arcane_blast) or ManaPercent() < 100 and SpellCooldown(arcane_power) > 5 and Spell(arcane_barrage) or Enemies() > 1 and Spell(arcane_explosion) or Spell(arcane_blast)
}

AddFunction ArcaneConserveCdActions
{
}

AddFunction ArcaneConserveCdPostConditions
{
	BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or ManaPercent() > 99 and Spell(arcane_blast) or { target.Refreshable(nether_tempest_debuff) or not target.DebuffPresent(nether_tempest_debuff) } and Spell(nether_tempest) or BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast) or Spell(arcane_missiles) or ManaPercent() < 100 and Spell(supernova) or ManaPercent() >= 82 and HasEquippedItem(132451) and Enemies() > 1 and Spell(arcane_explosion) or ManaPercent() >= 82 and HasEquippedItem(132451) and Spell(arcane_blast) or ManaPercent() < 100 and SpellCooldown(arcane_power) > 5 and Spell(arcane_barrage) or Enemies() > 1 and Spell(arcane_explosion) or Spell(arcane_blast)
}

### actions.cooldowns

AddFunction ArcaneCooldownsMainActions
{
}

AddFunction ArcaneCooldownsMainPostConditions
{
}

AddFunction ArcaneCooldownsShortCdActions
{
	#rune_of_power,if=mana.pct>45&buff.arcane_power.down
	if ManaPercent() > 45 and BuffExpires(arcane_power_buff) Spell(rune_of_power)
}

AddFunction ArcaneCooldownsShortCdPostConditions
{
}

AddFunction ArcaneCooldownsCdActions
{
	unless ManaPercent() > 45 and BuffExpires(arcane_power_buff) and Spell(rune_of_power)
	{
		#arcane_power
		Spell(arcane_power)
		#blood_fury
		Spell(blood_fury_sp)
		#berserking
		Spell(berserking)
		#arcane_torrent
		Spell(arcane_torrent_mana)
		#potion,name=deadly_grace,if=buff.arcane_power.up&(buff.berserking.up|buff.blood_fury.up)
		if BuffPresent(arcane_power_buff) and { BuffPresent(berserking_buff) or BuffPresent(blood_fury_sp_buff) } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(deadly_grace_potion usable=1)
	}
}

AddFunction ArcaneCooldownsCdPostConditions
{
	ManaPercent() > 45 and BuffExpires(arcane_power_buff) and Spell(rune_of_power)
}

### actions.init_burn

AddFunction ArcaneInitBurnMainActions
{
	#nether_tempest,if=dot.nether_tempest.remains<10&(prev_gcd.1.mark_of_aluneth|(talent.rune_of_power.enabled&cooldown.rune_of_power.remains<gcd.max))
	if target.DebuffRemaining(nether_tempest_debuff) < 10 and { PreviousGCDSpell(mark_of_aluneth) or Talent(rune_of_power_talent) and SpellCooldown(rune_of_power) < GCD() } Spell(nether_tempest)
	#start_burn_phase,if=((cooldown.evocation.remains-(2*burn_phase_duration))%2<burn_phase_duration)|cooldown.arcane_power.remains=0|target.time_to_die<55
	if { { SpellCooldown(evocation) - 2 * GetStateDuration(burn_phase) } / 2 < GetStateDuration(burn_phase) or not SpellCooldown(arcane_power) > 0 or target.TimeToDie() < 55 } and not GetState(burn_phase) > 0 SetState(burn_phase 1)
}

AddFunction ArcaneInitBurnMainPostConditions
{
}

AddFunction ArcaneInitBurnShortCdActions
{
	#mark_of_aluneth
	Spell(mark_of_aluneth)

	unless target.DebuffRemaining(nether_tempest_debuff) < 10 and { PreviousGCDSpell(mark_of_aluneth) or Talent(rune_of_power_talent) and SpellCooldown(rune_of_power) < GCD() } and Spell(nether_tempest)
	{
		#rune_of_power
		Spell(rune_of_power)
		#start_burn_phase,if=((cooldown.evocation.remains-(2*burn_phase_duration))%2<burn_phase_duration)|cooldown.arcane_power.remains=0|target.time_to_die<55
		if { { SpellCooldown(evocation) - 2 * GetStateDuration(burn_phase) } / 2 < GetStateDuration(burn_phase) or not SpellCooldown(arcane_power) > 0 or target.TimeToDie() < 55 } and not GetState(burn_phase) > 0 SetState(burn_phase 1)
	}
}

AddFunction ArcaneInitBurnShortCdPostConditions
{
	target.DebuffRemaining(nether_tempest_debuff) < 10 and { PreviousGCDSpell(mark_of_aluneth) or Talent(rune_of_power_talent) and SpellCooldown(rune_of_power) < GCD() } and Spell(nether_tempest)
}

AddFunction ArcaneInitBurnCdActions
{
	unless Spell(mark_of_aluneth) or target.DebuffRemaining(nether_tempest_debuff) < 10 and { PreviousGCDSpell(mark_of_aluneth) or Talent(rune_of_power_talent) and SpellCooldown(rune_of_power) < GCD() } and Spell(nether_tempest) or Spell(rune_of_power)
	{
		#start_burn_phase,if=((cooldown.evocation.remains-(2*burn_phase_duration))%2<burn_phase_duration)|cooldown.arcane_power.remains=0|target.time_to_die<55
		if { { SpellCooldown(evocation) - 2 * GetStateDuration(burn_phase) } / 2 < GetStateDuration(burn_phase) or not SpellCooldown(arcane_power) > 0 or target.TimeToDie() < 55 } and not GetState(burn_phase) > 0 SetState(burn_phase 1)
	}
}

AddFunction ArcaneInitBurnCdPostConditions
{
	Spell(mark_of_aluneth) or target.DebuffRemaining(nether_tempest_debuff) < 10 and { PreviousGCDSpell(mark_of_aluneth) or Talent(rune_of_power_talent) and SpellCooldown(rune_of_power) < GCD() } and Spell(nether_tempest) or Spell(rune_of_power)
}

### actions.precombat

AddFunction ArcanePrecombatMainActions
{
	#flask,type=flask_of_the_whispered_pact
	#food,type=the_hungry_magister
	#augmentation,type=defiled
	#summon_arcane_familiar
	Spell(summon_arcane_familiar)
	#arcane_blast
	Spell(arcane_blast)
}

AddFunction ArcanePrecombatMainPostConditions
{
}

AddFunction ArcanePrecombatShortCdActions
{
}

AddFunction ArcanePrecombatShortCdPostConditions
{
	Spell(summon_arcane_familiar) or Spell(arcane_blast)
}

AddFunction ArcanePrecombatCdActions
{
	unless Spell(summon_arcane_familiar)
	{
		#snapshot_stats
		#mirror_image
		Spell(mirror_image)
		#potion,name=deadly_grace
		if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(deadly_grace_potion usable=1)
	}
}

AddFunction ArcanePrecombatCdPostConditions
{
	Spell(summon_arcane_familiar) or Spell(arcane_blast)
}

### actions.rop_phase

AddFunction ArcaneRopPhaseMainActions
{
	#arcane_missiles,if=buff.arcane_missiles.react=3
	if BuffStacks(arcane_missiles_buff) == 3 Spell(arcane_missiles)
	#nether_tempest,if=dot.nether_tempest.remains<=2|!ticking
	if target.DebuffRemaining(nether_tempest_debuff) <= 2 or not target.DebuffPresent(nether_tempest_debuff) Spell(nether_tempest)
	#arcane_missiles,if=buff.arcane_charge.stack=4
	if DebuffStacks(arcane_charge_debuff) == 4 Spell(arcane_missiles)
	#arcane_explosion,if=active_enemies>1
	if Enemies() > 1 Spell(arcane_explosion)
	#arcane_blast,if=mana.pct>45
	if ManaPercent() > 45 Spell(arcane_blast)
	#arcane_barrage
	Spell(arcane_barrage)
}

AddFunction ArcaneRopPhaseMainPostConditions
{
}

AddFunction ArcaneRopPhaseShortCdActions
{
}

AddFunction ArcaneRopPhaseShortCdPostConditions
{
	BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or { target.DebuffRemaining(nether_tempest_debuff) <= 2 or not target.DebuffPresent(nether_tempest_debuff) } and Spell(nether_tempest) or DebuffStacks(arcane_charge_debuff) == 4 and Spell(arcane_missiles) or Enemies() > 1 and Spell(arcane_explosion) or ManaPercent() > 45 and Spell(arcane_blast) or Spell(arcane_barrage)
}

AddFunction ArcaneRopPhaseCdActions
{
}

AddFunction ArcaneRopPhaseCdPostConditions
{
	BuffStacks(arcane_missiles_buff) == 3 and Spell(arcane_missiles) or { target.DebuffRemaining(nether_tempest_debuff) <= 2 or not target.DebuffPresent(nether_tempest_debuff) } and Spell(nether_tempest) or DebuffStacks(arcane_charge_debuff) == 4 and Spell(arcane_missiles) or Enemies() > 1 and Spell(arcane_explosion) or ManaPercent() > 45 and Spell(arcane_blast) or Spell(arcane_barrage)
}

### Arcane icons.

AddCheckBox(opt_mage_arcane_aoe L(AOE) default specialization=arcane)

AddIcon checkbox=!opt_mage_arcane_aoe enemies=1 help=shortcd specialization=arcane
{
	if not InCombat() ArcanePrecombatShortCdActions()
	unless not InCombat() and ArcanePrecombatShortCdPostConditions()
	{
		ArcaneDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_mage_arcane_aoe help=shortcd specialization=arcane
{
	if not InCombat() ArcanePrecombatShortCdActions()
	unless not InCombat() and ArcanePrecombatShortCdPostConditions()
	{
		ArcaneDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=arcane
{
	if not InCombat() ArcanePrecombatMainActions()
	unless not InCombat() and ArcanePrecombatMainPostConditions()
	{
		ArcaneDefaultMainActions()
	}
}

AddIcon checkbox=opt_mage_arcane_aoe help=aoe specialization=arcane
{
	if not InCombat() ArcanePrecombatMainActions()
	unless not InCombat() and ArcanePrecombatMainPostConditions()
	{
		ArcaneDefaultMainActions()
	}
}

AddIcon checkbox=!opt_mage_arcane_aoe enemies=1 help=cd specialization=arcane
{
	if not InCombat() ArcanePrecombatCdActions()
	unless not InCombat() and ArcanePrecombatCdPostConditions()
	{
		ArcaneDefaultCdActions()
	}
}

AddIcon checkbox=opt_mage_arcane_aoe help=cd specialization=arcane
{
	if not InCombat() ArcanePrecombatCdActions()
	unless not InCombat() and ArcanePrecombatCdPostConditions()
	{
		ArcaneDefaultCdActions()
	}
}

### Required symbols
# 132410
# 132413
# 132451
# arcane_barrage
# arcane_blast
# arcane_charge_debuff
# arcane_explosion
# arcane_missiles
# arcane_missiles_buff
# arcane_orb
# arcane_power
# arcane_power_buff
# arcane_torrent_mana
# berserking
# berserking_buff
# blood_fury_sp
# blood_fury_sp_buff
# charged_up
# charged_up_talent
# counterspell
# deadly_grace_potion
# evocation
# mark_of_aluneth
# mirror_image
# nether_tempest
# nether_tempest_debuff
# overpowered_talent
# presence_of_mind
# presence_of_mind_buff
# quaking_palm
# rhonins_assaulting_armwraps_buff
# rune_of_power
# rune_of_power_buff
# rune_of_power_talent
# summon_arcane_familiar
# supernova
# time_warp
]]
    __Scripts.OvaleScripts:RegisterScript("MAGE", "arcane", name, desc, code, "script")
end
do
    local name = "simulationcraft_mage_fire_t19p"
    local desc = "[7.0] SimulationCraft: Mage_Fire_T19P"
    local code = [[
# Based on SimulationCraft profile "Mage_Fire_T19P".
#	class=mage
#	spec=fire
#	talents=1022021

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_mage_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=fire)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=fire)
AddCheckBox(opt_time_warp SpellName(time_warp) specialization=fire)

AddFunction FireInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
	{
		if target.InRange(counterspell) and target.IsInterruptible() Spell(counterspell)
		if target.Distance(less 8) and target.IsInterruptible() Spell(arcane_torrent_mana)
		if target.InRange(quaking_palm) and not target.Classification(worldboss) Spell(quaking_palm)
	}
}

### actions.default

AddFunction FireDefaultMainActions
{
	#call_action_list,name=combustion_phase,if=cooldown.combustion.remains<=action.rune_of_power.cast_time+(!talent.kindling.enabled*gcd)|buff.combustion.up
	if SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) FireCombustionPhaseMainActions()

	unless { SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) } and FireCombustionPhaseMainPostConditions()
	{
		#call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
		if BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) FireRopPhaseMainActions()

		unless BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) and FireRopPhaseMainPostConditions()
		{
			#call_action_list,name=standard_rotation
			FireStandardRotationMainActions()
		}
	}
}

AddFunction FireDefaultMainPostConditions
{
	{ SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) } and FireCombustionPhaseMainPostConditions() or BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) and FireRopPhaseMainPostConditions() or FireStandardRotationMainPostConditions()
}

AddFunction FireDefaultShortCdActions
{
	#rune_of_power,if=cooldown.combustion.remains>40&buff.combustion.down&!talent.kindling.enabled|target.time_to_die.remains<11|talent.kindling.enabled&(charges_fractional>1.8|time<40)&cooldown.combustion.remains>40
	if SpellCooldown(combustion) > 40 and BuffExpires(combustion_buff) and not Talent(kindling_talent) or target.TimeToDie() < 11 or Talent(kindling_talent) and { Charges(rune_of_power count=0) > 1.8 or TimeInCombat() < 40 } and SpellCooldown(combustion) > 40 Spell(rune_of_power)
	#call_action_list,name=combustion_phase,if=cooldown.combustion.remains<=action.rune_of_power.cast_time+(!talent.kindling.enabled*gcd)|buff.combustion.up
	if SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) FireCombustionPhaseShortCdActions()

	unless { SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) } and FireCombustionPhaseShortCdPostConditions()
	{
		#call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
		if BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) FireRopPhaseShortCdActions()

		unless BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) and FireRopPhaseShortCdPostConditions()
		{
			#call_action_list,name=standard_rotation
			FireStandardRotationShortCdActions()
		}
	}
}

AddFunction FireDefaultShortCdPostConditions
{
	{ SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) } and FireCombustionPhaseShortCdPostConditions() or BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) and FireRopPhaseShortCdPostConditions() or FireStandardRotationShortCdPostConditions()
}

AddFunction FireDefaultCdActions
{
	#counterspell,if=target.debuff.casting.react
	if target.IsInterruptible() FireInterruptActions()
	#time_warp,if=(time=0&buff.bloodlust.down)|(buff.bloodlust.down&equipped.132410&(cooldown.combustion.remains<1|target.time_to_die.remains<50))
	if { TimeInCombat() == 0 and BuffExpires(burst_haste_buff any=1) or BuffExpires(burst_haste_buff any=1) and HasEquippedItem(132410) and { SpellCooldown(combustion) < 1 or target.TimeToDie() < 50 } } and CheckBoxOn(opt_time_warp) and DebuffExpires(burst_haste_debuff any=1) Spell(time_warp)
	#mirror_image,if=buff.combustion.down
	if BuffExpires(combustion_buff) Spell(mirror_image)

	unless { SpellCooldown(combustion) > 40 and BuffExpires(combustion_buff) and not Talent(kindling_talent) or target.TimeToDie() < 11 or Talent(kindling_talent) and { Charges(rune_of_power count=0) > 1.8 or TimeInCombat() < 40 } and SpellCooldown(combustion) > 40 } and Spell(rune_of_power)
	{
		#call_action_list,name=combustion_phase,if=cooldown.combustion.remains<=action.rune_of_power.cast_time+(!talent.kindling.enabled*gcd)|buff.combustion.up
		if SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) FireCombustionPhaseCdActions()

		unless { SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) } and FireCombustionPhaseCdPostConditions()
		{
			#call_action_list,name=rop_phase,if=buff.rune_of_power.up&buff.combustion.down
			if BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) FireRopPhaseCdActions()

			unless BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) and FireRopPhaseCdPostConditions()
			{
				#call_action_list,name=standard_rotation
				FireStandardRotationCdActions()
			}
		}
	}
}

AddFunction FireDefaultCdPostConditions
{
	{ SpellCooldown(combustion) > 40 and BuffExpires(combustion_buff) and not Talent(kindling_talent) or target.TimeToDie() < 11 or Talent(kindling_talent) and { Charges(rune_of_power count=0) > 1.8 or TimeInCombat() < 40 } and SpellCooldown(combustion) > 40 } and Spell(rune_of_power) or { SpellCooldown(combustion) <= CastTime(rune_of_power) + Talent(kindling_talent no) * GCD() or BuffPresent(combustion_buff) } and FireCombustionPhaseCdPostConditions() or BuffPresent(rune_of_power_buff) and BuffExpires(combustion_buff) and FireRopPhaseCdPostConditions() or FireStandardRotationCdPostConditions()
}

### actions.active_talents

AddFunction FireActiveTalentsMainActions
{
	#blast_wave,if=(buff.combustion.down)|(buff.combustion.up&action.fire_blast.charges<1&action.phoenixs_flames.charges<1)
	if BuffExpires(combustion_buff) or BuffPresent(combustion_buff) and Charges(fire_blast) < 1 and Charges(phoenixs_flames) < 1 Spell(blast_wave)
	#cinderstorm,if=cooldown.combustion.remains<cast_time&(buff.rune_of_power.up|!talent.rune_of_power.enabled)|cooldown.combustion.remains>10*spell_haste&!buff.combustion.up
	if SpellCooldown(combustion) < CastTime(cinderstorm) and { BuffPresent(rune_of_power_buff) or not Talent(rune_of_power_talent) } or SpellCooldown(combustion) > 10 * { 100 / { 100 + SpellHaste() } } and not BuffPresent(combustion_buff) Spell(cinderstorm)
	#living_bomb,if=active_enemies>1&buff.combustion.down
	if Enemies() > 1 and BuffExpires(combustion_buff) Spell(living_bomb)
}

AddFunction FireActiveTalentsMainPostConditions
{
}

AddFunction FireActiveTalentsShortCdActions
{
	unless { BuffExpires(combustion_buff) or BuffPresent(combustion_buff) and Charges(fire_blast) < 1 and Charges(phoenixs_flames) < 1 } and Spell(blast_wave)
	{
		#meteor,if=cooldown.combustion.remains>15|(cooldown.combustion.remains>target.time_to_die)|buff.rune_of_power.up
		if SpellCooldown(combustion) > 15 or SpellCooldown(combustion) > target.TimeToDie() or BuffPresent(rune_of_power_buff) Spell(meteor)

		unless { SpellCooldown(combustion) < CastTime(cinderstorm) and { BuffPresent(rune_of_power_buff) or not Talent(rune_of_power_talent) } or SpellCooldown(combustion) > 10 * { 100 / { 100 + SpellHaste() } } and not BuffPresent(combustion_buff) } and Spell(cinderstorm)
		{
			#dragons_breath,if=equipped.132863|(talent.alexstraszas_fury.enabled&buff.hot_streak.down)
			if HasEquippedItem(132863) or Talent(alexstraszas_fury_talent) and BuffExpires(hot_streak_buff) Spell(dragons_breath)
		}
	}
}

AddFunction FireActiveTalentsShortCdPostConditions
{
	{ BuffExpires(combustion_buff) or BuffPresent(combustion_buff) and Charges(fire_blast) < 1 and Charges(phoenixs_flames) < 1 } and Spell(blast_wave) or { SpellCooldown(combustion) < CastTime(cinderstorm) and { BuffPresent(rune_of_power_buff) or not Talent(rune_of_power_talent) } or SpellCooldown(combustion) > 10 * { 100 / { 100 + SpellHaste() } } and not BuffPresent(combustion_buff) } and Spell(cinderstorm) or Enemies() > 1 and BuffExpires(combustion_buff) and Spell(living_bomb)
}

AddFunction FireActiveTalentsCdActions
{
}

AddFunction FireActiveTalentsCdPostConditions
{
	{ BuffExpires(combustion_buff) or BuffPresent(combustion_buff) and Charges(fire_blast) < 1 and Charges(phoenixs_flames) < 1 } and Spell(blast_wave) or { SpellCooldown(combustion) > 15 or SpellCooldown(combustion) > target.TimeToDie() or BuffPresent(rune_of_power_buff) } and Spell(meteor) or { SpellCooldown(combustion) < CastTime(cinderstorm) and { BuffPresent(rune_of_power_buff) or not Talent(rune_of_power_talent) } or SpellCooldown(combustion) > 10 * { 100 / { 100 + SpellHaste() } } and not BuffPresent(combustion_buff) } and Spell(cinderstorm) or { HasEquippedItem(132863) or Talent(alexstraszas_fury_talent) and BuffExpires(hot_streak_buff) } and Spell(dragons_breath) or Enemies() > 1 and BuffExpires(combustion_buff) and Spell(living_bomb)
}

### actions.combustion_phase

AddFunction FireCombustionPhaseMainActions
{
	#call_action_list,name=active_talents
	FireActiveTalentsMainActions()

	unless FireActiveTalentsMainPostConditions()
	{
		#pyroblast,if=buff.kaelthas_ultimate_ability.react&buff.combustion.remains>execute_time
		if BuffPresent(kaelthas_ultimate_ability_buff) and BuffRemaining(combustion_buff) > ExecuteTime(pyroblast) Spell(pyroblast)
		#pyroblast,if=buff.hot_streak.up
		if BuffPresent(hot_streak_buff) Spell(pyroblast)
		#phoenixs_flames
		Spell(phoenixs_flames)
		#scorch,if=buff.combustion.remains>cast_time
		if BuffRemaining(combustion_buff) > CastTime(scorch) Spell(scorch)
		#scorch,if=target.health.pct<=30&equipped.132454
		if target.HealthPercent() <= 30 and HasEquippedItem(132454) Spell(scorch)
	}
}

AddFunction FireCombustionPhaseMainPostConditions
{
	FireActiveTalentsMainPostConditions()
}

AddFunction FireCombustionPhaseShortCdActions
{
	#rune_of_power,if=buff.combustion.down
	if BuffExpires(combustion_buff) Spell(rune_of_power)
	#call_action_list,name=active_talents
	FireActiveTalentsShortCdActions()

	unless FireActiveTalentsShortCdPostConditions() or BuffPresent(kaelthas_ultimate_ability_buff) and BuffRemaining(combustion_buff) > ExecuteTime(pyroblast) and Spell(pyroblast) or BuffPresent(hot_streak_buff) and Spell(pyroblast)
	{
		#fire_blast,if=buff.heating_up.up
		if BuffPresent(heating_up_buff) Spell(fire_blast)

		unless Spell(phoenixs_flames) or BuffRemaining(combustion_buff) > CastTime(scorch) and Spell(scorch)
		{
			#dragons_breath,if=buff.hot_streak.down&action.fire_blast.charges<1&action.phoenixs_flames.charges<1
			if BuffExpires(hot_streak_buff) and Charges(fire_blast) < 1 and Charges(phoenixs_flames) < 1 Spell(dragons_breath)
		}
	}
}

AddFunction FireCombustionPhaseShortCdPostConditions
{
	FireActiveTalentsShortCdPostConditions() or BuffPresent(kaelthas_ultimate_ability_buff) and BuffRemaining(combustion_buff) > ExecuteTime(pyroblast) and Spell(pyroblast) or BuffPresent(hot_streak_buff) and Spell(pyroblast) or Spell(phoenixs_flames) or BuffRemaining(combustion_buff) > CastTime(scorch) and Spell(scorch) or target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(scorch)
}

AddFunction FireCombustionPhaseCdActions
{
	unless BuffExpires(combustion_buff) and Spell(rune_of_power)
	{
		#call_action_list,name=active_talents
		FireActiveTalentsCdActions()

		unless FireActiveTalentsCdPostConditions()
		{
			#combustion
			Spell(combustion)
			#potion,name=deadly_grace
			if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(deadly_grace_potion usable=1)
			#blood_fury
			Spell(blood_fury_sp)
			#berserking
			Spell(berserking)
			#arcane_torrent
			Spell(arcane_torrent_mana)
		}
	}
}

AddFunction FireCombustionPhaseCdPostConditions
{
	BuffExpires(combustion_buff) and Spell(rune_of_power) or FireActiveTalentsCdPostConditions() or BuffPresent(kaelthas_ultimate_ability_buff) and BuffRemaining(combustion_buff) > ExecuteTime(pyroblast) and Spell(pyroblast) or BuffPresent(hot_streak_buff) and Spell(pyroblast) or Spell(phoenixs_flames) or BuffRemaining(combustion_buff) > CastTime(scorch) and Spell(scorch) or BuffExpires(hot_streak_buff) and Charges(fire_blast) < 1 and Charges(phoenixs_flames) < 1 and Spell(dragons_breath) or target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(scorch)
}

### actions.precombat

AddFunction FirePrecombatMainActions
{
	#pyroblast
	Spell(pyroblast)
}

AddFunction FirePrecombatMainPostConditions
{
}

AddFunction FirePrecombatShortCdActions
{
}

AddFunction FirePrecombatShortCdPostConditions
{
	Spell(pyroblast)
}

AddFunction FirePrecombatCdActions
{
	#flask,type=flask_of_the_whispered_pact
	#food,type=the_hungry_magister
	#augmentation,type=defiled
	#snapshot_stats
	#mirror_image
	Spell(mirror_image)
	#potion,name=deadly_grace
	if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(deadly_grace_potion usable=1)
}

AddFunction FirePrecombatCdPostConditions
{
	Spell(pyroblast)
}

### actions.rop_phase

AddFunction FireRopPhaseMainActions
{
	#flamestrike,if=((talent.flame_patch.enabled&active_enemies>1)|(active_enemies>3))&buff.hot_streak.up
	if { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) Spell(flamestrike)
	#pyroblast,if=buff.hot_streak.up
	if BuffPresent(hot_streak_buff) Spell(pyroblast)
	#call_action_list,name=active_talents
	FireActiveTalentsMainActions()

	unless FireActiveTalentsMainPostConditions()
	{
		#pyroblast,if=buff.kaelthas_ultimate_ability.react&execute_time<buff.kaelthas_ultimate_ability.remains
		if BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) Spell(pyroblast)
		#phoenixs_flames,if=!prev_gcd.1.phoenixs_flames
		if not PreviousGCDSpell(phoenixs_flames) Spell(phoenixs_flames)
		#scorch,if=target.health.pct<=30&equipped.132454
		if target.HealthPercent() <= 30 and HasEquippedItem(132454) Spell(scorch)
		#flamestrike,if=(talent.flame_patch.enabled&active_enemies>2)|active_enemies>5
		if Talent(flame_patch_talent) and Enemies() > 2 or Enemies() > 5 Spell(flamestrike)
		#fireball
		Spell(fireball)
	}
}

AddFunction FireRopPhaseMainPostConditions
{
	FireActiveTalentsMainPostConditions()
}

AddFunction FireRopPhaseShortCdActions
{
	#rune_of_power
	Spell(rune_of_power)

	unless { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) and Spell(flamestrike) or BuffPresent(hot_streak_buff) and Spell(pyroblast)
	{
		#call_action_list,name=active_talents
		FireActiveTalentsShortCdActions()

		unless FireActiveTalentsShortCdPostConditions() or BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) and Spell(pyroblast)
		{
			#fire_blast,if=!prev_off_gcd.fire_blast
			if not PreviousOffGCDSpell(fire_blast) Spell(fire_blast)

			unless not PreviousGCDSpell(phoenixs_flames) and Spell(phoenixs_flames) or target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(scorch)
			{
				#dragons_breath,if=active_enemies>2
				if Enemies() > 2 Spell(dragons_breath)
			}
		}
	}
}

AddFunction FireRopPhaseShortCdPostConditions
{
	{ Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) and Spell(flamestrike) or BuffPresent(hot_streak_buff) and Spell(pyroblast) or FireActiveTalentsShortCdPostConditions() or BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) and Spell(pyroblast) or not PreviousGCDSpell(phoenixs_flames) and Spell(phoenixs_flames) or target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(scorch) or { Talent(flame_patch_talent) and Enemies() > 2 or Enemies() > 5 } and Spell(flamestrike) or Spell(fireball)
}

AddFunction FireRopPhaseCdActions
{
	unless Spell(rune_of_power) or { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) and Spell(flamestrike) or BuffPresent(hot_streak_buff) and Spell(pyroblast)
	{
		#call_action_list,name=active_talents
		FireActiveTalentsCdActions()
	}
}

AddFunction FireRopPhaseCdPostConditions
{
	Spell(rune_of_power) or { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) and Spell(flamestrike) or BuffPresent(hot_streak_buff) and Spell(pyroblast) or FireActiveTalentsCdPostConditions() or BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) and Spell(pyroblast) or not PreviousGCDSpell(phoenixs_flames) and Spell(phoenixs_flames) or target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(scorch) or Enemies() > 2 and Spell(dragons_breath) or { Talent(flame_patch_talent) and Enemies() > 2 or Enemies() > 5 } and Spell(flamestrike) or Spell(fireball)
}

### actions.standard_rotation

AddFunction FireStandardRotationMainActions
{
	#flamestrike,if=((talent.flame_patch.enabled&active_enemies>1)|active_enemies>3)&buff.hot_streak.up
	if { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) Spell(flamestrike)
	#pyroblast,if=buff.hot_streak.up&buff.hot_streak.remains<action.fireball.execute_time
	if BuffPresent(hot_streak_buff) and BuffRemaining(hot_streak_buff) < ExecuteTime(fireball) Spell(pyroblast)
	#phoenixs_flames,if=charges_fractional>2.7&active_enemies>2
	if Charges(phoenixs_flames count=0) > 2.7 and Enemies() > 2 Spell(phoenixs_flames)
	#pyroblast,if=buff.hot_streak.up&!prev_gcd.1.pyroblast
	if BuffPresent(hot_streak_buff) and not PreviousGCDSpell(pyroblast) Spell(pyroblast)
	#pyroblast,if=buff.hot_streak.react&target.health.pct<=30&equipped.132454
	if BuffPresent(hot_streak_buff) and target.HealthPercent() <= 30 and HasEquippedItem(132454) Spell(pyroblast)
	#pyroblast,if=buff.kaelthas_ultimate_ability.react&execute_time<buff.kaelthas_ultimate_ability.remains
	if BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) Spell(pyroblast)
	#call_action_list,name=active_talents
	FireActiveTalentsMainActions()

	unless FireActiveTalentsMainPostConditions()
	{
		#phoenixs_flames,if=(buff.combustion.up|buff.rune_of_power.up|buff.incanters_flow.stack>3|talent.mirror_image.enabled)&artifact.phoenix_reborn.enabled&(4-charges_fractional)*13<cooldown.combustion.remains+5|target.time_to_die.remains<10
		if { BuffPresent(combustion_buff) or BuffPresent(rune_of_power_buff) or BuffStacks(incanters_flow_buff) > 3 or Talent(mirror_image_talent) } and HasArtifactTrait(phoenix_reborn) and { 4 - Charges(phoenixs_flames count=0) } * 13 < SpellCooldown(combustion) + 5 or target.TimeToDie() < 10 Spell(phoenixs_flames)
		#phoenixs_flames,if=(buff.combustion.up|buff.rune_of_power.up)&(4-charges_fractional)*30<cooldown.combustion.remains+5
		if { BuffPresent(combustion_buff) or BuffPresent(rune_of_power_buff) } and { 4 - Charges(phoenixs_flames count=0) } * 30 < SpellCooldown(combustion) + 5 Spell(phoenixs_flames)
		#flamestrike,if=(talent.flame_patch.enabled&active_enemies>1)|active_enemies>5
		if Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 5 Spell(flamestrike)
		#scorch,if=target.health.pct<=30&equipped.132454
		if target.HealthPercent() <= 30 and HasEquippedItem(132454) Spell(scorch)
		#fireball
		Spell(fireball)
	}
}

AddFunction FireStandardRotationMainPostConditions
{
	FireActiveTalentsMainPostConditions()
}

AddFunction FireStandardRotationShortCdActions
{
	unless { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) and Spell(flamestrike) or BuffPresent(hot_streak_buff) and BuffRemaining(hot_streak_buff) < ExecuteTime(fireball) and Spell(pyroblast) or Charges(phoenixs_flames count=0) > 2.7 and Enemies() > 2 and Spell(phoenixs_flames) or BuffPresent(hot_streak_buff) and not PreviousGCDSpell(pyroblast) and Spell(pyroblast) or BuffPresent(hot_streak_buff) and target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(pyroblast) or BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) and Spell(pyroblast)
	{
		#call_action_list,name=active_talents
		FireActiveTalentsShortCdActions()

		unless FireActiveTalentsShortCdPostConditions()
		{
			#fire_blast,if=!talent.kindling.enabled&buff.heating_up.up&(!talent.rune_of_power.enabled|charges_fractional>1.4|cooldown.combustion.remains<40)&(3-charges_fractional)*(12*spell_haste)<cooldown.combustion.remains+3|target.time_to_die.remains<4
			if not Talent(kindling_talent) and BuffPresent(heating_up_buff) and { not Talent(rune_of_power_talent) or Charges(fire_blast count=0) > 1.4 or SpellCooldown(combustion) < 40 } and { 3 - Charges(fire_blast count=0) } * 12 * { 100 / { 100 + SpellHaste() } } < SpellCooldown(combustion) + 3 or target.TimeToDie() < 4 Spell(fire_blast)
			#fire_blast,if=talent.kindling.enabled&buff.heating_up.up&(!talent.rune_of_power.enabled|charges_fractional>1.5|cooldown.combustion.remains<40)&(3-charges_fractional)*(18*spell_haste)<cooldown.combustion.remains+3|target.time_to_die.remains<4
			if Talent(kindling_talent) and BuffPresent(heating_up_buff) and { not Talent(rune_of_power_talent) or Charges(fire_blast count=0) > 1.5 or SpellCooldown(combustion) < 40 } and { 3 - Charges(fire_blast count=0) } * 18 * { 100 / { 100 + SpellHaste() } } < SpellCooldown(combustion) + 3 or target.TimeToDie() < 4 Spell(fire_blast)
		}
	}
}

AddFunction FireStandardRotationShortCdPostConditions
{
	{ Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) and Spell(flamestrike) or BuffPresent(hot_streak_buff) and BuffRemaining(hot_streak_buff) < ExecuteTime(fireball) and Spell(pyroblast) or Charges(phoenixs_flames count=0) > 2.7 and Enemies() > 2 and Spell(phoenixs_flames) or BuffPresent(hot_streak_buff) and not PreviousGCDSpell(pyroblast) and Spell(pyroblast) or BuffPresent(hot_streak_buff) and target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(pyroblast) or BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) and Spell(pyroblast) or FireActiveTalentsShortCdPostConditions() or { { BuffPresent(combustion_buff) or BuffPresent(rune_of_power_buff) or BuffStacks(incanters_flow_buff) > 3 or Talent(mirror_image_talent) } and HasArtifactTrait(phoenix_reborn) and { 4 - Charges(phoenixs_flames count=0) } * 13 < SpellCooldown(combustion) + 5 or target.TimeToDie() < 10 } and Spell(phoenixs_flames) or { BuffPresent(combustion_buff) or BuffPresent(rune_of_power_buff) } and { 4 - Charges(phoenixs_flames count=0) } * 30 < SpellCooldown(combustion) + 5 and Spell(phoenixs_flames) or { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 5 } and Spell(flamestrike) or target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(scorch) or Spell(fireball)
}

AddFunction FireStandardRotationCdActions
{
	unless { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) and Spell(flamestrike) or BuffPresent(hot_streak_buff) and BuffRemaining(hot_streak_buff) < ExecuteTime(fireball) and Spell(pyroblast) or Charges(phoenixs_flames count=0) > 2.7 and Enemies() > 2 and Spell(phoenixs_flames) or BuffPresent(hot_streak_buff) and not PreviousGCDSpell(pyroblast) and Spell(pyroblast) or BuffPresent(hot_streak_buff) and target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(pyroblast) or BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) and Spell(pyroblast)
	{
		#call_action_list,name=active_talents
		FireActiveTalentsCdActions()
	}
}

AddFunction FireStandardRotationCdPostConditions
{
	{ Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 3 } and BuffPresent(hot_streak_buff) and Spell(flamestrike) or BuffPresent(hot_streak_buff) and BuffRemaining(hot_streak_buff) < ExecuteTime(fireball) and Spell(pyroblast) or Charges(phoenixs_flames count=0) > 2.7 and Enemies() > 2 and Spell(phoenixs_flames) or BuffPresent(hot_streak_buff) and not PreviousGCDSpell(pyroblast) and Spell(pyroblast) or BuffPresent(hot_streak_buff) and target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(pyroblast) or BuffPresent(kaelthas_ultimate_ability_buff) and ExecuteTime(pyroblast) < BuffRemaining(kaelthas_ultimate_ability_buff) and Spell(pyroblast) or FireActiveTalentsCdPostConditions() or { { BuffPresent(combustion_buff) or BuffPresent(rune_of_power_buff) or BuffStacks(incanters_flow_buff) > 3 or Talent(mirror_image_talent) } and HasArtifactTrait(phoenix_reborn) and { 4 - Charges(phoenixs_flames count=0) } * 13 < SpellCooldown(combustion) + 5 or target.TimeToDie() < 10 } and Spell(phoenixs_flames) or { BuffPresent(combustion_buff) or BuffPresent(rune_of_power_buff) } and { 4 - Charges(phoenixs_flames count=0) } * 30 < SpellCooldown(combustion) + 5 and Spell(phoenixs_flames) or { Talent(flame_patch_talent) and Enemies() > 1 or Enemies() > 5 } and Spell(flamestrike) or target.HealthPercent() <= 30 and HasEquippedItem(132454) and Spell(scorch) or Spell(fireball)
}

### Fire icons.

AddCheckBox(opt_mage_fire_aoe L(AOE) default specialization=fire)

AddIcon checkbox=!opt_mage_fire_aoe enemies=1 help=shortcd specialization=fire
{
	if not InCombat() FirePrecombatShortCdActions()
	unless not InCombat() and FirePrecombatShortCdPostConditions()
	{
		FireDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_mage_fire_aoe help=shortcd specialization=fire
{
	if not InCombat() FirePrecombatShortCdActions()
	unless not InCombat() and FirePrecombatShortCdPostConditions()
	{
		FireDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=fire
{
	if not InCombat() FirePrecombatMainActions()
	unless not InCombat() and FirePrecombatMainPostConditions()
	{
		FireDefaultMainActions()
	}
}

AddIcon checkbox=opt_mage_fire_aoe help=aoe specialization=fire
{
	if not InCombat() FirePrecombatMainActions()
	unless not InCombat() and FirePrecombatMainPostConditions()
	{
		FireDefaultMainActions()
	}
}

AddIcon checkbox=!opt_mage_fire_aoe enemies=1 help=cd specialization=fire
{
	if not InCombat() FirePrecombatCdActions()
	unless not InCombat() and FirePrecombatCdPostConditions()
	{
		FireDefaultCdActions()
	}
}

AddIcon checkbox=opt_mage_fire_aoe help=cd specialization=fire
{
	if not InCombat() FirePrecombatCdActions()
	unless not InCombat() and FirePrecombatCdPostConditions()
	{
		FireDefaultCdActions()
	}
}

### Required symbols
# 132410
# 132454
# 132863
# alexstraszas_fury_talent
# arcane_torrent_mana
# berserking
# blast_wave
# blood_fury_sp
# cinderstorm
# combustion
# combustion_buff
# counterspell
# deadly_grace_potion
# dragons_breath
# fire_blast
# fireball
# flame_patch_talent
# flamestrike
# heating_up_buff
# hot_streak_buff
# incanters_flow_buff
# kaelthas_ultimate_ability_buff
# kindling_talent
# living_bomb
# meteor
# mirror_image
# mirror_image_talent
# phoenix_reborn
# phoenixs_flames
# pyroblast
# quaking_palm
# rune_of_power
# rune_of_power_buff
# rune_of_power_talent
# scorch
# time_warp
]]
    __Scripts.OvaleScripts:RegisterScript("MAGE", "fire", name, desc, code, "script")
end
do
    local name = "simulationcraft_mage_frost_t19p"
    local desc = "[7.0] SimulationCraft: Mage_Frost_T19P"
    local code = [[
# Based on SimulationCraft profile "Mage_Frost_T19P".
#	class=mage
#	spec=frost
#	talents=3122111

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_mage_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=frost)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=frost)
AddCheckBox(opt_time_warp SpellName(time_warp) specialization=frost)

AddFunction FrostInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
	{
		if target.InRange(counterspell) and target.IsInterruptible() Spell(counterspell)
		if target.Distance(less 8) and target.IsInterruptible() Spell(arcane_torrent_mana)
		if target.InRange(quaking_palm) and not target.Classification(worldboss) Spell(quaking_palm)
	}
}

### actions.default

AddFunction FrostDefaultMainActions
{
	#ice_lance,if=buff.fingers_of_frost.react=0&prev_gcd.1.flurry
	if BuffStacks(fingers_of_frost_buff) == 0 and PreviousGCDSpell(flurry) Spell(ice_lance)
	#call_action_list,name=cooldowns
	FrostCooldownsMainActions()

	unless FrostCooldownsMainPostConditions()
	{
		#call_action_list,name=aoe,if=active_enemies>=4
		if Enemies() >= 4 FrostAoeMainActions()

		unless Enemies() >= 4 and FrostAoeMainPostConditions()
		{
			#call_action_list,name=single
			FrostSingleMainActions()
		}
	}
}

AddFunction FrostDefaultMainPostConditions
{
	FrostCooldownsMainPostConditions() or Enemies() >= 4 and FrostAoeMainPostConditions() or FrostSingleMainPostConditions()
}

AddFunction FrostDefaultShortCdActions
{
	unless BuffStacks(fingers_of_frost_buff) == 0 and PreviousGCDSpell(flurry) and Spell(ice_lance)
	{
		#call_action_list,name=cooldowns
		FrostCooldownsShortCdActions()

		unless FrostCooldownsShortCdPostConditions()
		{
			#call_action_list,name=aoe,if=active_enemies>=4
			if Enemies() >= 4 FrostAoeShortCdActions()

			unless Enemies() >= 4 and FrostAoeShortCdPostConditions()
			{
				#call_action_list,name=single
				FrostSingleShortCdActions()
			}
		}
	}
}

AddFunction FrostDefaultShortCdPostConditions
{
	BuffStacks(fingers_of_frost_buff) == 0 and PreviousGCDSpell(flurry) and Spell(ice_lance) or FrostCooldownsShortCdPostConditions() or Enemies() >= 4 and FrostAoeShortCdPostConditions() or FrostSingleShortCdPostConditions()
}

AddFunction FrostDefaultCdActions
{
	#counterspell,if=target.debuff.casting.react
	if target.IsInterruptible() FrostInterruptActions()

	unless BuffStacks(fingers_of_frost_buff) == 0 and PreviousGCDSpell(flurry) and Spell(ice_lance)
	{
		#time_warp,if=(time=0&buff.bloodlust.down)|(buff.bloodlust.down&equipped.132410&(cooldown.icy_veins.remains<1|target.time_to_die<50))
		if { TimeInCombat() == 0 and BuffExpires(burst_haste_buff any=1) or BuffExpires(burst_haste_buff any=1) and HasEquippedItem(132410) and { SpellCooldown(icy_veins) < 1 or target.TimeToDie() < 50 } } and CheckBoxOn(opt_time_warp) and DebuffExpires(burst_haste_debuff any=1) Spell(time_warp)
		#call_action_list,name=cooldowns
		FrostCooldownsCdActions()

		unless FrostCooldownsCdPostConditions()
		{
			#call_action_list,name=aoe,if=active_enemies>=4
			if Enemies() >= 4 FrostAoeCdActions()

			unless Enemies() >= 4 and FrostAoeCdPostConditions()
			{
				#call_action_list,name=single
				FrostSingleCdActions()
			}
		}
	}
}

AddFunction FrostDefaultCdPostConditions
{
	BuffStacks(fingers_of_frost_buff) == 0 and PreviousGCDSpell(flurry) and Spell(ice_lance) or FrostCooldownsCdPostConditions() or Enemies() >= 4 and FrostAoeCdPostConditions() or FrostSingleCdPostConditions()
}

### actions.aoe

AddFunction FrostAoeMainActions
{
	#frostbolt,if=prev_off_gcd.water_jet
	if PreviousOffGCDSpell(water_elemental_water_jet) Spell(frostbolt)
	#blizzard
	Spell(blizzard)
	#ice_nova
	Spell(ice_nova)
	#flurry,if=prev_gcd.1.ebonbolt|prev_gcd.1.frostbolt&buff.brain_freeze.react
	if PreviousGCDSpell(ebonbolt) or PreviousGCDSpell(frostbolt) and BuffPresent(brain_freeze_buff) Spell(flurry)
	#ice_lance,if=buff.fingers_of_frost.react>0
	if BuffStacks(fingers_of_frost_buff) > 0 Spell(ice_lance)
	#ebonbolt,if=buff.brain_freeze.react=0
	if BuffStacks(brain_freeze_buff) == 0 Spell(ebonbolt)
	#glacial_spike
	Spell(glacial_spike)
	#frostbolt
	Spell(frostbolt)
}

AddFunction FrostAoeMainPostConditions
{
}

AddFunction FrostAoeShortCdActions
{
	unless PreviousOffGCDSpell(water_elemental_water_jet) and Spell(frostbolt) or Spell(blizzard)
	{
		#frozen_orb
		Spell(frozen_orb)
		#comet_storm
		Spell(comet_storm)

		unless Spell(ice_nova)
		{
			#water_jet,if=prev_gcd.1.frostbolt&buff.fingers_of_frost.stack<(2+artifact.icy_hand.enabled)&buff.brain_freeze.react=0
			if PreviousGCDSpell(frostbolt) and BuffStacks(fingers_of_frost_buff) < 2 + HasArtifactTrait(icy_hand) and BuffStacks(brain_freeze_buff) == 0 Spell(water_elemental_water_jet)

			unless { PreviousGCDSpell(ebonbolt) or PreviousGCDSpell(frostbolt) and BuffPresent(brain_freeze_buff) } and Spell(flurry)
			{
				#frost_bomb,if=debuff.frost_bomb.remains<action.ice_lance.travel_time&buff.fingers_of_frost.react>0
				if target.DebuffRemaining(frost_bomb_debuff) < TravelTime(ice_lance) and BuffStacks(fingers_of_frost_buff) > 0 Spell(frost_bomb)
			}
		}
	}
}

AddFunction FrostAoeShortCdPostConditions
{
	PreviousOffGCDSpell(water_elemental_water_jet) and Spell(frostbolt) or Spell(blizzard) or Spell(ice_nova) or { PreviousGCDSpell(ebonbolt) or PreviousGCDSpell(frostbolt) and BuffPresent(brain_freeze_buff) } and Spell(flurry) or BuffStacks(fingers_of_frost_buff) > 0 and Spell(ice_lance) or BuffStacks(brain_freeze_buff) == 0 and Spell(ebonbolt) or Spell(glacial_spike) or Spell(frostbolt)
}

AddFunction FrostAoeCdActions
{
}

AddFunction FrostAoeCdPostConditions
{
	PreviousOffGCDSpell(water_elemental_water_jet) and Spell(frostbolt) or Spell(blizzard) or Spell(frozen_orb) or Spell(comet_storm) or Spell(ice_nova) or { PreviousGCDSpell(ebonbolt) or PreviousGCDSpell(frostbolt) and BuffPresent(brain_freeze_buff) } and Spell(flurry) or target.DebuffRemaining(frost_bomb_debuff) < TravelTime(ice_lance) and BuffStacks(fingers_of_frost_buff) > 0 and Spell(frost_bomb) or BuffStacks(fingers_of_frost_buff) > 0 and Spell(ice_lance) or BuffStacks(brain_freeze_buff) == 0 and Spell(ebonbolt) or Spell(glacial_spike) or Spell(frostbolt)
}

### actions.cooldowns

AddFunction FrostCooldownsMainActions
{
}

AddFunction FrostCooldownsMainPostConditions
{
}

AddFunction FrostCooldownsShortCdActions
{
	#rune_of_power,if=cooldown.icy_veins.remains<cast_time|charges_fractional>1.9&cooldown.icy_veins.remains>10|buff.icy_veins.up|target.time_to_die.remains+5<charges_fractional*10
	if SpellCooldown(icy_veins) < CastTime(rune_of_power) or Charges(rune_of_power count=0) > 1.9 and SpellCooldown(icy_veins) > 10 or BuffPresent(icy_veins_buff) or target.TimeToDie() + 5 < Charges(rune_of_power count=0) * 10 Spell(rune_of_power)
}

AddFunction FrostCooldownsShortCdPostConditions
{
}

AddFunction FrostCooldownsCdActions
{
	unless { SpellCooldown(icy_veins) < CastTime(rune_of_power) or Charges(rune_of_power count=0) > 1.9 and SpellCooldown(icy_veins) > 10 or BuffPresent(icy_veins_buff) or target.TimeToDie() + 5 < Charges(rune_of_power count=0) * 10 } and Spell(rune_of_power)
	{
		#potion,name=prolonged_power,if=cooldown.icy_veins.remains<1
		if SpellCooldown(icy_veins) < 1 and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
		#icy_veins,if=buff.icy_veins.down
		if BuffExpires(icy_veins_buff) Spell(icy_veins)
		#mirror_image
		Spell(mirror_image)
		#blood_fury
		Spell(blood_fury_sp)
		#berserking
		Spell(berserking)
		#arcane_torrent
		Spell(arcane_torrent_mana)
	}
}

AddFunction FrostCooldownsCdPostConditions
{
	{ SpellCooldown(icy_veins) < CastTime(rune_of_power) or Charges(rune_of_power count=0) > 1.9 and SpellCooldown(icy_veins) > 10 or BuffPresent(icy_veins_buff) or target.TimeToDie() + 5 < Charges(rune_of_power count=0) * 10 } and Spell(rune_of_power)
}

### actions.precombat

AddFunction FrostPrecombatMainActions
{
	#frostbolt
	Spell(frostbolt)
}

AddFunction FrostPrecombatMainPostConditions
{
}

AddFunction FrostPrecombatShortCdActions
{
	#flask,type=flask_of_the_whispered_pact
	#food,type=azshari_salad
	#augmentation,type=defiled
	#water_elemental
	if not pet.Present() Spell(water_elemental)
}

AddFunction FrostPrecombatShortCdPostConditions
{
	Spell(frostbolt)
}

AddFunction FrostPrecombatCdActions
{
	unless not pet.Present() and Spell(water_elemental)
	{
		#snapshot_stats
		#mirror_image
		Spell(mirror_image)
		#potion,name=prolonged_power
		if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
	}
}

AddFunction FrostPrecombatCdPostConditions
{
	not pet.Present() and Spell(water_elemental) or Spell(frostbolt)
}

### actions.single

AddFunction FrostSingleMainActions
{
	#ice_nova,if=debuff.winters_chill.up
	if target.DebuffPresent(winters_chill_debuff) Spell(ice_nova)
	#frostbolt,if=prev_off_gcd.water_jet
	if PreviousOffGCDSpell(water_elemental_water_jet) Spell(frostbolt)
	#ray_of_frost,if=buff.icy_veins.up|(cooldown.icy_veins.remains>action.ray_of_frost.cooldown&buff.rune_of_power.down)
	if BuffPresent(icy_veins_buff) or SpellCooldown(icy_veins) > SpellCooldown(ray_of_frost) and BuffExpires(rune_of_power_buff) Spell(ray_of_frost)
	#flurry,if=prev_gcd.1.ebonbolt|prev_gcd.1.frostbolt&buff.brain_freeze.react
	if PreviousGCDSpell(ebonbolt) or PreviousGCDSpell(frostbolt) and BuffPresent(brain_freeze_buff) Spell(flurry)
	#ice_lance,if=buff.fingers_of_frost.react>0&cooldown.icy_veins.remains>10|buff.fingers_of_frost.react>2
	if BuffStacks(fingers_of_frost_buff) > 0 and SpellCooldown(icy_veins) > 10 or BuffStacks(fingers_of_frost_buff) > 2 Spell(ice_lance)
	#ice_nova
	Spell(ice_nova)
	#blizzard,if=active_enemies>2|active_enemies>1&!(talent.glacial_spike.enabled&talent.splitting_ice.enabled)|(buff.zannesu_journey.stack=5&buff.zannesu_journey.remains>cast_time)
	if Enemies() > 2 or Enemies() > 1 and not { Talent(glacial_spike_talent) and Talent(splitting_ice_talent) } or BuffStacks(zannesu_journey_buff) == 5 and BuffRemaining(zannesu_journey_buff) > CastTime(blizzard) Spell(blizzard)
	#ebonbolt,if=buff.brain_freeze.react=0
	if BuffStacks(brain_freeze_buff) == 0 Spell(ebonbolt)
	#glacial_spike
	Spell(glacial_spike)
	#frostbolt
	Spell(frostbolt)
}

AddFunction FrostSingleMainPostConditions
{
}

AddFunction FrostSingleShortCdActions
{
	unless target.DebuffPresent(winters_chill_debuff) and Spell(ice_nova) or PreviousOffGCDSpell(water_elemental_water_jet) and Spell(frostbolt)
	{
		#water_jet,if=prev_gcd.1.frostbolt&buff.fingers_of_frost.stack<(2+artifact.icy_hand.enabled)&buff.brain_freeze.react=0
		if PreviousGCDSpell(frostbolt) and BuffStacks(fingers_of_frost_buff) < 2 + HasArtifactTrait(icy_hand) and BuffStacks(brain_freeze_buff) == 0 Spell(water_elemental_water_jet)

		unless { BuffPresent(icy_veins_buff) or SpellCooldown(icy_veins) > SpellCooldown(ray_of_frost) and BuffExpires(rune_of_power_buff) } and Spell(ray_of_frost) or { PreviousGCDSpell(ebonbolt) or PreviousGCDSpell(frostbolt) and BuffPresent(brain_freeze_buff) } and Spell(flurry)
		{
			#frost_bomb,if=debuff.frost_bomb.remains<action.ice_lance.travel_time&buff.fingers_of_frost.react>0
			if target.DebuffRemaining(frost_bomb_debuff) < TravelTime(ice_lance) and BuffStacks(fingers_of_frost_buff) > 0 Spell(frost_bomb)

			unless { BuffStacks(fingers_of_frost_buff) > 0 and SpellCooldown(icy_veins) > 10 or BuffStacks(fingers_of_frost_buff) > 2 } and Spell(ice_lance)
			{
				#frozen_orb
				Spell(frozen_orb)

				unless Spell(ice_nova)
				{
					#comet_storm
					Spell(comet_storm)
				}
			}
		}
	}
}

AddFunction FrostSingleShortCdPostConditions
{
	target.DebuffPresent(winters_chill_debuff) and Spell(ice_nova) or PreviousOffGCDSpell(water_elemental_water_jet) and Spell(frostbolt) or { BuffPresent(icy_veins_buff) or SpellCooldown(icy_veins) > SpellCooldown(ray_of_frost) and BuffExpires(rune_of_power_buff) } and Spell(ray_of_frost) or { PreviousGCDSpell(ebonbolt) or PreviousGCDSpell(frostbolt) and BuffPresent(brain_freeze_buff) } and Spell(flurry) or { BuffStacks(fingers_of_frost_buff) > 0 and SpellCooldown(icy_veins) > 10 or BuffStacks(fingers_of_frost_buff) > 2 } and Spell(ice_lance) or Spell(ice_nova) or { Enemies() > 2 or Enemies() > 1 and not { Talent(glacial_spike_talent) and Talent(splitting_ice_talent) } or BuffStacks(zannesu_journey_buff) == 5 and BuffRemaining(zannesu_journey_buff) > CastTime(blizzard) } and Spell(blizzard) or BuffStacks(brain_freeze_buff) == 0 and Spell(ebonbolt) or Spell(glacial_spike) or Spell(frostbolt)
}

AddFunction FrostSingleCdActions
{
}

AddFunction FrostSingleCdPostConditions
{
	target.DebuffPresent(winters_chill_debuff) and Spell(ice_nova) or PreviousOffGCDSpell(water_elemental_water_jet) and Spell(frostbolt) or { BuffPresent(icy_veins_buff) or SpellCooldown(icy_veins) > SpellCooldown(ray_of_frost) and BuffExpires(rune_of_power_buff) } and Spell(ray_of_frost) or { PreviousGCDSpell(ebonbolt) or PreviousGCDSpell(frostbolt) and BuffPresent(brain_freeze_buff) } and Spell(flurry) or target.DebuffRemaining(frost_bomb_debuff) < TravelTime(ice_lance) and BuffStacks(fingers_of_frost_buff) > 0 and Spell(frost_bomb) or { BuffStacks(fingers_of_frost_buff) > 0 and SpellCooldown(icy_veins) > 10 or BuffStacks(fingers_of_frost_buff) > 2 } and Spell(ice_lance) or Spell(frozen_orb) or Spell(ice_nova) or Spell(comet_storm) or { Enemies() > 2 or Enemies() > 1 and not { Talent(glacial_spike_talent) and Talent(splitting_ice_talent) } or BuffStacks(zannesu_journey_buff) == 5 and BuffRemaining(zannesu_journey_buff) > CastTime(blizzard) } and Spell(blizzard) or BuffStacks(brain_freeze_buff) == 0 and Spell(ebonbolt) or Spell(glacial_spike) or Spell(frostbolt)
}

### Frost icons.

AddCheckBox(opt_mage_frost_aoe L(AOE) default specialization=frost)

AddIcon checkbox=!opt_mage_frost_aoe enemies=1 help=shortcd specialization=frost
{
	if not InCombat() FrostPrecombatShortCdActions()
	unless not InCombat() and FrostPrecombatShortCdPostConditions()
	{
		FrostDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_mage_frost_aoe help=shortcd specialization=frost
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

AddIcon checkbox=opt_mage_frost_aoe help=aoe specialization=frost
{
	if not InCombat() FrostPrecombatMainActions()
	unless not InCombat() and FrostPrecombatMainPostConditions()
	{
		FrostDefaultMainActions()
	}
}

AddIcon checkbox=!opt_mage_frost_aoe enemies=1 help=cd specialization=frost
{
	if not InCombat() FrostPrecombatCdActions()
	unless not InCombat() and FrostPrecombatCdPostConditions()
	{
		FrostDefaultCdActions()
	}
}

AddIcon checkbox=opt_mage_frost_aoe help=cd specialization=frost
{
	if not InCombat() FrostPrecombatCdActions()
	unless not InCombat() and FrostPrecombatCdPostConditions()
	{
		FrostDefaultCdActions()
	}
}

### Required symbols
# 132410
# arcane_torrent_mana
# berserking
# blizzard
# blood_fury_sp
# brain_freeze_buff
# comet_storm
# counterspell
# ebonbolt
# fingers_of_frost_buff
# flurry
# frost_bomb
# frost_bomb_debuff
# frostbolt
# frozen_orb
# glacial_spike
# glacial_spike_talent
# ice_lance
# ice_nova
# icy_hand
# icy_veins
# icy_veins_buff
# mirror_image
# prolonged_power_potion
# quaking_palm
# ray_of_frost
# rune_of_power
# rune_of_power_buff
# splitting_ice_talent
# time_warp
# water_elemental
# water_elemental_water_jet
# winters_chill_debuff
# zannesu_journey_buff
]]
    __Scripts.OvaleScripts:RegisterScript("MAGE", "frost", name, desc, code, "script")
end
do
    local name = "simulationcraft_mage_ntspamarcane_t19p"
    local desc = "[7.0] SimulationCraft: Mage_NTSpamArcane_T19P"
    local code = [[
# Based on SimulationCraft profile "Mage_NTSpamArcane_T19P".
#	class=mage
#	spec=arcane
#	talents=1021012

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_mage_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=arcane)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=arcane)
AddCheckBox(opt_arcane_mage_burn_phase L(arcane_mage_burn_phase) default specialization=arcane)
AddCheckBox(opt_time_warp SpellName(time_warp) specialization=arcane)

AddFunction ArcaneInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
	{
		if target.InRange(counterspell) and target.IsInterruptible() Spell(counterspell)
		if target.Distance(less 8) and target.IsInterruptible() Spell(arcane_torrent_mana)
		if target.InRange(quaking_palm) and not target.Classification(worldboss) Spell(quaking_palm)
	}
}

### actions.default

AddFunction ArcaneDefaultMainActions
{
	#nether_tempest,if=time<1
	if TimeInCombat() < 1 Spell(nether_tempest)
	#shard_of_the_exodar_warp,if=buff.bloodlust.down&burn_phase
	if BuffExpires(burst_haste_buff any=1) and GetState(burn_phase) > 0 Spell(shard_of_the_exodar_warp)
	#stop_burn_phase,if=cooldown.arcane_power.remains>20&buff.arcane_power.down&cooldown.evocation.remains>20&burn_phase_duration>13+action.evocation.execute_time&(time>5|!equipped.132451&mana.pct<50|mana.pct<50&time<100|mana.pct<20)&!(mana%165000*action.arcane_blast.execute_time*2>target.time_to_die.remains-2)
	if SpellCooldown(arcane_power) > 20 and BuffExpires(arcane_power_buff) and SpellCooldown(evocation) > 20 and GetStateDuration(burn_phase) > 13 + ExecuteTime(evocation) and { TimeInCombat() > 5 or not HasEquippedItem(132451) and ManaPercent() < 50 or ManaPercent() < 50 and TimeInCombat() < 100 or ManaPercent() < 20 } and not Mana() / 165000 * ExecuteTime(arcane_blast) * 2 > target.TimeToDie() - 2 and GetState(burn_phase) > 0 SetState(burn_phase 0)
	#call_action_list,name=burn,if=burn_phase
	if GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneBurnMainActions()

	unless GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnMainPostConditions()
	{
		#start_burn_phase,if=buff.arcane_charge.stack=4&time<10
		if DebuffStacks(arcane_charge_debuff) == 4 and TimeInCombat() < 10 and not GetState(burn_phase) > 0 SetState(burn_phase 1)
		#start_burn_phase,if=buff.arcane_charge.stack=4&cooldown.evocation.remains<6
		if DebuffStacks(arcane_charge_debuff) == 4 and SpellCooldown(evocation) < 6 and not GetState(burn_phase) > 0 SetState(burn_phase 1)
		#call_action_list,name=conserve
		ArcaneConserveMainActions()
	}
}

AddFunction ArcaneDefaultMainPostConditions
{
	GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnMainPostConditions() or ArcaneConserveMainPostConditions()
}

AddFunction ArcaneDefaultShortCdActions
{
	unless TimeInCombat() < 1 and Spell(nether_tempest) or BuffExpires(burst_haste_buff any=1) and GetState(burn_phase) > 0 and Spell(shard_of_the_exodar_warp)
	{
		#stop_burn_phase,if=cooldown.arcane_power.remains>20&buff.arcane_power.down&cooldown.evocation.remains>20&burn_phase_duration>13+action.evocation.execute_time&(time>5|!equipped.132451&mana.pct<50|mana.pct<50&time<100|mana.pct<20)&!(mana%165000*action.arcane_blast.execute_time*2>target.time_to_die.remains-2)
		if SpellCooldown(arcane_power) > 20 and BuffExpires(arcane_power_buff) and SpellCooldown(evocation) > 20 and GetStateDuration(burn_phase) > 13 + ExecuteTime(evocation) and { TimeInCombat() > 5 or not HasEquippedItem(132451) and ManaPercent() < 50 or ManaPercent() < 50 and TimeInCombat() < 100 or ManaPercent() < 20 } and not Mana() / 165000 * ExecuteTime(arcane_blast) * 2 > target.TimeToDie() - 2 and GetState(burn_phase) > 0 SetState(burn_phase 0)
		#call_action_list,name=burn,if=burn_phase
		if GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneBurnShortCdActions()

		unless GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnShortCdPostConditions()
		{
			#start_burn_phase,if=buff.arcane_charge.stack=4&time<10
			if DebuffStacks(arcane_charge_debuff) == 4 and TimeInCombat() < 10 and not GetState(burn_phase) > 0 SetState(burn_phase 1)
			#start_burn_phase,if=buff.arcane_charge.stack=4&cooldown.evocation.remains<6
			if DebuffStacks(arcane_charge_debuff) == 4 and SpellCooldown(evocation) < 6 and not GetState(burn_phase) > 0 SetState(burn_phase 1)
			#call_action_list,name=conserve
			ArcaneConserveShortCdActions()
		}
	}
}

AddFunction ArcaneDefaultShortCdPostConditions
{
	TimeInCombat() < 1 and Spell(nether_tempest) or BuffExpires(burst_haste_buff any=1) and GetState(burn_phase) > 0 and Spell(shard_of_the_exodar_warp) or GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnShortCdPostConditions() or ArcaneConserveShortCdPostConditions()
}

AddFunction ArcaneDefaultCdActions
{
	unless TimeInCombat() < 1 and Spell(nether_tempest)
	{
		#counterspell
		ArcaneInterruptActions()
		#time_warp,if=target.health.pct<25|time=0
		if { target.HealthPercent() < 25 or TimeInCombat() == 0 } and CheckBoxOn(opt_time_warp) and DebuffExpires(burst_haste_debuff any=1) Spell(time_warp)

		unless BuffExpires(burst_haste_buff any=1) and GetState(burn_phase) > 0 and Spell(shard_of_the_exodar_warp)
		{
			#stop_burn_phase,if=cooldown.arcane_power.remains>20&buff.arcane_power.down&cooldown.evocation.remains>20&burn_phase_duration>13+action.evocation.execute_time&(time>5|!equipped.132451&mana.pct<50|mana.pct<50&time<100|mana.pct<20)&!(mana%165000*action.arcane_blast.execute_time*2>target.time_to_die.remains-2)
			if SpellCooldown(arcane_power) > 20 and BuffExpires(arcane_power_buff) and SpellCooldown(evocation) > 20 and GetStateDuration(burn_phase) > 13 + ExecuteTime(evocation) and { TimeInCombat() > 5 or not HasEquippedItem(132451) and ManaPercent() < 50 or ManaPercent() < 50 and TimeInCombat() < 100 or ManaPercent() < 20 } and not Mana() / 165000 * ExecuteTime(arcane_blast) * 2 > target.TimeToDie() - 2 and GetState(burn_phase) > 0 SetState(burn_phase 0)
			#call_action_list,name=burn,if=burn_phase
			if GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) ArcaneBurnCdActions()

			unless GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnCdPostConditions()
			{
				#start_burn_phase,if=buff.arcane_charge.stack=4&time<10
				if DebuffStacks(arcane_charge_debuff) == 4 and TimeInCombat() < 10 and not GetState(burn_phase) > 0 SetState(burn_phase 1)
				#start_burn_phase,if=buff.arcane_charge.stack=4&cooldown.evocation.remains<6
				if DebuffStacks(arcane_charge_debuff) == 4 and SpellCooldown(evocation) < 6 and not GetState(burn_phase) > 0 SetState(burn_phase 1)
				#call_action_list,name=conserve
				ArcaneConserveCdActions()
			}
		}
	}
}

AddFunction ArcaneDefaultCdPostConditions
{
	TimeInCombat() < 1 and Spell(nether_tempest) or BuffExpires(burst_haste_buff any=1) and GetState(burn_phase) > 0 and Spell(shard_of_the_exodar_warp) or GetState(burn_phase) > 0 and CheckBoxOn(opt_arcane_mage_burn_phase) and ArcaneBurnCdPostConditions() or ArcaneConserveCdPostConditions()
}

### actions.burn

AddFunction ArcaneBurnMainActions
{
	#arcane_explosion,if=mana<250000&!prev_gcd.arcane_explosion&cooldown.evocation.remains<gcd.max|prev_gcd.evocation|buff.quickening.up&buff.quickening.remains<action.arcane_blast.cast_time&time>20
	if Mana() < 250000 and not PreviousGCDSpell(arcane_explosion) and SpellCooldown(evocation) < GCD() or PreviousGCDSpell(evocation) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < CastTime(arcane_blast) and TimeInCombat() > 20 Spell(arcane_explosion)
	#arcane_blast,if=buff.rhonins_assaulting_armwraps.up&equipped.132413
	if BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) Spell(arcane_blast)
	#call_action_list,name=cooldowns,if=cooldown.evocation.remains|time<50
	if SpellCooldown(evocation) > 0 or TimeInCombat() < 50 ArcaneCooldownsMainActions()

	unless { SpellCooldown(evocation) > 0 or TimeInCombat() < 50 } and ArcaneCooldownsMainPostConditions()
	{
		#nether_tempest,if=mana<300000&cooldown.evocation.remains<10&cooldown.evocation.remains>gcd.max*2&!buff.arcane_missiles.up
		if Mana() < 300000 and SpellCooldown(evocation) < 10 and SpellCooldown(evocation) > GCD() * 2 and not BuffPresent(arcane_missiles_buff) Spell(nether_tempest)
		#arcane_missiles
		Spell(arcane_missiles)
		#arcane_blast
		Spell(arcane_blast)
	}
}

AddFunction ArcaneBurnMainPostConditions
{
	{ SpellCooldown(evocation) > 0 or TimeInCombat() < 50 } and ArcaneCooldownsMainPostConditions()
}

AddFunction ArcaneBurnShortCdActions
{
	unless { Mana() < 250000 and not PreviousGCDSpell(arcane_explosion) and SpellCooldown(evocation) < GCD() or PreviousGCDSpell(evocation) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < CastTime(arcane_blast) and TimeInCombat() > 20 } and Spell(arcane_explosion) or BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast)
	{
		#mark_of_aluneth,if=time<60|cooldown.evocation.remains
		if TimeInCombat() < 60 or SpellCooldown(evocation) > 0 Spell(mark_of_aluneth)
		#call_action_list,name=cooldowns,if=cooldown.evocation.remains|time<50
		if SpellCooldown(evocation) > 0 or TimeInCombat() < 50 ArcaneCooldownsShortCdActions()
	}
}

AddFunction ArcaneBurnShortCdPostConditions
{
	{ Mana() < 250000 and not PreviousGCDSpell(arcane_explosion) and SpellCooldown(evocation) < GCD() or PreviousGCDSpell(evocation) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < CastTime(arcane_blast) and TimeInCombat() > 20 } and Spell(arcane_explosion) or BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast) or { SpellCooldown(evocation) > 0 or TimeInCombat() < 50 } and ArcaneCooldownsShortCdPostConditions() or Mana() < 300000 and SpellCooldown(evocation) < 10 and SpellCooldown(evocation) > GCD() * 2 and not BuffPresent(arcane_missiles_buff) and Spell(nether_tempest) or Spell(arcane_missiles) or Spell(arcane_blast)
}

AddFunction ArcaneBurnCdActions
{
	unless { Mana() < 250000 and not PreviousGCDSpell(arcane_explosion) and SpellCooldown(evocation) < GCD() or PreviousGCDSpell(evocation) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < CastTime(arcane_blast) and TimeInCombat() > 20 } and Spell(arcane_explosion)
	{
		#evocation,if=mana.pct<15&(prev_gcd.arcane_explosion|target.time_to_die.remains<30&cooldown.arcane_power.remains<10&mana.pct<30),interrupt_if=mana.pct>90
		if ManaPercent() < 15 and { PreviousGCDSpell(arcane_explosion) or target.TimeToDie() < 30 and SpellCooldown(arcane_power) < 10 and ManaPercent() < 30 } Spell(evocation)

		unless BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast) or { TimeInCombat() < 60 or SpellCooldown(evocation) > 0 } and Spell(mark_of_aluneth)
		{
			#call_action_list,name=cooldowns,if=cooldown.evocation.remains|time<50
			if SpellCooldown(evocation) > 0 or TimeInCombat() < 50 ArcaneCooldownsCdActions()

			unless { SpellCooldown(evocation) > 0 or TimeInCombat() < 50 } and ArcaneCooldownsCdPostConditions() or Mana() < 300000 and SpellCooldown(evocation) < 10 and SpellCooldown(evocation) > GCD() * 2 and not BuffPresent(arcane_missiles_buff) and Spell(nether_tempest) or Spell(arcane_missiles) or Spell(arcane_blast)
			{
				#evocation,interrupt_if=mana.pct>90
				Spell(evocation)
			}
		}
	}
}

AddFunction ArcaneBurnCdPostConditions
{
	{ Mana() < 250000 and not PreviousGCDSpell(arcane_explosion) and SpellCooldown(evocation) < GCD() or PreviousGCDSpell(evocation) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < CastTime(arcane_blast) and TimeInCombat() > 20 } and Spell(arcane_explosion) or BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast) or { TimeInCombat() < 60 or SpellCooldown(evocation) > 0 } and Spell(mark_of_aluneth) or { SpellCooldown(evocation) > 0 or TimeInCombat() < 50 } and ArcaneCooldownsCdPostConditions() or Mana() < 300000 and SpellCooldown(evocation) < 10 and SpellCooldown(evocation) > GCD() * 2 and not BuffPresent(arcane_missiles_buff) and Spell(nether_tempest) or Spell(arcane_missiles) or Spell(arcane_blast)
}

### actions.conserve

AddFunction ArcaneConserveMainActions
{
	#arcane_missiles,if=buff.arcane_missiles.react=3&!buff.rhonins_assaulting_armwraps.react
	if BuffStacks(arcane_missiles_buff) == 3 and not BuffPresent(rhonins_assaulting_armwraps_buff) Spell(arcane_missiles)
	#arcane_missiles,if=buff.quickening.up&buff.quickening.remains<action.arcane_blast.execute_time&buff.arcane_missiles.react
	if BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < ExecuteTime(arcane_blast) and BuffPresent(arcane_missiles_buff) Spell(arcane_missiles)
	#arcane_explosion,if=buff.quickening.up&buff.quickening.remains<action.arcane_blast.execute_time
	if BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < ExecuteTime(arcane_blast) Spell(arcane_explosion)
	#arcane_blast,if=buff.rhonins_assaulting_armwraps.up&equipped.132413
	if BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) Spell(arcane_blast)
	#supernova,if=mana.pct<99
	if ManaPercent() < 99 Spell(supernova)
	#arcane_missiles,if=buff.arcane_missiles.react&mana.pct<96&buff.arcane_charge.stack=4&((cooldown.arcane_power.remains>5|cooldown.evocation.remains-cooldown.arcane_power.remains>15)|buff.arcane_missiles.react>1)&(buff.quickening.remains<gcd*2|buff.arcane_missiles.react>1)
	if BuffPresent(arcane_missiles_buff) and ManaPercent() < 96 and DebuffStacks(arcane_charge_debuff) == 4 and { SpellCooldown(arcane_power) > 5 or SpellCooldown(evocation) - SpellCooldown(arcane_power) > 15 or BuffStacks(arcane_missiles_buff) > 1 } and { BuffRemaining(quickening_buff) < GCD() * 2 or BuffStacks(arcane_missiles_buff) > 1 } Spell(arcane_missiles)
	#arcane_blast,if=buff.arcane_charge.stack<4|mana.pct>70|buff.rune_of_power.up&mana.pct>35
	if DebuffStacks(arcane_charge_debuff) < 4 or ManaPercent() > 70 or BuffPresent(rune_of_power_buff) and ManaPercent() > 35 Spell(arcane_blast)
	#nether_tempest,if=buff.arcane_charge.stack=4
	if DebuffStacks(arcane_charge_debuff) == 4 Spell(nether_tempest)
}

AddFunction ArcaneConserveMainPostConditions
{
}

AddFunction ArcaneConserveShortCdActions
{
	unless BuffStacks(arcane_missiles_buff) == 3 and not BuffPresent(rhonins_assaulting_armwraps_buff) and Spell(arcane_missiles) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < ExecuteTime(arcane_blast) and BuffPresent(arcane_missiles_buff) and Spell(arcane_missiles) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < ExecuteTime(arcane_blast) and Spell(arcane_explosion) or BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast)
	{
		#mark_of_aluneth,if=cooldown.arcane_power.remains>20|cooldown.arcane_power.remains>target.time_to_die
		if SpellCooldown(arcane_power) > 20 or SpellCooldown(arcane_power) > target.TimeToDie() Spell(mark_of_aluneth)
		#rune_of_power,if=dot.mark_of_aluneth.remains&(recharge_time<cooldown.arcane_power.remains|charges=2)
		if target.DebuffRemaining(mark_of_aluneth_debuff) and { SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) or Charges(rune_of_power) == 2 } Spell(rune_of_power)
	}
}

AddFunction ArcaneConserveShortCdPostConditions
{
	BuffStacks(arcane_missiles_buff) == 3 and not BuffPresent(rhonins_assaulting_armwraps_buff) and Spell(arcane_missiles) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < ExecuteTime(arcane_blast) and BuffPresent(arcane_missiles_buff) and Spell(arcane_missiles) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < ExecuteTime(arcane_blast) and Spell(arcane_explosion) or BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast) or ManaPercent() < 99 and Spell(supernova) or BuffPresent(arcane_missiles_buff) and ManaPercent() < 96 and DebuffStacks(arcane_charge_debuff) == 4 and { SpellCooldown(arcane_power) > 5 or SpellCooldown(evocation) - SpellCooldown(arcane_power) > 15 or BuffStacks(arcane_missiles_buff) > 1 } and { BuffRemaining(quickening_buff) < GCD() * 2 or BuffStacks(arcane_missiles_buff) > 1 } and Spell(arcane_missiles) or { DebuffStacks(arcane_charge_debuff) < 4 or ManaPercent() > 70 or BuffPresent(rune_of_power_buff) and ManaPercent() > 35 } and Spell(arcane_blast) or DebuffStacks(arcane_charge_debuff) == 4 and Spell(nether_tempest)
}

AddFunction ArcaneConserveCdActions
{
}

AddFunction ArcaneConserveCdPostConditions
{
	BuffStacks(arcane_missiles_buff) == 3 and not BuffPresent(rhonins_assaulting_armwraps_buff) and Spell(arcane_missiles) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < ExecuteTime(arcane_blast) and BuffPresent(arcane_missiles_buff) and Spell(arcane_missiles) or BuffPresent(quickening_buff) and BuffRemaining(quickening_buff) < ExecuteTime(arcane_blast) and Spell(arcane_explosion) or BuffPresent(rhonins_assaulting_armwraps_buff) and HasEquippedItem(132413) and Spell(arcane_blast) or { SpellCooldown(arcane_power) > 20 or SpellCooldown(arcane_power) > target.TimeToDie() } and Spell(mark_of_aluneth) or target.DebuffRemaining(mark_of_aluneth_debuff) and { SpellChargeCooldown(rune_of_power) < SpellCooldown(arcane_power) or Charges(rune_of_power) == 2 } and Spell(rune_of_power) or ManaPercent() < 99 and Spell(supernova) or BuffPresent(arcane_missiles_buff) and ManaPercent() < 96 and DebuffStacks(arcane_charge_debuff) == 4 and { SpellCooldown(arcane_power) > 5 or SpellCooldown(evocation) - SpellCooldown(arcane_power) > 15 or BuffStacks(arcane_missiles_buff) > 1 } and { BuffRemaining(quickening_buff) < GCD() * 2 or BuffStacks(arcane_missiles_buff) > 1 } and Spell(arcane_missiles) or { DebuffStacks(arcane_charge_debuff) < 4 or ManaPercent() > 70 or BuffPresent(rune_of_power_buff) and ManaPercent() > 35 } and Spell(arcane_blast) or DebuffStacks(arcane_charge_debuff) == 4 and Spell(nether_tempest)
}

### actions.cooldowns

AddFunction ArcaneCooldownsMainActions
{
}

AddFunction ArcaneCooldownsMainPostConditions
{
}

AddFunction ArcaneCooldownsShortCdActions
{
	#rune_of_power,if=buff.arcane_power.down&(cooldown.arcane_power.remains>5|cooldown.arcane_power.remains<=cast_time)
	if BuffExpires(arcane_power_buff) and { SpellCooldown(arcane_power) > 5 or SpellCooldown(arcane_power) <= CastTime(rune_of_power) } Spell(rune_of_power)
}

AddFunction ArcaneCooldownsShortCdPostConditions
{
}

AddFunction ArcaneCooldownsCdActions
{
	unless BuffExpires(arcane_power_buff) and { SpellCooldown(arcane_power) > 5 or SpellCooldown(arcane_power) <= CastTime(rune_of_power) } and Spell(rune_of_power)
	{
		#arcane_power
		Spell(arcane_power)
		#berserking
		Spell(berserking)
		#potion,name=deadly_grace,if=buff.berserking.up
		if BuffPresent(berserking_buff) and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(deadly_grace_potion usable=1)
	}
}

AddFunction ArcaneCooldownsCdPostConditions
{
	BuffExpires(arcane_power_buff) and { SpellCooldown(arcane_power) > 5 or SpellCooldown(arcane_power) <= CastTime(rune_of_power) } and Spell(rune_of_power)
}

### actions.precombat

AddFunction ArcanePrecombatMainActions
{
	#flask,type=flask_of_the_whispered_pact
	#food,type=the_hungry_magister
	#augmentation,type=defiled
	#summon_arcane_familiar
	Spell(summon_arcane_familiar)
	#arcane_blast
	Spell(arcane_blast)
}

AddFunction ArcanePrecombatMainPostConditions
{
}

AddFunction ArcanePrecombatShortCdActions
{
}

AddFunction ArcanePrecombatShortCdPostConditions
{
	Spell(summon_arcane_familiar) or Spell(arcane_blast)
}

AddFunction ArcanePrecombatCdActions
{
	unless Spell(summon_arcane_familiar)
	{
		#snapshot_stats
		#mirror_image
		Spell(mirror_image)
		#potion,name=deadly_grace
		if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(deadly_grace_potion usable=1)
	}
}

AddFunction ArcanePrecombatCdPostConditions
{
	Spell(summon_arcane_familiar) or Spell(arcane_blast)
}

### Arcane icons.

AddCheckBox(opt_mage_arcane_aoe L(AOE) default specialization=arcane)

AddIcon checkbox=!opt_mage_arcane_aoe enemies=1 help=shortcd specialization=arcane
{
	if not InCombat() ArcanePrecombatShortCdActions()
	unless not InCombat() and ArcanePrecombatShortCdPostConditions()
	{
		ArcaneDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_mage_arcane_aoe help=shortcd specialization=arcane
{
	if not InCombat() ArcanePrecombatShortCdActions()
	unless not InCombat() and ArcanePrecombatShortCdPostConditions()
	{
		ArcaneDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=arcane
{
	if not InCombat() ArcanePrecombatMainActions()
	unless not InCombat() and ArcanePrecombatMainPostConditions()
	{
		ArcaneDefaultMainActions()
	}
}

AddIcon checkbox=opt_mage_arcane_aoe help=aoe specialization=arcane
{
	if not InCombat() ArcanePrecombatMainActions()
	unless not InCombat() and ArcanePrecombatMainPostConditions()
	{
		ArcaneDefaultMainActions()
	}
}

AddIcon checkbox=!opt_mage_arcane_aoe enemies=1 help=cd specialization=arcane
{
	if not InCombat() ArcanePrecombatCdActions()
	unless not InCombat() and ArcanePrecombatCdPostConditions()
	{
		ArcaneDefaultCdActions()
	}
}

AddIcon checkbox=opt_mage_arcane_aoe help=cd specialization=arcane
{
	if not InCombat() ArcanePrecombatCdActions()
	unless not InCombat() and ArcanePrecombatCdPostConditions()
	{
		ArcaneDefaultCdActions()
	}
}

### Required symbols
# 132413
# 132451
# arcane_blast
# arcane_charge_debuff
# arcane_explosion
# arcane_missiles
# arcane_missiles_buff
# arcane_power
# arcane_power_buff
# arcane_torrent_mana
# berserking
# berserking_buff
# counterspell
# deadly_grace_potion
# evocation
# mark_of_aluneth
# mark_of_aluneth_debuff
# mirror_image
# nether_tempest
# quaking_palm
# quickening_buff
# rhonins_assaulting_armwraps_buff
# rune_of_power
# rune_of_power_buff
# shard_of_the_exodar_warp
# summon_arcane_familiar
# supernova
# time_warp
]]
    __Scripts.OvaleScripts:RegisterScript("MAGE", "arcane", name, desc, code, "script")
end
end)