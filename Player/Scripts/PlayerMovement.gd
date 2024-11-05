extends Node

@export var max_speed := 20.0
@export var acceleration_time := 0.1
@export var animation_player_hero : AnimationPlayer

@onready var player : CharacterBody2D = get_owner()

enum Directions {LEFT, RIGHT, UP, DOWN}
# 
var attack_velocity_timer: Timer
var input = Vector2.ZERO
var velocity = Vector2.ZERO
var current_max_speed = max_speed
var current_acceleration_time = acceleration_time
var direction = Directions.DOWN
var current_animation = null
var is_moving = false
var is_movement_locked = false
var is_attacking = false
var stop_while_attacking = false
#var is_dodging = false

	
func _ready():
	attack_velocity_timer = Timer.new()
	attack_velocity_timer.wait_time = 0.3
	attack_velocity_timer.one_shot = true
	attack_velocity_timer.timeout.connect(on_attack_velocity_timeout)
	add_child(attack_velocity_timer)
	
	
func get_direction():
	if input.x > 0:
		direction = Directions.RIGHT
	elif input.x < 0:
		direction = Directions.LEFT
	elif input.y < 0:
		direction = Directions.UP
	elif input.y > 0:
		direction = Directions.DOWN
	else:
		pass


func change_velocity(temp_velocity, temp_acc):
	current_max_speed = temp_velocity
	current_acceleration_time = temp_acc
	
func on_attack_velocity_timeout():
	stop_while_attacking = true
	
func get_animation(delta):
	current_animation = animation_player_hero.current_animation
	
	if current_animation == "DodgeRight" or current_animation == "DodgeLeft" or current_animation == "DodgeUp" or current_animation == "DodgeDown":
		if direction == Directions.RIGHT and not is_moving:
			input = Vector2(1, 0)
		elif direction == Directions.LEFT and not is_moving:
			input = Vector2(-1, 0)
		elif direction == Directions.UP and not is_moving:
			input = Vector2(0, -1)
		elif direction == Directions.DOWN and not is_moving:
			input = Vector2(0, 1)
		else:
			pass	
	
		#is_dodging = true
		change_velocity(50, 0.1)
	
		is_movement_locked = true
	
	if current_animation.begins_with("Attack"):
		if not is_attacking:
			is_movement_locked = true
			stop_while_attacking = false
			change_velocity(30, 0.1)
			attack_velocity_timer.start()
			is_attacking = true
			
		if stop_while_attacking:
			velocity = Vector2(0,0)	
			
		## teraz zrobić tak, na attack3 najpierw byl zatrzymany, a zaczal sie ruszac po czasie (na odwrot)
		#is_movement_locked = true
		#attack_velocity_timer.start()
		
	if current_animation.begins_with("Recovery"):
		velocity = Vector2(0,0)	
		

func get_velocity(delta):
	if not is_movement_locked:
		var input_direction = Input.get_vector("left","right","up", "down")
		
		input = input_direction
		
		velocity = velocity.move_toward(input * current_max_speed, (1.0 / current_acceleration_time) * delta * current_max_speed)
	
		if input_direction.y && sign(input_direction.y) != sign(velocity.y):
			velocity *= 0.75
			
		if input_direction.x && sign(input_direction.x) != sign(velocity.x):
			velocity *= 0.75
	else:
		velocity = velocity.move_toward(input * current_max_speed, (1.0 / current_acceleration_time) * delta * current_max_speed)
		

func _physics_process(delta):
	if velocity.length() > 0:
		is_moving = true
	else:
		is_moving = false
	
	get_direction()
	get_velocity(delta)
	get_animation(delta)
	
	player.velocity = velocity
	player.move_and_slide()
		


func _on_animation_player_sword_animation_finished(anim_name):
	is_attacking = false
	is_movement_locked = false 
	current_max_speed = max_speed 
	current_acceleration_time = acceleration_time
