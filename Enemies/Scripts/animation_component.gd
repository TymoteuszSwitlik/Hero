class_name AnimationComp
extends Node

@onready var direction_component: DirectionComp = owner.find_child("DirectionComponent")
@onready var health: HealthComp = owner.find_child("HealthComponent")
@onready var anim = $"../AnimationPlayer"

var direction ## chyba int
var gaze_direction
var lock_direction = false
var locked_direction = null

func _ready():
	health.parried.connect(on_parried)
	
	direction = direction_component.animation_direction
	gaze_direction = direction_component.gaze
	disable_loops()
		
func _process(delta):
	direction = direction_component.animation_direction  ##do zmiany docelowo
	gaze_direction = direction_component.gaze

#func save_animation_position():
	## Store the current animation frame position for the specified animation
	#print(anim.current_animation)
	#if anim.current_animation == last_animation_name:
		#last_animation_position = anim.current_animation_position
	#else:
		#
		#anim.seek(last_animation_position)
	#last_animation_name = anim.current_animation

func disable_loops():
	var anim_names = anim.get_animation_list()
	
	for anim_name in anim_names:
		if "Attack" in anim_name or "Death" in anim_name or "Recovery" in anim_name or "Hurt" in anim_name:
			anim.get_animation(anim_name).loop_mode = 0
	
func play_idle():
	if direction_component.animation_direction == 0:
		anim.play("IdleLeft")
	elif direction_component.animation_direction == 1:
		anim.play("IdleRight")
	elif direction_component.animation_direction == 2:
		anim.play("IdleUp")
	else:
		anim.play("IdleDown")
	
func play_run():
	if direction_component.animation_direction == 0:
		anim.play("RunLeft")
	elif direction_component.animation_direction == 1:
		anim.play("RunRight")
	elif direction_component.animation_direction == 2:
		anim.play("RunUp")
	else:
		anim.play("RunDown")
	
func play_prepare():
	if direction_component.animation_direction == 0:
		anim.play("PrepareLeft")
	elif direction_component.animation_direction == 1:
		anim.play("PrepareRight")
	elif direction_component.animation_direction == 2:
		anim.play("PrepareUp")
	else:
		anim.play("PrepareDown")

func attack_direction_unlock():
	lock_direction = false
	locked_direction = null

func play_attack():
	#print(locked_direction)
	if !lock_direction:
		if direction_component.gaze == 0:
			locked_direction = 0
		elif direction_component.gaze == 1:
			locked_direction = 1
		elif direction_component.gaze == 2:
			locked_direction = 2
		else:
			locked_direction = 3
		lock_direction = true
	else:
		if locked_direction == 0:
			anim.play("AttackLeft")
		elif locked_direction == 1:
			anim.play("AttackRight")
		elif locked_direction == 2:
			anim.play("AttackUp")
		else:
			anim.play("AttackDown")
								
func play_recovery():
	if direction_component.animation_direction == 0:
		anim.play("RecoveryLeft")
	elif direction_component.animation_direction == 1:
		anim.play("RecoveryRight")
	elif direction_component.animation_direction == 2:
		anim.play("RecoveryUp")
	else:
		anim.play("RecoveryDown")
		
func play_hurt():
	if direction_component.animation_direction == 0:
		anim.play("HurtLeft")
	elif direction_component.animation_direction == 1:
		anim.play("HurtRight")
	elif direction_component.animation_direction == 2:
		anim.play("HurtUp")
	else:
		anim.play("HurtDown")

func play_death():
	if direction_component.animation_direction == 0:
		anim.play("DeathRight")
	elif direction_component.animation_direction == 1:
		anim.play("DeathLeft")
	elif direction_component.animation_direction == 2:
		anim.play("DeathDown")
	else:
		anim.play("DeathUp")
		
		
func on_parried():
	pass
