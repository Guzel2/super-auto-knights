extends Node2D

@export var player_0_units_holder: Node2D
@export var player_1_units_holder: Node2D

var battle_winner = -1

func _ready() -> void:
	
	var wins = {}
	
	var callable = Callable(self, 'set_winner') 
	player_0_units_holder.connect('player_lost', callable)
	player_1_units_holder.connect('player_lost', callable)
	
	for p0_unit0 in range(5):
		for p0_unit1 in range(5):
			for p1_unit0 in range(5):
				for p1_unit1 in range(5):
					player_0_units_holder.set_classes([p0_unit0, p0_unit1])
					player_1_units_holder.set_classes([p1_unit0, p1_unit1])
					
					battle_winner = -1
					while battle_winner == -1:
						perform_one_turn()
					
					var player_code
					if battle_winner == 0:
						player_code = str(p0_unit0) + str(p0_unit1)
					else:
						player_code = str(p1_unit0) + str(p1_unit1)
					wins[player_code] += 1
	print(wins)

func set_winner(loser):
	battle_winner = 1 - loser

func perform_one_turn():
	var next_attacking_unit = 0
	var remaining_time = player_0_units_holder.active_unit.remaining_time
	if player_1_units_holder.active_unit.remaining_time < remaining_time:
		next_attacking_unit = 1
		remaining_time = player_1_units_holder.active_unit.remaining_time
	
	#wait the remaining time
	
	player_0_units_holder.active_unit.pass_time(remaining_time)
	player_1_units_holder.active_unit.pass_time(remaining_time)
	
	if next_attacking_unit == 0:
		player_0_units_holder.active_unit.perform_attack(player_1_units_holder.active_unit)
	else:
		player_1_units_holder.active_unit.perform_attack(player_0_units_holder.active_unit)
	
