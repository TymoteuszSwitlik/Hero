extends Label


func _on_health_health_changed(new_health: float):	
	text = str(new_health)
