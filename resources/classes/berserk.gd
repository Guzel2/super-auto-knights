extends Resource
class_name berserk

func before_attack(unit):
	unit.remaining_hp -= 1
	unit.temp_attack += 2
	unit.hurt()
