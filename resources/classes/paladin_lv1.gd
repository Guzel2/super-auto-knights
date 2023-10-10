extends Resource
class_name paladin_lv1

func switch_out(unit):
	unit.remaining_hp += 3
	unit.remaining_hp = clamp(unit.remaining_hp, 0, unit.max_hp)
