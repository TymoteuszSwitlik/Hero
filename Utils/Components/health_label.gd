extends Label

@onready var enemy: Enemy = get_owner()


func _ready():
	text = str(enemy.max_health)

func _on_health_health_changed(new_health: float):	
	text = str(new_health)


func _on_health_health_depleted():
	text = str(0)
	var tween = create_tween()
		
	tween.tween_property(self, "modulate:a", 0, 3)
