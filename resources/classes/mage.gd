extends Resource
class_name mage

func before_attack(unit):
	for other_unit in unit.unit_holder.units:
		if other_unit.is_alive:
			other_unit.remaining_hp += 2
			other_unit.remaining_hp = clamp(other_unit.remaining_hp, 0, other_unit.max_hp)
