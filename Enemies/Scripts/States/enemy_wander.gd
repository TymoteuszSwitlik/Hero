extends EnemyState


@export var min_wander_time: = 2.5
@export var max_wander_time: = 10.0
@export var wander_speed: = 5.0

var wander_direction: Vector2

var wander_timer: Timer

func enter():
	wander_direction = Vector2.UP.rotated(deg_to_rad(randf_range(0, 360)))
	wander_timer = Timer.new()
	wander_timer.wait_time = randi_range(min_wander_time, max_wander_time)
	wander_timer.timeout.connect(on_timeout)
	wander_timer.autostart = true
	add_child(wander_timer)


func physics_process_state(delta: float):
	enemy.velocity = wander_speed * wander_direction
	enemy.move_and_slide()
	
	try_chase()
	
func on_timeout():
	transitioned.emit(self, "idle")	
	

func exit():
	wander_timer.stop()
	wander_timer.timeout.disconnect(on_timeout)
	wander_timer.queue_free()
	wander_timer = null	
