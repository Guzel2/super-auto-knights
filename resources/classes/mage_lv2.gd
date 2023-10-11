extends Resource
class_name mage_lv2

func before_attack(unit): #remove temp when adding splitting these functions up
	for other_unit in unit.unit_holder.units:
		if other_unit.is_alive:
			if other_unit != unit:
				other_unit.remaining_hp += 1
			other_unit.remaining_hp += 2
			other_unit.remaining_hp = clamp(other_unit.remaining_hp, 0, other_unit.max_hp)
