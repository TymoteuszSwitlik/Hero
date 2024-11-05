class_name Enemy
extends CharacterBody2D


#connected to enemy_state
signal damaged(attack: Attack)

#@export_group("Vision Ranges")
#@export var detection_radius := 10.0
#@export var chase_radius := 20.0
#@export var follow_radius := 2.5

var alive: = true



func on_damaged(attack: Attack) -> void:
	damaged.emit(attack)	


### po umarciu ma przestac sie ruszac i cos tam. dodanie animacji odpowiednich


func _on_hitbox_damaged(attack):
		damaged.emit(attack)	
