extends Node2D

@export var player_0_units_holder: Node2D
@export var player_1_units_holder: Node2D

var battle_winner = -1

var simulated_battle = false
var next_attacking_unit = 0

var last_player_input = 0

func _process(delta: float) -> void:
	if !simulated_battle:
		simulate_battle()
		simulated_battle = true

func simulate_battle():
	randomize()
	
	var callable = Callable(self, 'set_winner') 
	player_0_units_holder.connect('player_lost', callable)
	player_1_units_holder.connect('player_lost', callable)
	
	var wins = []
	var base_class_wins = [0, 0, 0, 0, 0]
	var participants = []
	
	for x in range(2):
		var row = []
		for y in range(5):
			row.append(0)
		wins.append(row)
		var row2 = row.duplicate()
		participants.append(row2)
		var row3 = row.duplicate()
	
	var all_classes = []
	
	for x in range(5):
		var unit_class = [x, 0]
		
		var extra_classes = []
		extra_classes.append([x, 1])
		var y = x - 1
		if y < 0:
			y += 5
		extra_classes.append([y, 0])
		var z = x + 1
		if z > 4:
			z -= 5
		extra_classes.append([z, 0])
		
		for extra_class in extra_classes:
			all_classes.append([unit_class, extra_class])

	
	for x in range(100):
		var teams = [[], []]
		
		for team in range(2):
			for unit in range(3):
				teams[team].append(all_classes.pick_random())
		
		player_0_units_holder.set_classes(teams[0])
		player_1_units_holder.set_classes(teams[1])
		
		var turn_count = 0
		
		battle_winner = -1
		while battle_winner == -1:
			var passed_time = calc_remaining_time()
			
			if next_attacking_unit == 0:
				while true:
					update_player_text()
					
					await player_input
					
					var turn_succesful = perform_turn()
					
					if turn_succesful:
						break
			else:
				await get_tree().create_timer(passed_time).timeout
				perform_turn()
			
			turn_count += 1
			if turn_count > 250:
				break
		
		for team in teams:
			for unit in team:
				for unit_class in unit:
					participants[unit_class[1]][unit_class[0]] += 1
		
		for unit in teams[battle_winner]:
			base_class_wins[unit[0][0]] += 1
			for unit_class in unit:
				wins[unit_class[1]][unit_class[0]] += 1
	
	
	var percentage = []
	for y in range(2):
		var row = []
		for x in range(5):
			var value = (wins[y][x] * 100) / (participants[y][x])
			row.append(value)
		percentage.append(row)
	
	
	var base_class_percentage = []
	for x in range(5):
		var value = (base_class_wins[x] * 100) / (wins[0][x])
		base_class_percentage.append(value)
	
	print('winner:           ', wins)
	print('participants:     ', participants)
	print('base class wins:  ', base_class_wins)
	print('win &:            ', percentage)
	print('base class %:     ', base_class_percentage)

func simolate_lv2_battles():
	var wins = []
	var base_class_wins = [0, 0, 0, 0, 0]
	var participants = []
	
	for x in range(2):
		var row = []
		for y in range(5):
			row.append(0)
		wins.append(row)
		var row2 = row.duplicate()
		participants.append(row2)
		var row3 = row.duplicate()
	
	var all_classes = []
	
	for x in range(5):
		var unit_class = [x, 0]
		
		var extra_classes = []
		extra_classes.append([x, 1])
		var y = x - 1
		if y < 0:
			y += 5
		extra_classes.append([y, 0])
		var z = x + 1
		if z > 4:
			z -= 5
		extra_classes.append([z, 0])
		
		for extra_class in extra_classes:
			all_classes.append([unit_class, extra_class])
	
	for x in range(10000):
		var teams = [[], []]
		
		for team in range(2):
			for unit in range(3):
				teams[team].append(all_classes.pick_random())
		
		player_0_units_holder.set_classes(teams[0])
		player_1_units_holder.set_classes(teams[1])
		
		var turn_count = 0
		
		battle_winner = -1
		while battle_winner == -1:
			calc_remaining_time()
			perform_turn()
			turn_count += 1
			if turn_count > 250:
				break
		
		for team in teams:
			for unit in team:
				for unit_class in unit:
					participants[unit_class[1]][unit_class[0]] += 1
		
		for unit in teams[battle_winner]:
			base_class_wins[unit[0][0]] += 1
			for unit_class in unit:
				wins[unit_class[1]][unit_class[0]] += 1
	
	
	var percentage = []
	for y in range(2):
		var row = []
		for x in range(5):
			var value = (wins[y][x] * 100) / (participants[y][x])
			row.append(value)
		percentage.append(row)
	
	
	var base_class_percentage = []
	for x in range(5):
		var value = (base_class_wins[x] * 100) / (wins[0][x])
		base_class_percentage.append(value)
	
	print('winner:           ', wins)
	print('participants:     ', participants)
	print('base class wins:  ', base_class_wins)
	print('win &:            ', percentage)
	print('base class %:     ', base_class_percentage)

func old_battle_system():
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
								calc_remaining_time()
								perform_turn()
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

func calc_remaining_time():
	next_attacking_unit = 0
	var remaining_time = player_0_units_holder.active_unit.remaining_time
	if player_1_units_holder.active_unit.remaining_time < remaining_time:
		next_attacking_unit = 1
		remaining_time = player_1_units_holder.active_unit.remaining_time
	
	player_0_units_holder.active_unit.pass_time(remaining_time)
	player_1_units_holder.active_unit.pass_time(remaining_time)
	
	return remaining_time

func perform_turn():
	var turn_successful = true
	
	if next_attacking_unit == 0:
		match last_player_input:
			0:
				player_0_units_holder.active_unit.perform_attack(player_1_units_holder.active_unit)
			1:
				turn_successful = player_0_units_holder.switch_unit(1)
			2:
				turn_successful = player_0_units_holder.switch_unit(2)
	else:
		player_1_units_holder.active_unit.perform_attack(player_0_units_holder.active_unit)
	
	if !turn_successful:
		return turn_successful
	
	update_player_text()
	
	return turn_successful

func update_player_text():
	for unit in player_0_units_holder.units:
		unit.update_text(0)
	
	for unit in player_1_units_holder.units:
		unit.update_text(1)

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("1"):
		player_pressed(1)
	if event.is_action_pressed("2"):
		player_pressed(2)
	if event.is_action_pressed("3"):
		player_pressed(3)

signal player_input

func player_pressed(button: int):
	last_player_input = 3 - button
	emit_signal('player_input')
