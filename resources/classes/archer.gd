extends Resource
class_name archer

func before_attack(unit): #split this up when changing unit classes
	for other_unit in unit.unit_holder.units:
		if other_unit.is_alive:
			other_unit.temp_attack += 1

func after_attack(unit):
	var target = null
	
	for enemy in unit.unit_holder.enemy.units:
		if enemy.battle_pos == 1 and enemy.is_alive:
			target = enemy
	
	if target:
		target.take_damage(2)
