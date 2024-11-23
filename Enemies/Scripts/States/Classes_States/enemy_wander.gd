class_name WanderState
extends EnemyState


@export var min_wander_time: = 2.0 #2.5
@export var max_wander_time: = 8.0 #10.0

var wander_direction: Vector2
var wander_timer: Timer
var direction_change_timer: Timer
var wander_speed = null


func process_state(delta):
	anim.play_run()

func physics_process_state(delta: float):
	## option 1
	#wander_direction = wander_direction.rotated(deg_to_rad(randf_range(-5, 5)))
	#enemy.velocity = wander_speed * wander_direction
	
	## option 2
	enemy.velocity = wander_speed * wander_direction
	enemy.move_and_slide()
	
	try_chase()

func enter():
	wander_speed = enemy.wander_speed * randf_range(0.8, 1.2)
	wander_direction = Vector2.UP.rotated(deg_to_rad(randf_range(0, 360)))
	
	wander_timer = Timer.new()
	wander_timer.wait_time = randi_range(min_wander_time, max_wander_time)
	wander_timer.timeout.connect(on_timeout)
	wander_timer.autostart = true
	add_child(wander_timer)
	
	# Direction change timer
	direction_change_timer = Timer.new()
	direction_change_timer.wait_time = randf_range(0.5, 1.5) # Adjust every 0.5–1.5 seconds
	direction_change_timer.timeout.connect(change_direction)
	direction_change_timer.autostart = true
	add_child(direction_change_timer)

	
func on_timeout():
	transitioned.emit(self, "idle")	
	

func change_direction():
	wander_direction = wander_direction.rotated(deg_to_rad(randf_range(-45, 45))) # Randomize by -45 to 45 degrees
	

func exit():
	wander_timer.queue_free()
	wander_timer = null	
