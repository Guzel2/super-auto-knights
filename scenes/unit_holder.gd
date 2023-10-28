extends Node2D

@export var player_number: int
@export var active_unit: Node2D
@export var units = []
@export var enemy: Node2D

signal player_lost(player_number)

func set_classes(classes: Array):
	var temp_classes = classes.duplicate()
	
	var battle_pos = 0
	
	var callable = Callable(self, 'unit_died') 
	for unit in units:
		unit.is_alive = false
		unit.set_classes(temp_classes.pop_front())
		unit.battle_pos = battle_pos
		battle_pos += 1
	
	for new_class in temp_classes:
		var new_unit = load("res://scenes/unit.tscn").instantiate()
		add_child(new_unit)
		new_unit.set_classes(new_class)
		new_unit.connect('died', callable)
		new_unit.unit_holder = self
		units.append(new_unit)
		new_unit.battle_pos = battle_pos
		battle_pos += 1
	
	active_unit = units[0]

func start_battle():
	for unit in units:
		unit.set_stats()

func unit_died(dead_unit):
	var next_unit = null
	for unit in units:
		if unit.is_alive:
			unit.battle_pos -= 1
			if unit.battle_pos == 0:
				next_unit = unit
		else:
			unit.battle_pos = -1
	
	if next_unit:
		change_unit(next_unit)
	else:
		emit_signal('player_lost', player_number)

func change_unit(new_unit):
	if active_unit.is_alive:
		active_unit.switch_out()
	active_unit = new_unit
	active_unit.switch_in()

func switch_unit(new_unit: int):
	var target_unit
	for unit in units:
		if unit.battle_pos == new_unit:
			active_unit.battle_pos = new_unit
			unit.battle_pos = 0
			change_unit(unit)
			return true
	return false
