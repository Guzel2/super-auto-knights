extends Resource
class_name paladin

func after_attack(unit):
	var damage_dealt = unit.damage_dealt
	unit.remaining_hp += damage_dealt / 2
	unit.remaining_hp = clamp(unit.remaining_hp, 0, unit.max_hp)
