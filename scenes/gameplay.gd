extends Node2D

@export var player_0_units_holder: Node2D
@export var player_1_units_holder: Node2D

var battle_winner = -1

func _ready() -> void:
	var wins = {}
	
	var callable = Callable(self, 'set_winner') 
	player_0_units_holder.connect('player_lost', callable)
	player_1_units_holder.connect('player_lost', callable)
	
	for p0_unit0 in range(unit_enums.classes.size()):
		for p0_unit1 in range(unit_enums.classes.size()):
			for p0_unit2 in range(unit_enums.classes.size()):
				for p1_unit0 in range(unit_enums.classes.size()):
					for p1_unit1 in range(unit_enums.classes.size()):
						for p1_unit2 in range(unit_enums.classes.size()):
							player_0_units_holder.set_classes([p0_unit0, p0_unit1, p0_unit2])
							player_1_units_holder.set_classes([p1_unit0, p1_unit1, p1_unit2])
							
							var turn_count = 0
							
							battle_winner = -1
							while battle_winner == -1:
								perform_one_turn()
								turn_count += 1
								if turn_count > 250:
									break
							
							var player_code
							if battle_winner == 0:
								player_code = str(p0_unit0) + str(p0_unit1) + str(p0_unit2)
							else:
								player_code = str(p1_unit0) + str(p1_unit1) + str(p1_unit2)
							
							if player_code in wins.keys():
								wins[player_code] += 1
							else:
								wins[player_code] = 1
	
	var keys = wins.keys()
	keys.sort_custom(
		func (a, b):
			return my_cool_sort_function(a, b, wins))
	
	
	var unit_wins = [0, 0, 0, 0, 0]
	
	var unit_wins_with_same_class = [0, 0, 0, 0, 0]
	
	for key in keys:
		for x in range(5):
			var x_str = str(x)
			
			var class_count = key.count(x_str)
			
			if class_count:
				unit_wins[x] += wins[key]
				if class_count > 1:
					unit_wins_with_same_class[x] += wins[key]
	
	print('unit wins: ', unit_wins)
	print('same class wins: ', unit_wins_with_same_class)
	
	var unique_wins = 0
	for unit in unit_wins:
		unique_wins += unit
	print('unique unit wins: ', unique_wins, ' wins / 5: ', unique_wins/5)

func my_cool_sort_function(a, b, wins):
	if wins[a] > wins[b]:
		return true
	return false

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
	
