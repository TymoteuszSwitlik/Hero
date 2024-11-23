extends EnemyState


var rand_direction_timer: Timer     ## timer to randomly change direction
var follow_path_timer: Timer        ## timer to 
var rand_chase_direction = 0.0
var can_follow_player = true        ## allow to follow player
var follow_type = true              ## is following player, or is following nav_agent

func process_state(delta):
	anim.play_run()

func physics_process_state(delta):
	if get_distance_to_player() > enemy.chase_radius:
		transitioned.emit(self, "wander")
		return

	if get_distance_to_player() <= enemy.attack_radius and obstacle_detect.see_player:
		transitioned.emit(self, "prepare")
		return	
		
	var last_follow_type = follow_type
	
	## follow player 
	if obstacle_detect.see_player and can_follow_player:
		follow_type = true                  ## is following player
		
		navigation.exit()                   ## stop nav_agent physics process
		enemy.velocity = direction_comp.movement_direction.rotated(rand_chase_direction) * enemy.chase_speed
	
	## follow nav_agent (path to player)
	else:
		if follow_type:                     ## once after changing from follow player
			can_follow_player = false       ## stop allowing to follow player
		follow_type = false                 ## is following nav_agent
		
		navigation.enter()                  ## start nav_agent physics process
		call_deferred("follow_path")
	
	if last_follow_type != follow_type and !follow_type:   ## once after changing from follow player to follow nav_agent
		follow_path_timer.start()	                       ## start timer so after 1s again allow to follow player
	
	enemy.move_and_slide()
	
	
	 
func enter():
	
	rand_direction_timer = Timer.new()
	rand_direction_timer.one_shot = false
	rand_direction_timer.wait_time = randi_range(2, 3)
	rand_direction_timer.timeout.connect(on_rand_direction_timeout)
	rand_direction_timer.autostart = true
	add_child(rand_direction_timer)
	
	follow_path_timer = Timer.new()
	follow_path_timer.one_shot = true
	follow_path_timer.wait_time = 2
	follow_path_timer.timeout.connect(on_follow_path_timeout)
	follow_path_timer.autostart = false
	add_child(follow_path_timer)
	
	
func on_rand_direction_timeout():
	rand_chase_direction = deg_to_rad(randf_range(-45, 45))

func on_follow_path_timeout():
	can_follow_player = true
		
		
func follow_path():
	var new_velocity = navigation.current_agent_position.direction_to(navigation.next_path_position) * enemy.chase_speed	
	
	if navigation.avoidance_enabled:
		navigation.set_velocity(new_velocity)
	else:
		_on_navigation_agent_velocity_computed(new_velocity)
	

func exit():
	rand_direction_timer.timeout.disconnect(on_rand_direction_timeout)
	rand_direction_timer.stop()
	rand_direction_timer.queue_free()
	rand_direction_timer = null
	
	follow_path_timer.timeout.disconnect(on_follow_path_timeout)
	follow_path_timer.stop()
	follow_path_timer.queue_free()
	follow_path_timer = null
	
	navigation.exit()                   ## stop nav_agent physics process


func _on_navigation_agent_velocity_computed(safe_velocity): 
	enemy.velocity = safe_velocity      ## change enemy velocity to avoid another nav_agents
