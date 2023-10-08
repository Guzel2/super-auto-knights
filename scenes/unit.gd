extends Node2D

@export var unit_class: classes
@export var enums: unit_enums

signal died(unit)

enum classes {
	paladin,
	mage,
	berserk,
	archer,
	swordsman,
}

enum stats {
	attack,
	defence,
	max_hp,
	attack_time,
}

var unit_stats = {
	classes.paladin: 
		{
			stats.attack: 3,
			stats.defence: 2,
			stats.max_hp: 9,
			stats.attack_time: 2.0,
		},
	classes.mage: 
		{
			stats.attack: 4,
			stats.defence: 1,
			stats.max_hp: 8,
			stats.attack_time: 1.7,
		},
	classes.berserk: 
		{
			stats.attack: 5,
			stats.defence: 1,
			stats.max_hp: 10,
			stats.attack_time: 2.6,
		},
	classes.archer: 
		{
			stats.attack: 4,
			stats.defence: 0,
			stats.max_hp: 10,
			stats.attack_time: 1.7,
		},
	classes.swordsman: 
		{
			stats.attack: 4,
			stats.defence: 0,
			stats.max_hp: 12,
			stats.attack_time: 1.9,
		},
}

#stats
var attack = 2
var defence = 0
var max_hp = 10
var attack_time = 2.0

#battlestats
var temp_attack = 0
var temp_defence = 0
var remaining_hp = max_hp
var remaining_time = attack_time
var is_alive = true
var battle_pos = 0

@export var unit_effects: Array

var damage_dealt = 0
var unit_holder: Node2D

var use_extra_effects = true

func switch_out():
	clear_stat_changes()
	
	if !use_extra_effects:
		return
	if unit_effects[unit_class].has_method('switch_out'):
		unit_effects[unit_class].switch_out(self)

func switch_in():
	if !use_extra_effects:
		return
	if unit_effects[unit_class].has_method('switch_in'):
		unit_effects[unit_class].switch_in(self)

func hurt():
	if !use_extra_effects:
		return
	if unit_effects[unit_class].has_method('hurt'):
		unit_effects[unit_class].hurt(self)
	
	for unit in unit_holder.units:
		if unit != self:
			unit.ally_hurt(self)

func ally_hurt(ally):
	if !use_extra_effects:
		return
	if unit_effects[unit_class].has_method('ally_hurt'):
		unit_effects[unit_class].ally_hurt(self, ally)

func before_attack():
	if !use_extra_effects:
		return
	if unit_effects[unit_class].has_method('before_attack'):
		unit_effects[unit_class].before_attack(self)

func after_attack():
	if !use_extra_effects:
		return
	if unit_effects[unit_class].has_method('after_attack'):
		unit_effects[unit_class].after_attack(self)

func koed_enemy():
	if !use_extra_effects:
		return
	if unit_effects[unit_class].has_method('koed_enemy'):
		unit_effects[unit_class].koed_enemy(self)

func set_class(new_class):
	unit_class = new_class
	set_stats()

func set_stats():
	attack = enums.unit_stats[unit_class][stats.attack]
	defence = enums.unit_stats[unit_class][stats.defence]
	max_hp = enums.unit_stats[unit_class][stats.max_hp]
	attack_time = enums.unit_stats[unit_class][stats.attack_time]
	
	temp_attack = 0
	temp_defence = 0
	remaining_hp = max_hp
	remaining_time = attack_time
	
	is_alive = true

func clear_stat_changes():
	temp_attack = 0
	temp_defence = 0
	remaining_time = attack_time

func perform_attack(target):
	before_attack()
	
	var damage = (attack + temp_attack) - (target.defence + target.temp_defence)
	damage_dealt = target.take_damage(damage)
	if !target.is_alive:
		koed_enemy()
	
	remaining_time = attack_time
	
	after_attack()

func take_damage(damage: int):
	hurt()
	
	remaining_hp -= damage
	if remaining_hp <= 0:
		is_alive = false
		emit_signal('died', self)
		damage += remaining_hp
	
	return damage

func pass_time(time: float):
	remaining_time -= time
