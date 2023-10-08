extends Resource
class_name swordsman

func switch_in(unit):
	unit.unit_holder.enemy.active_unit.temp_attack -= 2

func koed_enemy(unit):
	unit.temp_attack += 1
	unit.temp_defence += 1
