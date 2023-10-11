extends Resource
class_name archer_lv2

func after_attack(unit):
	var target = null
	
	for enemy in unit.unit_holder.enemy.units:
		if enemy.battle_pos == 1 and enemy.is_alive:
			target = enemy
	
	if target:
		target.take_damage(3)
