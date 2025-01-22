class_name DirectionComp
extends Node

@onready var player: Player = get_tree().get_first_node_in_group("Player")   #byc moze do zmiany przy dodaniu coopa
@onready var health: HealthComp = owner.find_child("HealthComponent")
@onready var enemy: Enemy = get_owner()

enum Directions {LEFT, RIGHT, UP, DOWN}


var direction_timer: Timer           ## prevent rapidly changing animations
var movement_direction = Vector2.ZERO
var animation_direction = Directions.LEFT
var gaze = Directions.LEFT
var velocity = Vector2.ZERO
var can_change_direction = true      ## prevent rapidly changing animations
var is_player_in_front = true        ## checking if can_take_damage in health

func _ready():
	randomize()
	var direction_keys = [Directions.LEFT, Directions.RIGHT]
	animation_direction = direction_keys[randi() % direction_keys.size()]
	
	direction_timer = Timer.new()
	direction_timer.one_shot = true
	direction_timer.wait_time = 0.5
	direction_timer.timeout.connect(on_timeout)
	direction_timer.autostart = false
	add_child(direction_timer)


func _process(delta):
	movement_direction = enemy.global_position.direction_to(player.global_position)
	#movement_direction = player.global_position - enemy.global_position
	#movement_direction = movement_direction.normalized()	
	get_direction()
	player_in_front()

func get_direction():
	pass

func on_timeout():
	can_change_direction = true
	
func player_in_front():
	pass
			
	
	## this make some crazy teleporting stuff with enemies
	#movement_direction = movement_direction.lerp((player.global_position - enemy.global_position).normalized(), 0.1)
	## ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
	#print("Movement Direction:", movement_direction, 
		#" | Animation Direction:", animation_direction, 
		#" | Gaze:", gaze)
