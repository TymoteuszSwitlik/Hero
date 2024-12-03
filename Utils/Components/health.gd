class_name HealthComp
extends  Node


signal health_changed(health: float)
signal health_depleted()

#@export var hitbox: Hitbox
@onready var enemy: Enemy = get_owner()
@onready var raycast: ObstacleDetectionComponent = owner.find_child("ObstacleDetectionComponent")
@onready var hitbox: Hitbox = owner.find_child("Hitbox")

var health = 1.0
var can_take_damage = false



func _ready():
	health = enemy.max_health
	if hitbox:
		hitbox.damaged.connect(on_damaged)
		
		
func on_damaged(attack: Attack):
	if !enemy.alive:
		return
	
	if !raycast.see_player:
		can_take_damage = false
	else:
		can_take_damage = true
	
	if can_take_damage:		
		health -= attack.damage
		
		if health <= 0:
			health = 0
			enemy.alive = false
			health_depleted.emit()
		else:
			health_changed.emit(health)
