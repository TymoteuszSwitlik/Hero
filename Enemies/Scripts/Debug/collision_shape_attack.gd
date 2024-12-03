extends DebugDistanceRadius


func set_shape_properities():
	collisionshape.shape.radius = enemy.attack_radius 	
	collisionshape.debug_color = Color.RED
	collisionshape.debug_color.a = 0.01

	#print(enemy.detection_radius)
	
	
	
