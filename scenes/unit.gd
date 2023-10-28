extends Node2D

@export var enums: unit_enums
@export var text_label: Label

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
var unit_classes_ints = []

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
	unit_classes = new_classes.duplicate()
	unit_classes_ints = new_classes.duplicate()
	set_stats()

func turn_2D_unit_value_into_int(unit: Array):
	var value = unit[0] + 5 * unit[1]
	return value

func set_stats():
	var unit_value = turn_2D_unit_value_into_int(unit_classes[0])
	
	attack = enums.unit_stats[unit_value][stats.attack]
	defence = enums.unit_stats[unit_value][stats.defence]
	max_hp = enums.unit_stats[unit_value][stats.max_hp]
	attack_time = enums.unit_stats[unit_value][stats.attack_time]
	
	for extra_class in unit_classes:
		if extra_class == unit_classes[0]:
			continue
		var extra_unit_value = turn_2D_unit_value_into_int(extra_class)
		
		attack += enums.unit_level_up_stats[extra_unit_value][stats.attack]
		defence += enums.unit_level_up_stats[extra_unit_value][stats.defence]
		max_hp += enums.unit_level_up_stats[extra_unit_value][stats.max_hp]
		attack_time += enums.unit_level_up_stats[extra_unit_value][stats.attack_time]
	
	temp_attack = 0
	temp_defence = 0
	remaining_hp = max_hp
	remaining_time = attack_time
	
	is_alive = true
	
	turn_unit_classes_to_ressources()

func turn_unit_classes_to_ressources():
	var new_unit_classes = []
	for unit_class in unit_classes:
		new_unit_classes.append(unit_effects[unit_class[1]][unit_class[0]])
	unit_classes = new_unit_classes

func clear_stat_changes():
	temp_attack = 0
	temp_defence = 0
	remaining_time = attack_time

func perform_attack(target):
	before_attack()
	
	var damage = (attack + temp_attack) - (target.defence + target.temp_defence)
	damage = 0 if damage < 0 else damage
	damage_dealt = target.take_damage(damage)
	if !target.is_alive:
		koed_enemy()
	
	remaining_time = attack_time
	
	after_attack()

func take_damage(damage: int):
	hurt()
	
	remaining_hp -= damage
	if remaining_hp <= 0:
		unit_died()
		damage += remaining_hp
	
	return damage

func unit_died():
	is_alive = false
	emit_signal('died', self)

func pass_time(time: float):
	remaining_time -= time

func update_text(player_num: int):
	if is_alive:
		var classes = 'Classes:\n'
		
		for class_value in unit_classes_ints:
			match class_value[0]:
				0:
					classes += 'Mage '
				1:
					classes += 'Paladin '
				2:
					classes += 'Swordsman '
				3:
					classes += 'Berserk '
				4:
					classes += 'Archer '
			
			classes += 'Lv. ' + str(class_value[1] + 1) + '\n'
		
		text_label.text = classes + '
		HP: ' + str(remaining_hp) + ' (' + str(max_hp) + ')\n' + '
		ATK: ' + str(attack) + ' (' + str(temp_attack) + ')\n'  + '
		DEF: ' + str(defence) + ' (' + str(temp_defence) + ')\n'  + '
		TIME: ' + str(remaining_time) + ' (' + str(attack_time) + ')'
	else:
		text_label.text = 'dead'
	
	if player_num == 0:
		text_label.position = Vector2(400, 0) - Vector2(120, 0) * battle_pos
	else:
		text_label.position = Vector2(600, 0) + Vector2(120, 0) * battle_pos
