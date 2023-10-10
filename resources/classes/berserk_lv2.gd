extends Resource
class_name berserk_lv2

var attack_change = 0

func before_attack(unit):
	var hp_difference = unit.max_hp - unit.remaining_hp
	attack_change = hp_difference / 2
	unit.attack += attack_change

func after_attack(unit):
	unit.attack -= attack_change
