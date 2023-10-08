extends Resource
class_name mage

func before_attack(unit): #remove temp when adding splitting these functions up
	for other_unit in unit.unit_holder.units:
		if other_unit.is_alive:
			if other_unit != unit:
				other_unit.remaining_hp += 1
			other_unit.remaining_hp += 1
			other_unit.remaining_hp = clamp(other_unit.remaining_hp, 0, other_unit.max_hp)

func ally_hurt(unit, ally):
	if unit.battle_pos - 1 == ally.battle_pos:
		ally.remaining_hp += 2
		ally.remaining_hp = clamp(ally.remaining_hp, 0, ally.max_hp)
