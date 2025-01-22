class_name PrepareAttackState
extends EnemyState

var prepare_timer: Timer


func process_state(delta):
	anim.play_prepare()
	
	
func enter():
	#enemy.velocity = Vector2.ZERO  ## do usuniecia
	call_deferred("set_velocity_to_zero")

	#movement_comp.set_velocity_to_zero()
	prepare_timer = Timer.new()
	prepare_timer.wait_time = randi_range(0.5, 2) #1
	prepare_timer.timeout.connect(on_timeout)
	prepare_timer.autostart = true
	add_child(prepare_timer)

	
func set_velocity_to_zero():
	movement_comp.state_velocity = Vector2.ZERO


func on_timeout():
	if !obstacle_detect.see_player:
		transitioned.emit(self, "recovery")
	else:
		transitioned.emit(self, "attack")


func exit():
	prepare_timer.timeout.disconnect(on_timeout)
	prepare_timer.stop()
	prepare_timer.queue_free()
	prepare_timer = null
