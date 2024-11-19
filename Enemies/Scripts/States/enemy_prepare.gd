extends EnemyState

var prepare_timer: Timer


func process_state(delta):
	anim.play_prepare()
	
func enter():
	enemy.velocity = Vector2.ZERO
	
	prepare_timer = Timer.new()
	prepare_timer.wait_time = 1 #1
	prepare_timer.timeout.connect(on_timeout)
	prepare_timer.autostart = true
	add_child(prepare_timer)
	
func on_timeout():
	transitioned.emit(self, "attack")
	
func exit():
	prepare_timer.timeout.disconnect(on_timeout)
	prepare_timer.stop()
	prepare_timer.queue_free()
	prepare_timer = null
