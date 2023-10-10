extends Resource
class_name swordsman_lv1

func switch_in(unit):
	unit.unit_holder.enemy.active_unit.temp_attack -= 2
