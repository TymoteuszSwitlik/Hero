extends Node
class_name EnemyState

@onready var player = owner.get_parent().find_child("Player")
@onready var debug = owner.find_child("Debug")
@onready var anim = owner.find_child("AnimationPlayer")


func _ready():
	set_physics_process(false)
	
func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transition():
	pass
	
func _physics_process(delta):
	transition()
	debug.text = name
