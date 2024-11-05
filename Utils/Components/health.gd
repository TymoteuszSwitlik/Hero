class_name Health
extends  Node


signal health_changed(health: float)

@export var hitbox: Hitbox
@export var animation_player: AnimationPlayer
@export var max_health:= 1

@onready var health:= max_health
@onready var enemy: Enemy = get_owner()

func _ready():
	if hitbox:
		hitbox.damaged.connect(on_damaged)
		
func on_damaged(attack: Attack):
	if !enemy.alive:
		return
	
	health -= attack.damage
	health_changed.emit(health)
	
	if health <= 0:
		health = 0
		enemy.alive = false
		#if animation_player:
			#animation_player.play("Death")
