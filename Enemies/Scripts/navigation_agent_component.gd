class_name NavigationAgent
extends NavigationAgent2D

@onready var target: Player = get_tree().get_first_node_in_group("Player") 
@onready var enemy: Enemy = get_owner()

var current_agent_position = Vector2.ZERO
var next_path_position = Vector2.ZERO
var physics_is_going = false


func _ready():
	#call_deferred("get_target")
	set_physics_process(false)

func _physics_process(delta):
	if target:
		self.target_position = target.global_position
		
	if self.is_navigation_finished():
		return
	
	current_agent_position = enemy.global_position	
	next_path_position = self.get_next_path_position()
	#velocity = current_agent_position.direction_to(next_path_position) * speed	
	
## najpewniej bede chciał wywołąc te funkcje w chase_state when see_player = false
#func get_target():
	#await get_tree().physics_frame
	#if target:
		#self.target_position = target.global_position
		
func enter():
	#self.debug_enabled = true     ## debug
	if !physics_is_going:
		physics_is_going = true
		set_physics_process(true)
	
		
func exit():
	#self.debug_enabled = false    ## debug
	if physics_is_going:
		physics_is_going = false
		set_physics_process(false)
