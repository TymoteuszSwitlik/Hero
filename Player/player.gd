extends CharacterBody2D


@export var speed = 20.0

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
		
	else:
		$AnimationTree.get("parameters/playback").travel("Run")
		
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Run/blend_position", velocity)
	

func _physics_process(delta):
	get_input()
	
	
	
	move_and_slide()
