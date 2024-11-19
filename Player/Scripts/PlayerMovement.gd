extends Node

@export var max_speed := 40.0
@export var acceleration_time := 0.1
@export var animation_player_hero : AnimationPlayer

@onready var player : CharacterBody2D = get_owner()

enum Directions {LEFT, RIGHT, UP, DOWN}

var attack_timer: Timer                                 ## 
var spin_attack_timer: Timer                            ## 
var input_direction = Vector2.ZERO                      ## 
var direction = Directions.DOWN                         ## 
var velocity = Vector2.ZERO                             ## 
var current_max_speed = max_speed                       ## 
var current_acceleration_time = acceleration_time       ## 
var current_animation = null                            ## 
var is_moving = false                                   ## 
var is_direction_locked = false                         ## 
var is_attacking = false                                ## 
var stop_while_attacking = false                        ## 
#var is_dodging = false

	
func _ready():
	attack_timer = Timer.new()
	attack_timer.wait_time = 0.3
	attack_timer.one_shot = true
	attack_timer.timeout.connect(on_attack_timer_timeout)
	add_child(attack_timer)
	
	spin_attack_timer = Timer.new()
	spin_attack_timer.wait_time = 1
	spin_attack_timer.one_shot = true
	spin_attack_timer.timeout.connect(on_spin_attack_timer_timeout)
	add_child(spin_attack_timer)

	
func _physics_process(delta):
	if velocity.length() > 0:
		is_moving = true
	else:
		is_moving = false
	
	get_direction()
	get_velocity(delta)
	get_animation(delta)
	
	player.velocity = velocity
	player.move_and_slide()
	
## calculate direction from input
func get_direction():
	if input_direction.x > 0:
		direction = Directions.RIGHT
	elif input_direction.x < 0:
		direction = Directions.LEFT
	elif input_direction.y < 0:
		direction = Directions.UP
	elif input_direction.y > 0:
		direction = Directions.DOWN
	else:
		pass


## calculate movement speed and decide in which direction should it continue
func get_velocity(delta):
	if not is_direction_locked:
		input_direction = Input.get_vector("left","right","up", "down")
		
		velocity = velocity.move_toward(input_direction * current_max_speed, (1.0 / current_acceleration_time) * delta * current_max_speed)
	
		if input_direction.y && sign(input_direction.y) != sign(velocity.y):
			velocity *= 0.75
			
		if input_direction.x && sign(input_direction.x) != sign(velocity.x):
			velocity *= 0.75
	else: 
		velocity = velocity.move_toward(input_direction * current_max_speed, (1.0 / current_acceleration_time) * delta * current_max_speed)
		
		
## get information about current animation and decide about stop/play movement		
func get_animation(delta):
	current_animation = animation_player_hero.current_animation
	
	## give velocity during dodging if not moving (while staing in place) based on direction 
	if current_animation == "DodgeRight" or current_animation == "DodgeLeft" or current_animation == "DodgeUp" or current_animation == "DodgeDown":
		if direction == Directions.RIGHT and not is_moving:
			input_direction = Vector2(1, 0)
		elif direction == Directions.LEFT and not is_moving:
			input_direction = Vector2(-1, 0)
		elif direction == Directions.UP and not is_moving:
			input_direction = Vector2(0, -1)
		elif direction == Directions.DOWN and not is_moving:
			input_direction = Vector2(0, 1)                     
		else:
			pass	
	
		#is_dodging = true
		is_direction_locked = true
		change_velocity(100, 0.2)
	
	if current_animation.begins_with("Attack"):
		velocity = Vector2(0, 0)
	## zablokowałem dodawanie predkosci w trakcie atakowania
		#if current_animation.contains("3"):
			#if not is_attacking:
				#spin_attack_timer.start()
				#is_attacking = true
				#is_direction_locked = true
			#if !stop_while_attacking:
					##print("lalala")
				#change_velocity(60, 0.1)  
					#
		#
		#if not is_attacking:                      ## get inside at beggining of attack
			#is_attacking = true                   ## lock getting inside during attack 
			#is_direction_locked = true            ## lock input to prevent changing direction in middle of attack animation
			#stop_while_attacking = false          ## unlock moving in the beggining of attack animation
			#
			#change_velocity(60, 0.1)              ## give velocity to make "step" during attack 
			#attack_timer.start()                  ## 0.3 s to again stop moving
			#
		#if stop_while_attacking:                  ## after 0.3 s
			#velocity = Vector2(0,0)	              ## stop moving
			#
			#
		### teraz zrobić tak, na attack3 najpierw byl zatrzymany, a zaczal sie ruszac po czasie (na odwrot)
		##is_direction_locked = true
		##attack_timer.start()
		#
	#if current_animation.begins_with("Recovery"):
		#velocity = Vector2(0,0)	                  ## lock moving during recovery
	#
	
## changes velocity of player	
func change_velocity(temp_velocity, temp_acc):
	current_max_speed = temp_velocity
	current_acceleration_time = temp_acc
	

func on_attack_timer_timeout():
	stop_while_attacking = true
	
func on_spin_attack_timer_timeout():
	stop_while_attacking = false
	attack_timer.start()

func _on_animation_player_sword_animation_finished(anim_name):
	is_attacking = false
	is_direction_locked = false 
	current_max_speed = max_speed 
	current_acceleration_time = acceleration_time
