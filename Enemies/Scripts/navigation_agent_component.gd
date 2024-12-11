class_name NavigationAgent
extends NavigationAgent2D

@onready var target: Player = get_tree().get_first_node_in_group("Player") #pewnie do zmiany przy dodaniu coopa
@onready var enemy: Enemy = get_owner()

var current_agent_position = Vector2.ZERO
var next_path_position = Vector2.ZERO
var physics_is_going = false


func _ready():
	set_physics_process(false)
	avoidance_enabled = false
	

func _physics_process(delta):
	if target:
		self.target_position = target.global_position
		
	if self.is_navigation_finished():
		return
	
	current_agent_position = enemy.global_position	
	next_path_position = self.get_next_path_position()
		
		
func enter():
	#self.debug_enabled = true     ## debug
	if !physics_is_going:
		physics_is_going = true
		set_physics_process(true)
	avoidance_enabled = true
		
func exit():
	#self.debug_enabled = false    ## debug
	if physics_is_going:
		physics_is_going = false
		set_physics_process(false)
	avoidance_enabled = false
