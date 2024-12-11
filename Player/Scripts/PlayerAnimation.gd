class_name PlayerAnimation
extends Node

#@export var animation_player_hero : AnimationPlayer
#@export var animation_player_sword : AnimationPlayer

@onready var player : Player = get_owner()
@onready var animation_player_hero = $"../AnimationPlayerHero"
@onready var animation_player_sword = $"../AnimationPlayerSword"
@onready var player_movement = $"../PlayerMovement"

enum Directions {LEFT, RIGHT, UP, DOWN}
enum State {INITIAL, IDLE, RUN, ATTACK, RECOVERY, ATTACK2, RECOVERY2, ATTACK3, DODGE}
	
var direction = Directions.DOWN
var current_state = State.INITIAL
var velocity = Vector2.ZERO
var is_attacking = false
var is_dodging = false



func _ready():
	disable_loops()


func _physics_process(delta):
	get_input()


func disable_loops():
	var anim_names_hero = animation_player_hero.get_animation_list()
	var anim_names_sword = animation_player_sword.get_animation_list()  
	
	for anim_name in anim_names_hero:
		if "Attack" in anim_name or "Dodge" in anim_name or "Recovery" in anim_name or "Hurt" in anim_name or "Dying" in anim_name:
			animation_player_hero.get_animation(anim_name).loop_mode = 0
		
	
	for anim_name in anim_names_sword:
		if "Attack" in anim_name or "Dodge" in anim_name or "Recovery" in anim_name or "Hurt" in anim_name or "Dying" in anim_name:
			animation_player_sword.get_animation(anim_name).loop_mode = 0
		


#func get_direction():
	#if velocity.x > 0:
		#direction = Directions.RIGHT
	#elif velocity.x < 0:
		#direction = Directions.LEFT
	#elif velocity.y < 0:
		#direction = Directions.UP
	#elif velocity.y > 0:
		#direction = Directions.DOWN
	#else:
		#pass
		
func get_direction():
	if player_movement.direction == 1:
		direction = Directions.RIGHT
	elif player_movement.direction == 0:
		direction = Directions.LEFT
	elif player_movement.direction == 2:
		direction = Directions.UP
	elif player_movement.direction == 3:
		direction = Directions.DOWN
	else:
		pass

func get_input():
	velocity = player.velocity
	
	get_direction()	
	
	if is_dodging == false:	
		if is_attacking == false:
			if Input.is_action_just_pressed("attack"):
				is_attacking = true
				set_state(State.ATTACK)	
			elif Input.is_action_just_pressed("dodge"):
				is_dodging = true
				set_state(State.DODGE)
			elif velocity.length() > 0:
				set_state(State.RUN)
			else:
				set_state(State.IDLE)
		
	handle_animation()		
	
	
func set_state(new_state):
	if current_state != new_state:
		current_state = new_state
		#handle_animation()
		

func handle_animation():
	
	match current_state:
		State.IDLE:
			play_idle()
		State.RUN:
			play_run()
		State.DODGE:
			play_dodge()
		State.ATTACK:
			play_attack()
		State.RECOVERY:
			play_recovery()
			if Input.is_action_just_pressed("attack"):
				set_state(State.ATTACK2)
			if Input.is_action_just_pressed("dodge"):
				is_dodging = true
				set_state(State.DODGE)	
		State.ATTACK2:
			play_attack_2()
		State.RECOVERY2:
			play_recovery2()
			if Input.is_action_just_pressed("attack"):
				set_state(State.ATTACK3)
			if Input.is_action_just_pressed("dodge"):
				is_dodging = true
				set_state(State.DODGE)	
		State.ATTACK3:
			play_attack_3()

	#if is_attacking:
		#handle_attack()

#func handle_attack():
		
			
func play_idle():
	if direction == Directions.RIGHT:
		animation_player_hero.play("IdleRight")
		animation_player_sword.play("IdleRight")
	elif direction == Directions.LEFT:
		animation_player_hero.play("IdleLeft")
		animation_player_sword.play("IdleLeft")
	elif direction == Directions.UP:
		animation_player_hero.play("IdleUp")
		animation_player_sword.play("IdleUp")
	else:
		animation_player_hero.play("IdleDown")
		animation_player_sword.play("IdleDown")


func play_run():
	if direction == Directions.RIGHT:
		animation_player_hero.play("RunRight")
		animation_player_sword.play("RunRight")
	elif direction == Directions.LEFT:
		animation_player_hero.play("RunLeft")
		animation_player_sword.play("RunLeft")
	elif direction == Directions.UP:
		animation_player_hero.play("RunUp")
		animation_player_sword.play("RunUp")
	else:
		animation_player_hero.play("RunDown")
		animation_player_sword.play("RunDown")


func play_attack():
	if direction == Directions.RIGHT:
		animation_player_hero.play("AttackRight")
		animation_player_sword.play("AttackRight")
	elif direction == Directions.LEFT:
		animation_player_hero.play("AttackLeft")
		animation_player_sword.play("AttackLeft")
	elif direction == Directions.UP:
		animation_player_hero.play("AttackUp")
		animation_player_sword.play("AttackUp")
	else:
		animation_player_hero.play("AttackDown")
		animation_player_sword.play("AttackDown")


func play_attack_2():
	if direction == Directions.RIGHT:
		animation_player_hero.play("AttackRight2")
		animation_player_sword.play("AttackRight2")
	elif direction == Directions.LEFT:
		animation_player_hero.play("AttackLeft2")
		animation_player_sword.play("AttackLeft2")
	elif direction == Directions.UP:
		animation_player_hero.play("AttackUp2")
		animation_player_sword.play("AttackUp2")
	else:
		animation_player_hero.play("AttackDown2")
		animation_player_sword.play("AttackDown2")
		
		
func play_attack_3():
	if direction == Directions.RIGHT:
		animation_player_hero.play("AttackRight3")
		animation_player_sword.play("AttackRight3")
	elif direction == Directions.LEFT:
		animation_player_hero.play("AttackLeft3")
		animation_player_sword.play("AttackLeft3")
	elif direction == Directions.UP:
		animation_player_hero.play("AttackUp3")
		animation_player_sword.play("AttackUp3")
	else:
		animation_player_hero.play("AttackDown3")
		animation_player_sword.play("AttackDown3")
		
		
func play_recovery():
	if direction == Directions.RIGHT:
		animation_player_hero.play("RecoveryRight")
		animation_player_sword.play("RecoveryRight")
	elif direction == Directions.LEFT:
		animation_player_hero.play("RecoveryLeft")
		animation_player_sword.play("RecoveryLeft")
	elif direction == Directions.UP:
		animation_player_hero.play("RecoveryUp")
		animation_player_sword.play("RecoveryUp")
	else:
		animation_player_hero.play("RecoveryDown")
		animation_player_sword.play("RecoveryDown")
	


func play_recovery2():
	if direction == Directions.RIGHT:
		animation_player_hero.play("RecoveryRight2")
		animation_player_sword.play("RecoveryRight2")
	elif direction == Directions.LEFT:
		animation_player_hero.play("RecoveryLeft2")
		animation_player_sword.play("RecoveryLeft2")
	elif direction == Directions.UP:
		animation_player_hero.play("RecoveryUp2")
		animation_player_sword.play("RecoveryUp2")
	else:
		animation_player_hero.play("RecoveryDown2")
		animation_player_sword.play("RecoveryDown2")	
	
	
func play_dodge():
	if direction == Directions.RIGHT:
		animation_player_hero.play("DodgeRight")
		animation_player_sword.play("DodgeRight")
	elif direction == Directions.LEFT:
		animation_player_hero.play("DodgeLeft")
		animation_player_sword.play("DodgeLeft")
	elif direction == Directions.UP:
		animation_player_hero.play("DodgeUp")
		animation_player_sword.play("DodgeUp")
	else:
		animation_player_hero.play("DodgeDown")
		animation_player_sword.play("DodgeDown")
		

func _on_animation_player_sword_animation_finished(anim_name):
	match current_state:
		State.ATTACK:
			is_attacking = false
			## zablokowałem combo atakow
				#set_state(State.RECOVERY)
			#State.RECOVERY:
				#is_attacking = false
			#State.ATTACK2:
				#set_state(State.RECOVERY2)	
			#State.RECOVERY2:
				#is_attacking = false	
			#State.ATTACK3:
				#is_attacking = false
		State.DODGE:
			is_dodging = false
			is_attacking = false
	pass


##zmiana blokowania ruchu w kombosach. W trakcie 1 ataku w miejscu, recovery w miejscu, atak2 krok, recovery2 w miejscu, atak 3 krok
