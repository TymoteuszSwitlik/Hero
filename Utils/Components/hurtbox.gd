class_name Hurtbox
extends Node

#signal hit_enemy 

@onready var weapon: Weapon = get_parent()


func _ready():
	print("lalala")

func _on_area_entered(area: Area2D):
	if area is Hitbox:
		var attack:= Attack.new()
		
		attack.damage = weapon.damage
		attack.push_force = weapon.push_force
		#attack.pivot = 
		area.take_damage(attack)
		#hit_enemy.emit()
