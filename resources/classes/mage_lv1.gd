extends Resource
class_name mage_lv1

func ally_hurt(unit, ally):
	if unit.battle_pos - 1 == ally.battle_pos:
		if ally.is_alive:
			ally.remaining_hp += 3
			ally.remaining_hp = clamp(ally.remaining_hp, 0, ally.max_hp)
