extends Node

@export var animation_player_hero : AnimationPlayer
@export var animation_player_sword : AnimationPlayer

@onready var player : CharacterBody2D = get_owner()

enum Directions {LEFT, RIGHT}
#enum HeroState {IDLERIGHT, IDLELEFT, RUNRIGHT, RUNLEFT, ATTACKRIGHT, ATTACKLEFT, DODGERIGHT, DODGELEFT}
enum HeroState {INITIAL, IDLERIGHT, IDLELEFT, RUNRIGHT, RUNLEFT, DODGERIGHT, DODGELEFT,}
enum SwordState {INITIAL, IDLERIGHT, IDLELEFT, RUNRIGHT, RUNLEFT, ATTACKRIGHT, ATTACKLEFT, DODGERIGHT, DODGELEFT}
	
var direction = Directions.RIGHT
var current_player_state = HeroState.INITIAL
var current_sword_state = SwordState.INITIAL
var velocity = Vector2.ZERO
var is_attacking = false
var is_dodging = false
#var play_attack = true
#var play_dodge = true


func get_direction():
	if velocity.x > 0:
		direction = Directions.RIGHT
	elif velocity.x < 0:
		direction = Directions.LEFT
	else:
		pass
		
		
func set_hero_state(new_state):
	if current_player_state != new_state :
		current_player_state = new_state
		handle_hero_animation()
		
func set_sword_state(new_state):
	if current_sword_state != new_state :
		current_sword_state = new_state
		handle_sword_animation()


func handle_hero_animation():
	match current_player_state:
		HeroState.IDLERIGHT:
				animation_player_hero.play("IdleRight")
				#animation_player_sword.play("IdleRight")
		HeroState.IDLELEFT:
				animation_player_hero.play("IdleLeft")
				#animation_player_sword.play("IdleLeft")
		HeroState.RUNRIGHT:
				animation_player_hero.play("RunRight")
				#animation_player_sword.play("RunRight")
		HeroState.RUNLEFT:
				animation_player_hero.play("RunLeft")
				#animation_player_sword.play("RunLeft")
		#HeroState.ATTACKRIGHT:
				#animation_player_sword.play("AttackRight")
				#play = false
		#HeroState.ATTACKLEFT:
				#animation_player_sword.play("AttackLeft")
				#print(direction)
				#play = false
		HeroState.DODGERIGHT:
				animation_player_hero.play("DodgeRight")
				#animation_player_sword.play("DodgeRight")
				#play = false
		HeroState.DODGELEFT:
				animation_player_hero.play("DodgeLeft")
				#animation_player_sword.play("DodgeLeft")				
				#play = false
				
func handle_sword_animation():
	match current_sword_state:
		SwordState.IDLERIGHT:
				animation_player_sword.play("IdleRight")
		SwordState.IDLELEFT:
				animation_player_sword.play("IdleLeft")
		SwordState.RUNRIGHT:
				animation_player_sword.play("RunRight")
		SwordState.RUNLEFT:
				animation_player_sword.play("RunLeft")
		SwordState.ATTACKRIGHT:
				animation_player_sword.play("AttackRight")
				#play = false
		SwordState.ATTACKLEFT:
				animation_player_sword.play("AttackLeft")
				#play = false
		SwordState.DODGERIGHT:
				animation_player_sword.play("DodgeRight")
				#play = false
		SwordState.DODGELEFT:
				animation_player_sword.play("DodgeLeft")				
				#play = false

				
func get_input():
	velocity = player.velocity
	get_direction()	
	
	if is_dodging == false:	
		if Input.is_action_just_pressed("attack"):
			if direction == Directions.RIGHT:
				set_sword_state(SwordState.ATTACKRIGHT)	
			else:
				set_sword_state(SwordState.ATTACKLEFT)	
			is_attacking = true
		elif Input.is_action_just_pressed("dodge"):
			if direction == Directions.RIGHT:
				#player.velocity.x = 20
				set_hero_state(HeroState.DODGERIGHT)
				set_sword_state(SwordState.DODGERIGHT)
			else:
				#player.velocity.x = -20
				set_hero_state(HeroState.DODGELEFT)
				set_sword_state(SwordState.DODGELEFT)
			is_dodging = true
		elif velocity.length() > 0:
			if direction == Directions.RIGHT:
				set_hero_state(HeroState.RUNRIGHT)
				if is_attacking == false:
					set_sword_state(SwordState.RUNRIGHT)
				
			else:
				set_hero_state(HeroState.RUNLEFT)
				if is_attacking == false:
					set_sword_state(SwordState.RUNLEFT)
				
		else:
			if direction == Directions.RIGHT:
				set_hero_state(HeroState.IDLERIGHT)
				if is_attacking == false:
					set_sword_state(SwordState.IDLERIGHT)
			else:
				set_hero_state(HeroState.IDLELEFT)
				if is_attacking == false:
					set_sword_state(SwordState.IDLELEFT)
				

#func reset_animation():
	#if is_attacking:
		#if direction == Directions.RIGHT:
			#set_hero_state(HeroState.RUNRIGHT if velocity.length() > 0 else HeroState.IDLERIGHT)
		#else:
			#set_hero_state(HeroState.RUNLEFT if velocity.length() > 0 else HeroState.IDLELEFT)
		#is_attacking = false
	#
	#if is_dodging:
		#if direction == Directions.RIGHT:
			#set_hero_state(HeroState.RUNRIGHT if velocity.length() > 0 else HeroState.IDLERIGHT)
		#else:
			#set_hero_state(HeroState.RUNLEFT if velocity.length() > 0 else HeroState.IDLELEFT)
		#is_dodging = false
		
			
func _physics_process(delta):
	#if play:
	get_input()
	#reset_animation()
		

func _on_animation_player_sword_animation_started(anim_name):
	pass
	
func _on_animation_player_sword_animation_finished(anim_name):
	is_attacking = false
	is_dodging = false




#ZABLOKOWAC KIERUNEK PRZY FILKFLAKACH
