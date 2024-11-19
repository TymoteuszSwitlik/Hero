class_name Health
extends  Node


signal health_changed(health: float)
signal health_depleted()
@export var hitbox: Hitbox

@onready var enemy: Enemy = get_owner()

var health = 1.0

func _ready():
	health = enemy.max_health
	if hitbox:
		hitbox.damaged.connect(on_damaged)
		
func on_damaged(attack: Attack):
	if !enemy.alive:
		return
	
	health -= attack.damage
	
	if health <= 0:
		health = 0
		enemy.alive = false
		health_depleted.emit()
	else:
		health_changed.emit(health)
