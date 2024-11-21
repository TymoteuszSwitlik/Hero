class_name Enemy
extends CharacterBody2D


@export_group("Enemy Parameters")
@export var wander_speed = 10.0       ## how fast is moving
@export var chase_speed = 20.0        ## how fast is chasing player
@export var attack_speed = 100.0      ## how fast is moving while attacking
@export var max_health = 3            ## how much hp have
@export var pushed_force = 100        ## how much is being pushed
#@export var attack_power = 1         ## how much damage is dealing

@export_group("Vision Ranges") 
@export var detection_radius = 100.0  ## how far sees player                   70
@export var chase_radius = 150.0      ## how far is chasing player            100
@export var attack_radius = 40.0      ## how close player should be to attack  40

var alive: = true


#func on_damaged(attack: Attack) -> void:
	#damaged.emit(attack)	

#connected to enemy_state
#signal damaged(attack: Attack)
#func _on_hitbox_damaged(attack):
		#damaged.emit(attack)	
