extends Node

@export var animation_player : AnimationPlayer

@onready var player : CharacterBody2D = get_owner()

var is_running = false
var direction = -1

func play_idle_right():
	animation_player.play("IdleRight")

func play_idle_left():
	animation_player.play("IdleLeft")
	
func play_run_right():
	animation_player.play("RunRight")

func play_run_left():
	animation_player.play("RunLeft")
	
func play_attack_right():
	animation_player.play("AttackRight")
	
func play_attack_left():
	animation_player.play("AttackLeft")

func play_dodge_right():
	animation_player.play("DodgeRight")
	
func play_dodge_left():
	animation_player.play("DodgeLeft")


func get_direction(velocity):
	if velocity.x > 0:
		direction = 1
	elif velocity.x < 0:
		direction = -1	
	else:
		pass
		
func animate_movement():
	var velocity = player.velocity
	
	if velocity.length() > 0:
		is_running = true
	else:
		is_running = false
		
	if is_running == true:
		get_direction(velocity)
	else:
		pass
		
	if is_running:
		if direction == 1:
			play_run_right()
		else:
			play_run_left()
	else:
		if direction == 1:
			play_idle_right()
		else:
			play_idle_left()

	
func _physics_process(delta):
	animate_movement()
	
		
