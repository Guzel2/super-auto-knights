extends Node2D

@export var player_number: int
@export var active_unit: Node2D
@export var units = []

signal player_lost(player_number)


func set_classes(classes: Array):
	var callable = Callable(self, 'unit_died') 
	for unit in units:
		unit.is_alive = false
		unit.set_class(classes.pop_front())
	
	for new_class in classes:
		var new_unit = load("res://scenes/unit.tscn").instantiate()
		add_child(new_unit)
		new_unit.set_class(new_class)
		new_unit.connect('died', callable)
		units.append(new_unit)
		
	
	active_unit = units[0]

func start_battle():
	for unit in units:
		unit.set_stats()

func unit_died(dead_unit):
	for unit in units:
		if unit.is_alive:
			change_unit(unit)
			return
	emit_signal('player_lost', player_number)

func change_unit(new_unit):
	active_unit = new_unit
