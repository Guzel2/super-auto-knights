extends Node2D

@export var unit_class: classes

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
			stats.attack_time: 1.8,
		},
	classes.berserk: 
		{
			stats.attack: 5,
			stats.defence: 1,
			stats.max_hp: 10,
			stats.attack_time: 2.5,
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

func set_class(new_class):
	unit_class = new_class
	set_stats()

func set_stats():
	attack = unit_stats[unit_class][stats.attack]
	defence = unit_stats[unit_class][stats.defence]
	max_hp = unit_stats[unit_class][stats.max_hp]
	attack_time = unit_stats[unit_class][stats.attack_time]
	
	temp_attack = 0
	temp_defence = 0
	remaining_hp = max_hp
	remaining_time = attack_time
	
	is_alive = true

func perform_attack(target):
	var damage = attack - target.defence
	target.take_damage(damage)
	remaining_time = attack_time

func take_damage(damage: int):
	remaining_hp -= damage
	if remaining_hp <= 0:
		is_alive = false
		emit_signal('died', self)
		#print(unit_class, ' just died :(')

func pass_time(time: float):
	remaining_time -= time
