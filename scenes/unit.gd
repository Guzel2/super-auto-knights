extends Node2D

@export var enums: unit_enums

signal died(unit)

enum stats {
	attack,
	defence,
	max_hp,
	attack_time,
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


@export var m_lv1: mage_lv1
@export var p_lv1: paladin_lv1
@export var b_lv1: berserk_lv1
@export var s_lv1: swordsman_lv1
@export var a_lv1: archer_lv1

@export var m_lv2: mage_lv2
@export var p_lv2: paladin_lv2
@export var s_lv2: swordsman_lv2
@export var b_lv2: berserk_lv2
@export var a_lv2: archer_lv2

var unit_effects = []

var unit_classes = []

var damage_dealt = 0
var unit_holder: Node2D

var use_extra_effects = true

func _ready() -> void:
	unit_effects = [
		[m_lv1, p_lv1, s_lv1, b_lv1, a_lv1],
		[m_lv2, p_lv2, s_lv2, b_lv2, a_lv2]
	]

func switch_out():
	clear_stat_changes()
	
	if !use_extra_effects:
		return
	for unit_class in unit_classes:
		if unit_class.has_method('switch_out'):
			unit_class.switch_out(self)

func switch_in():
	if !use_extra_effects:
		return
	for unit_class in unit_classes:
		if unit_class.has_method('switch_in'):
			unit_class.switch_in(self)

func hurt():
	if !use_extra_effects:
		return
	for unit_class in unit_classes:
		if unit_class.has_method('hurt'):
			unit_class.hurt(self)
	
	for unit in unit_holder.units:
		if unit != self:
			unit.ally_hurt(self)

func ally_hurt(ally):
	if !use_extra_effects:
		return
	for unit_class in unit_classes:
		if unit_class.has_method('ally_hurt'):
			unit_class.ally_hurt(self, ally)

func before_attack():
	if !use_extra_effects:
		return
	for unit_class in unit_classes:
		if unit_class.has_method('before_attack'):
			unit_class.before_attack(self)

func after_attack():
	if !use_extra_effects:
		return
	for unit_class in unit_classes:
		if unit_class.has_method('after_attack'):
			unit_class.after_attack(self)

func koed_enemy():
	if !use_extra_effects:
		return
	
	for unit_class in unit_classes:
		if unit_class.has_method('koed_enemy'):
			unit_class.koed_enemy(self)

func set_classes(new_classes: Array):
	unit_classes = new_classes
	set_stats()

func set_stats():
	attack = enums.unit_stats[unit_classes[0]][stats.attack]
	defence = enums.unit_stats[unit_classes[0]][stats.defence]
	max_hp = enums.unit_stats[unit_classes[0]][stats.max_hp]
	attack_time = enums.unit_stats[unit_classes[0]][stats.attack_time]
	
	for extra_class in unit_classes:
		if extra_class == unit_classes[0]:
			continue
		
		attack += enums.unit_level_up_stats[extra_class][stats.attack]
		defence += enums.unit_level_up_stats[extra_class][stats.defence]
		max_hp += enums.unit_level_up_stats[extra_class][stats.max_hp]
		attack_time += enums.unit_level_up_stats[extra_class][stats.attack_time]
	
	temp_attack = 0
	temp_defence = 0
	remaining_hp = max_hp
	remaining_time = attack_time
	
	is_alive = true
	
	turn_unit_classes_to_ressources()

func turn_unit_classes_to_ressources():
	var new_unit_classes = []
	for unit_class in unit_classes:
		var class_id = unit_class
		var level = unit_class / 5
		new_unit_classes.append(unit_effects[level][class_id])
	unit_classes = new_unit_classes

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
