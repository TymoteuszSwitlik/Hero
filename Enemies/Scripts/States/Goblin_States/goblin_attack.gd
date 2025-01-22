class_name GoblinAttackState
extends AttackState


func physics_process_state(delta):
	check_if_player_is_in_front()
	
	


func enter():
	#enemy.velocity = Vector2.ZERO            ##do usuniecia
	movement_comp.state_velocity = Vector2.ZERO

	anim.attack_direction_unlock() # zeruje warunki pobierania kierunku w celu zablokowania kierunku animacji 
	attack_speed = enemy.attack_speed
	current_player_position = player.global_position
	
	draw.draw_current_position(current_player_position) ## debug ##
	
	clear_timers()
	attack_prepare_timer = Timer.new()
	attack_prepare_timer.one_shot = true
	attack_prepare_timer.wait_time = 0.2
	attack_prepare_timer.timeout.connect(on_prepare_timeout)
	attack_prepare_timer.autostart = true
	add_child(attack_prepare_timer)
		

func check_if_player_is_in_front():
	if direction_comp.is_player_in_front:
		health.is_parrying = true
	else:
		health.is_parrying = false

func on_prepare_timeout():
	attack_action_timer = Timer.new()
	attack_action_timer.one_shot = true
	attack_action_timer.wait_time = 0.2 
	attack_action_timer.timeout.connect(on_action_timeout)
	attack_action_timer.autostart = true
	add_child(attack_action_timer)
	
	#enemy.velocity = (current_player_position - enemy.global_position).normalized() * attack_speed  ##do usuniecia
	movement_comp.state_velocity = (current_player_position - enemy.global_position).normalized() * attack_speed
	
	
func exit():
	super()
	health.is_parrying = false     
