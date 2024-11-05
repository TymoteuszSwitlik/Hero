extends Node

@export var animation_player: AnimationPlayer

@onready var enemy_state_machine : Node = get_node("../FSM")
@onready var enemy : Enemy = get_owner()

enum Directions {LEFT, RIGHT}

var direction = Directions.LEFT
var gaze = Directions.LEFT
var velocity = Vector2.ZERO
var current_enemy_state = EnemyState
var player: Player
var attacking = false

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func get_direction():
	if velocity.x > 0:
		direction = Directions.RIGHT
	elif velocity.x < 0:
		direction = Directions.LEFT
	else:
		pass
		
	if player:
		if player.global_position.x > enemy.global_position.x:
			gaze = Directions.RIGHT
		else:
			gaze = Directions.LEFT	
				
func _process(delta):
	current_enemy_state = enemy_state_machine.get_current_state()
	velocity = enemy.velocity
	get_direction()
	
	#print(direction)
	
	if !enemy.alive:
		print("lalalala")
		if direction == Directions.RIGHT:
			animation_player.play("DeathRight")
		else:
			animation_player.play("DeathLeft")
	else:
		if current_enemy_state.name == "Idle":
			if direction == Directions.RIGHT:
				animation_player.play("IdleRight")
			else:
				animation_player.play("IdleLeft")
				
		elif current_enemy_state.name == "Wander" or current_enemy_state.name == "Chase":
			if direction == Directions.RIGHT:
				animation_player.play("RunRight")
			else:
				animation_player.play("RunLeft")
		
		elif current_enemy_state.name == "Attack":
			if !attacking:
				if gaze == Directions.RIGHT:
					animation_player.play("PrepareRight")
				else:
					animation_player.play("PrepareLeft")
			
			else:
				if gaze == Directions.RIGHT:
					animation_player.play("AttackRight")
				else:
					animation_player.play("AttackLeft")	
		elif current_enemy_state.name == "Hurt":
			if direction == Directions.RIGHT:
				animation_player.play("HurtRight")
			else:
				animation_player.play("HurtLeft")
				
		else:
			pass
			## MUSZE OGANRAC JAK POROWNAC OBJECT  W INNYM SCRYPCIE
		



func _on_attack_end():
	attacking = false


func _on_attack_start():
	attacking = true
