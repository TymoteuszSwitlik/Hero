extends DirectionComp




func get_direction():
	velocity = enemy.velocity
	if can_change_direction:                            
		var current_direction = animation_direction

		## Determine animation direction based on horizontal velocity
		if velocity.x > 0:
			animation_direction = Directions.RIGHT
		elif velocity.x < 0:
			animation_direction = Directions.LEFT
		else:
			pass
			
		if current_direction != animation_direction:    ## if direction changed 
			can_change_direction = false                ## block changing direction 
			direction_timer.start()                     ## for 0.5 s 
			
			
	## Determine gaze direction based on player position
	if player:
		if player.global_position.x > enemy.global_position.x:
			gaze = Directions.RIGHT
		else:
			gaze = Directions.LEFT	
