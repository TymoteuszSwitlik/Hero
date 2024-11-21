extends Node
class_name EnemyState


signal transitioned(state: EnemyState, new_state_name)

@onready var enemy: Enemy = get_owner()
@onready var sprite_1: Sprite2D = owner.find_child("Body")
@onready var sprite_2: Sprite2D = owner.find_child("Shadow") 
@onready var player: Player = owner.get_parent().find_child("Player")
@onready var health: HealthComp = owner.find_child("HealthComponent")
@onready var anim: AnimationComp = owner.find_child("AnimationComponent")
@onready var draw: DebugDraw = owner.get_parent().find_child("DebugDraw")
@onready var navigation: NavigationAgent = owner.find_child("NavigationAgent") 
@onready var direction_comp: DirectionComp = owner.find_child("DirectionComponent")
@onready var obstacle_detect: ObstacleDetectionComponent = owner.find_child("ObstacleDetectionComponent") 

func _ready():
	health.health_changed.connect(on_damaged)
	health.health_depleted.connect(on_death)
	
func enter():
	pass
	

func process_state(delta):

	pass
	
	
func physics_process_state(delta):
	pass
	

func exit():
	pass
	
	
###########################################
# Non FSM-specific methods 
###########################################

func get_distance_to_player():
	return player.global_position.distance_to(enemy.global_position)
	

func try_chase():
	if get_distance_to_player() <= enemy.detection_radius and obstacle_detect.see_player:
		transitioned.emit(self, "chase")
		return true
		
	return false

func on_damaged(attack):
	transitioned.emit(self, "hurt")
	
func on_death():
	transitioned.emit(self, "death")
