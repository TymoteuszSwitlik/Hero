extends Node

@onready var direction_component = owner.find_child("DirectionComponent")
@onready var anim = owner.find_child("AnimationPlayer")

var direction ## chyba int
var gaze_direction
var lock_direction = false
var locked_direction = null
#var last_animation_position = 0.0
#var last_animation_name = ""

func _ready():
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
	if direction == 0:
		anim.play("IdleLeft")
	else:
		anim.play("IdleRight")
	
func play_run():
	if direction == 0:
		anim.play("RunLeft")
	else:
		anim.play("RunRight")
	#save_animation_position()
	

func play_prepare():
	if direction == 0:
		anim.play("PrepareLeft")
	else:
		anim.play("PrepareRight")

func attack_direction_unlock():
	lock_direction = false
	locked_direction = null

func play_attack():
	#print(locked_direction)
	if !lock_direction:
		if gaze_direction == 0:
			locked_direction = 0
		else:
			locked_direction = 1
		lock_direction = true
	else:
		if locked_direction == 0:
			anim.play("AttackLeft")
		else:
			anim.play("AttackRight")
			
	
func play_recovery():
	if direction == 0:
		anim.play("RecoveryLeft")
	else:
		anim.play("RecoveryRight")

func play_hurt():
	if direction == 0:
		anim.play("HurtLeft")
	else:
		anim.play("HurtRight")


func play_death():
	if direction == 0:
		anim.play("DeathLeft")
	else:
		anim.play("DeathRight")
		
		
