extends PrepareAttackState

@onready var fsm = $".."

var is_staring = false   # trigger to stop and stare for a while


func process_state(delta):
	if !is_staring:            # if not is_staring he keep his guard
		anim.play_prepare()
	else:                      # and if is_staring than he is vulnerable
		anim.play_idle() 

func physics_process_state(delta):
	if !is_staring:
		check_if_player_is_in_front()  
	else:
		health.is_parrying = false
	
func enter():         
	super()
	is_staring = false
	if randi_range(0, 2) == 0:           # 33% chance to stop and stare (0, 2)
		is_staring = true
		
	movement_comp.end_parry.connect(on_parry_timeout)
	health.parried.connect(block_state_change)

func check_if_player_is_in_front():        # to parry if player is in front
	if direction_comp.is_player_in_front:
		health.is_parrying = true
	else:
		health.is_parrying = false
		
func on_timeout():
	#print("timer_timeout GOBLIN_PREPARE  atak")
	if !obstacle_detect.see_player:
		health.is_parrying = false
		transitioned.emit(self, "recovery")
	else:
		transitioned.emit(self, "attack")


func on_parry_timeout():
	#print("parry_timeout GOBLIN_PREPARE  blok", fsm.current_state.name)
	if get_distance_to_player() > enemy.attack_radius:
		transitioned.emit(self, "recovery")
		return
	else:
		transitioned.emit(self, "attack")
		return	
		
func block_state_change(attack: Attack):
	prepare_timer.stop()
	
	
	
func exit():
	super()
	movement_comp.end_parry.disconnect(on_parry_timeout)
	health.parried.disconnect(block_state_change)
## gdy zostanie zablokowany cios niech sprawdza czy gracz jest w zasiegu, jezeli tak to atak, jezeli nie to recovery
