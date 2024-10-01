extends Node

@export var max_speed := 20.0
@export var acceleration_time := 0.1

@onready var player : CharacterBody2D = get_owner()

func _physics_process(delta):
	
	var velocity = player.velocity
	var input_direction = Input.get_vector("left","right","up", "down")
	
	velocity = velocity.move_toward(input_direction * max_speed, (1.0 / acceleration_time) * delta * max_speed)
	
	if input_direction.y && sign(input_direction.y) != sign(velocity.y):
		velocity *= 0.75
		
	if input_direction.x && sign(input_direction.x) != sign(velocity.x):
		velocity *= 0.75
	
		
	player.velocity = velocity
	player.move_and_slide()
		
