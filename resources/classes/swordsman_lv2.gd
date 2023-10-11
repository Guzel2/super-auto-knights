extends Resource
class_name swordsman_lv2

func koed_enemy(unit):
	unit.temp_attack += 3
	unit.temp_defence += 1
