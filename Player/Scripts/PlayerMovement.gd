extends Node

@export var max_speed := 20.0
@export var acceleration_time := 0.1
@export var animation_player_hero : AnimationPlayer

@onready var player : CharacterBody2D = get_owner()

enum Directions {LEFT, RIGHT}

var current_max_speed = max_speed
var current_acceleration_time = acceleration_time
var input = Vector2.ZERO
var direction = Directions.RIGHT
var current_animation = null
var is_dodging = false
var is_moving = false
var is_movement_locked = false

	

func get_direction():
	if input.x > 0:
		direction = Directions.RIGHT
	elif input.x < 0:
		direction = Directions.LEFT
	else:
		pass


func change_velocity(temp_velocity, temp_acc):
	current_max_speed = temp_velocity
	current_acceleration_time = temp_acc

	
func get_animation():
	current_animation = animation_player_hero.current_animation
	if current_animation == "DodgeRight" or current_animation == "DodgeLeft":
		if direction == Directions.RIGHT and not is_moving:
			input = Vector2(1, 0)
		elif direction == Directions.LEFT and not is_moving:
			input = Vector2(-1, 0)
		else:
			pass	
		is_dodging = true
		change_velocity(50, 0.1)
		is_movement_locked = true
		

func _physics_process(delta):
	
	var velocity = player.velocity
	
	if velocity.length() > 0:
		is_moving = true
	else:
		is_moving = false
	
	get_direction()
	
	if not is_movement_locked:
		var input_direction = Input.get_vector("left","right","up", "down")
		#print(input_direction.x)
		input = input_direction
		
		velocity = velocity.move_toward(input * current_max_speed, (1.0 / current_acceleration_time) * delta * current_max_speed)
	
		if input_direction.y && sign(input_direction.y) != sign(velocity.y):
			velocity *= 0.75
			
		if input_direction.x && sign(input_direction.x) != sign(velocity.x):
			velocity *= 0.75
	else:
		velocity = velocity.move_toward(input * current_max_speed, (1.0 / current_acceleration_time) * delta * current_max_speed)
		
		
	get_animation()
	print(is_moving)
	player.velocity = velocity
	player.move_and_slide()
		


func _on_animation_player_sword_animation_finished(anim_name):
	is_dodging = false
	is_movement_locked = false 
	current_max_speed = max_speed 
	current_acceleration_time = acceleration_time



#cos sie krzaczy przy fikolkach
