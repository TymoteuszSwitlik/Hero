class_name HealthComp
extends  Node


signal health_changed(health: float, attack: Attack)
signal health_depleted(attack: Attack)
signal parried(attack: Attack)

#@export var hitbox: Hitbox
@onready var enemy: Enemy = get_owner()
@onready var raycast: ObstacleDetectionComponent = owner.find_child("ObstacleDetectionComponent")
@onready var hitbox: Hitbox = owner.find_child("Hitbox")

var health = 1.0
var can_take_damage = false
var is_parrying = false



func _ready():
	health = enemy.max_health
	if hitbox:
		hitbox.damaged.connect(on_damaged)
		
	
func is_can_take_damage(attack: Attack):
	if !raycast.see_player:        # if there is wall between player and enemy
		can_take_damage = false
	else:
		if !is_parrying:
			can_take_damage = true
		else:
			can_take_damage = false
			parried.emit(attack)
		
func on_damaged(attack: Attack):
	if !enemy.alive:
		return
	
	is_can_take_damage(attack)
	
	if can_take_damage:		
		health -= attack.damage
		
		if health <= 0:
			health = 0
			enemy.alive = false
			health_depleted.emit(attack)
		else:
			health_changed.emit(health, attack)
