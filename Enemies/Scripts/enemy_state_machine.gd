extends Node



@onready var debug = owner.find_child("Debug")

var initial_state: EnemyState
var current_state: EnemyState 
var states: Dictionary = {}



func get_current_state():
	return current_state


func _ready():
	for child in get_children():
		if child is EnemyState:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	
	## randomize initial_state		
	var state_keys = [states.idle, states.wander]
	initial_state = state_keys[randi() % state_keys.size()]
	
	if initial_state:
		current_state = initial_state
		current_state.enter()
			
func _process(delta):
	if current_state:
		current_state.process_state(delta)
			
			
func _physics_process(delta):
	if current_state:
		current_state.physics_process_state(delta)
		debug.text = current_state.name
			
			
func on_child_transition(state: EnemyState, new_state_name):
	if state != current_state:
		return
			
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	
