extends Node

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var enemy : Enemy = get_owner()

enum Directions {LEFT, RIGHT, UP, DOWN}

var movement_direction = Vector2.ZERO
var animation_direction = Directions.LEFT
var gaze = Directions.LEFT
var velocity = Vector2.ZERO

func get_lr_direction():
	#if velocity.x > 0:
		#animation_direction = Directions.RIGHT
	#elif velocity.x < 0:
		#animation_direction = Directions.LEFT
	#else:
		#pass
		
	if player:
		#if player.global_position.x > enemy.global_position.x:
			#gaze = Directions.RIGHT
		#else:
			#gaze = Directions.LEFT	
		if movement_direction.x > 0:
			animation_direction = Directions.RIGHT
		elif movement_direction.x < 0:
			animation_direction = Directions.LEFT
		else:
			pass
			
			
func _process(delta):
	movement_direction = player.global_position - enemy.global_position
	velocity = enemy.velocity
	get_lr_direction()
	print(animation_direction)
