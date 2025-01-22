extends RecoveryAttackState


func process_state(delta):
	anim.play_recovery()

func enter():
	super()
	health.is_parrying = false     
