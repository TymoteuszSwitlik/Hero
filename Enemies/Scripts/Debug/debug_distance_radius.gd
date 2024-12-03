class_name DebugDistanceRadius
extends Area2D

@onready var enemy: Enemy  = get_owner()
var collisionshape: CollisionShape2D


func _ready():
	collisionshape = CollisionShape2D.new()
	collisionshape.shape = CircleShape2D.new()
	add_child(collisionshape)

	call_deferred("set_shape_properities")
	#collisionshape.shape.radius = enemy.attack_radius
	#print("enemy: ", enemy.name, ", enemy_attack: ", enemy.attack_radius, ", radius: ", collisionshape.shape.radius)

func set_shape_properities():
	pass
