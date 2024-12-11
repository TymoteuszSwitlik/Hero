extends PrepareAttackState


func physics_process_state(delta):
	check_if_player_is_in_front()
	

func check_if_player_is_in_front():
	if direction_comp.is_player_in_front:
		health.is_parrying = true
	else:
		health.is_parrying = false
		
func on_timeout():
	if !obstacle_detect.see_player:
		health.is_parrying = false
		transitioned.emit(self, "recovery")
	else:
		transitioned.emit(self, "attack")
