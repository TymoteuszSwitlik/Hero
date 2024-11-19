extends Node

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var enemy : Enemy = get_owner()

enum Directions {LEFT, RIGHT, UP, DOWN}

var movement_direction = Vector2.ZERO
var animation_direction = Directions.LEFT
var gaze = Directions.LEFT
var velocity = Vector2.ZERO

func _ready():
	randomize()
	var direction_keys = [Directions.LEFT, Directions.RIGHT]
	animation_direction = direction_keys[randi() % direction_keys.size()]

func get_lr_direction():
	## Determine animation direction based on horizontal velocity
	if velocity.x > 0:
		animation_direction = Directions.RIGHT
	elif velocity.x < 0:
		animation_direction = Directions.LEFT
	else:
		pass
	
	## Determine gaze direction based on player position
	if player:
		if player.global_position.x > enemy.global_position.x:
			gaze = Directions.RIGHT
		else:
			gaze = Directions.LEFT	
			
			
			
func _process(delta):
	movement_direction = player.global_position - enemy.global_position
	movement_direction = movement_direction.normalized()	
	velocity = enemy.velocity
	get_lr_direction()
	
	## this make some crazy teleporting stuff with enemies
	#movement_direction = movement_direction.lerp((player.global_position - enemy.global_position).normalized(), 0.1)
	## ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	#print("Movement Direction:", movement_direction, 
		#" | Animation Direction:", animation_direction, 
		#" | Gaze:", gaze)
