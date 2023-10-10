extends Resource
class_name archer_lv1

func before_attack(unit):
	for other_unit in unit.unit_holder.units:
		if other_unit.is_alive:
			other_unit.temp_attack += 1
