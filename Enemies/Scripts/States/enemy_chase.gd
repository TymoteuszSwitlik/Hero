extends EnemyState


var rand_direction_timer: Timer
var rand_chase_direction = 0.0


func process_state(delta):
	anim.play_run()

func physics_process_state(delta):
	if get_distance_to_player() > enemy.chase_radius:
		transitioned.emit(self, "wander")
		return

	if get_distance_to_player() <= enemy.attack_radius and obstacle_detect.see_player:
		transitioned.emit(self, "prepare")
		return
	
	## follow player
	if obstacle_detect.see_player:
		navigation.exit()                   ## stop physics process
		enemy.velocity = direction_comp.movement_direction.rotated(rand_chase_direction) * enemy.chase_speed
	## follow path to player
	else:
		navigation.enter()                  ## start physics process
		call_deferred("follow_path")

	enemy.move_and_slide()

func enter():
	
	rand_direction_timer = Timer.new()
	rand_direction_timer.one_shot = false
	rand_direction_timer.wait_time = randi_range(2, 3)
	rand_direction_timer.timeout.connect(on_timeout)
	rand_direction_timer.autostart = true
	add_child(rand_direction_timer)
	
func on_timeout():
	rand_chase_direction = deg_to_rad(randf_range(-45, 45))

func follow_path():
	enemy.velocity = navigation.current_agent_position.direction_to(navigation.next_path_position) * enemy.chase_speed	


func exit():
	rand_direction_timer.timeout.disconnect(on_timeout)
	rand_direction_timer.stop()
	rand_direction_timer.queue_free()
	rand_direction_timer = null
	
	navigation.exit()              
