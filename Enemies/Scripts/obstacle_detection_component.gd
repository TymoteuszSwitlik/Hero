class_name ObstacleDetectionComponent
extends RayCast2D

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var enemy: Enemy = get_owner()

var see_player = false
var cnt = 0


func _physics_process(delta):
	var distance_to_player = enemy.global_position.distance_to(player.global_position)
	
	if distance_to_player < enemy.detection_radius +10:
		self.enabled = true
	if distance_to_player < enemy.chase_radius and self.enabled:
		#self.enabled = true
		self.target_position = player.global_position - self.global_position 
		if self.is_colliding():
			see_player = false
		else:
			print(is_colliding())
			see_player = true
	else:
		self.enabled = false
	
	cnt = cnt +1
	print(cnt, " ", see_player, "  is_colliding ", is_colliding())
		
