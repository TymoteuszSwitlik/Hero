extends EnemyState

var idle_timer: Timer
var cnt = 0 ##debug
	


func process_state(delta):
	anim.play_idle()

func physics_process_state(delta):
	try_chase()
	
func enter():
	randomize()
	enemy.velocity = Vector2.ZERO
	
	idle_timer = Timer.new()
	idle_timer.one_shot = true
	idle_timer.wait_time = randi_range(4, 8)
	idle_timer.timeout.connect(on_timeout)
	idle_timer.autostart = true
	add_child(idle_timer)
	

func on_timeout():
	##cnt = cnt +1  ##debug
	#print(cnt)
	transitioned.emit(self, "wander")



func exit():
	idle_timer.timeout.disconnect(on_timeout)
	idle_timer.stop()
	idle_timer.queue_free()
	idle_timer = null
	## print("dupa")   debug
