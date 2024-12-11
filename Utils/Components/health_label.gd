extends Label

@onready var enemy: Enemy = get_owner()
@onready var health: HealthComp = owner.find_child("HealthComponent")

func _ready():
	text = str(enemy.max_health)
	if health:
		health.health_changed.connect(_on_health_health_changed)
		health.health_depleted.connect(_on_health_health_depleted)

func _on_health_health_changed(new_health: float, attack: Attack):	
	text = str(new_health)

func _on_health_health_depleted():
	text = str(0)
	var tween = create_tween()
		
	self.modulate.a = 0 
	#tween.tween_property(self, "modulate:a", 0, 3)
