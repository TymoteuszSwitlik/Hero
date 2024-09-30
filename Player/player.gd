extends CharacterBody2D


@export var speed = 20.0

var is_moving = false
var is_attacking = false
enum {LEFT, RIGHT}
var direction = RIGHT
	

	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if velocity.length() > 0.0:
		is_moving = true
		if velocity[0] < 0.0:
			direction = LEFT
		elif velocity[0] > 0.0:
			direction = RIGHT	
	else:	
		is_moving = false
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
	else:
		is_attacking = false
	
	
			
func play_animation():
	if direction == RIGHT:
		if is_moving == true:
			get_tree().call_group("Hero", "play_run_animation_right")
		else:
			get_tree().call_group("Hero", "play_idle_animation_right")
	else:
		if is_moving == true:
				get_tree().call_group("Hero", "play_run_animation_left")
		else:
			get_tree().call_group("Hero", "play_idle_animation_left")
			
	
			
		
		
			
func _physics_process(delta):
	get_input()
	play_animation()
	move_and_slide()
