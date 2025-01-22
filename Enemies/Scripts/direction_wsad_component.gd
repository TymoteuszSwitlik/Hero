extends DirectionComp


func _ready():
	super()
	health.parried.connect(on_parried)

func get_direction():
	#velocity = enemy.enemy.velocity
	
	if can_change_direction:                            
		var current_direction = animation_direction
		if abs(enemy.velocity.x) > abs(enemy.velocity.y):
		## Determine animation direction based on horizontal velocity
			if enemy.velocity.x > 0:
				animation_direction = Directions.RIGHT
			elif enemy.velocity.x < 0:
				animation_direction = Directions.LEFT
		else:
			if enemy.velocity.y < 0:
				animation_direction = Directions.UP
			elif enemy.velocity.y > 0:
				animation_direction = Directions.DOWN
				
		if current_direction != animation_direction:    ## if direction changed 
			can_change_direction = false                ## block changing direction 
			direction_timer.start()                     ## for 0.5 s 
			
			
	## Determine gaze direction based on player position
	if player:	
		var delta = player.global_position - enemy.global_position
		if abs(delta.x) > abs(delta.y):
			# Player is farther horizontally
			if delta.x > 0:
				gaze = Directions.RIGHT
			else:
				gaze = Directions.LEFT
		else:
			# Player is farther vertically
			if delta.y > 0:
				gaze = Directions.DOWN
			else:
				gaze = Directions.UP

func player_in_front():
	if gaze == animation_direction:
		is_player_in_front = true
	else:
		is_player_in_front = false


func on_parried(attack: Attack):
	can_change_direction = false
	direction_timer.start()                     ## for 0.5 s this timer is set same as parry_pimer in movement_comp
												## maybe it would be better to connect it to end_parry from movement_comp  
