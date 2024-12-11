extends CharacterBody2D

@export var max_speed := 50.0
@export var acceleration_time := 0.1

@onready var player: Player = get_tree().get_first_node_in_group("Player")   #byc moze do zmiany przy dodaniu coopa

enum Directions {LEFT, RIGHT, UP, DOWN}

var input_direction = Vector2.ZERO                      ## 
var direction = Directions.DOWN                         ## 
var gaze = Directions.DOWN                         ## 


func _physics_process(delta):
	calculate_velocity(delta)
	get_direction()
	move_and_slide()
	
func calculate_velocity(delta):
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = velocity.move_toward(input_direction * max_speed, (1.0 / acceleration_time) * delta * max_speed)
	if input_direction.y && sign(input_direction.y) != sign(velocity.y):
		velocity *= 0.75
		
	if input_direction.x && sign(input_direction.x) != sign(velocity.x):
		velocity *= 0.75

func get_direction():
	if input_direction.x > 0:
		direction = Directions.RIGHT
	elif input_direction.x < 0:
		direction = Directions.LEFT
	elif input_direction.y < 0:
		direction = Directions.UP
	elif input_direction.y > 0:
		direction = Directions.DOWN
	else:
		pass
	
	if player:	
		var delta = player.global_position - global_position
		if abs(delta.x) > abs(delta.y):
			# Player is farther horizontally
			if delta.x > 0:
				gaze = Directions.RIGHT
			else:
				gaze = Directions.LEFT
		else:
			# Player is farther vertically
			if delta.y > 0:
				gaze = Directions.DOWN
			else:
				gaze = Directions.UP
