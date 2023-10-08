extends Resource
class_name berserk

func before_attack(unit): #remove this when breaking up classes
	unit.remaining_hp -= 1
	unit.temp_attack += 2
	unit.hurt()

#func before_attack(unit):
	var hp_difference = unit.max_hp - unit.remaining_hp
	unit.attack += hp_difference / 2

func after_attack(unit):
	unit.attack = unit.enums.unit_stats[unit.unit_class][unit.stats.attack]
