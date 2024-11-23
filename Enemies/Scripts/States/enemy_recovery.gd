extends EnemyState

var recovery_timer = Timer



func process_state(delta):
	anim.play_recovery()
	
func enter():
	enemy.velocity = Vector2.ZERO
	
	recovery_timer = Timer.new()
	recovery_timer.wait_time = randi_range(0.5, 1) #1
	recovery_timer.timeout.connect(on_timeout)
	recovery_timer.autostart = true
	add_child(recovery_timer)
	

func on_timeout():
	transitioned.emit(self, "chase")
	
func exit():
	recovery_timer.timeout.disconnect(on_timeout)
	recovery_timer.stop()
	recovery_timer.queue_free()
	recovery_timer = null
	
