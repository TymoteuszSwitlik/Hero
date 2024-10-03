extends Node

@export var max_speed := 20.0
@export var acceleration_time := 0.1
@export var animation_player_hero : AnimationPlayer

@onready var player : CharacterBody2D = get_owner()

var current_max_speed = max_speed
var current_animation = null
var is_dodging = false


func change_velocity(temp_velocity):
	current_max_speed = temp_velocity
	
	
func get_animation():
	current_animation = animation_player_hero.current_animation
	if current_animation == "DodgeRight" or current_animation == "DodgeLeft":
		is_dodging = true
		change_velocity(50)
		

func _physics_process(delta):
	
	var velocity = player.velocity
	var input_direction = Input.get_vector("left","right","up", "down")
	
	velocity = velocity.move_toward(input_direction * current_max_speed, (1.0 / acceleration_time) * delta * current_max_speed)
	
	if input_direction.y && sign(input_direction.y) != sign(velocity.y):
		velocity *= 0.75
		
	if input_direction.x && sign(input_direction.x) != sign(velocity.x):
		velocity *= 0.75
	
	get_animation()
	
	player.velocity = velocity
	player.move_and_slide()
		


func _on_animation_player_sword_animation_finished(anim_name):
	is_dodging = false
	current_max_speed = max_speed 
