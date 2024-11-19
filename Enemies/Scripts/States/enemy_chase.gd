extends EnemyState


var direction = Vector2.ZERO
var distance = null
var chase_speed = null


func process_state(delta):
	anim.play_run()

func physics_process_state(delta):
	if get_distance_to_player() > enemy.chase_radius:
		transitioned.emit(self, "wander")
		return

	if get_distance_to_player() <= enemy.attack_radius:
		transitioned.emit(self, "prepare")
		return
		
	enemy.velocity = direction_comp.movement_direction * chase_speed
	enemy.move_and_slide()

func enter():
	chase_speed = enemy.chase_speed
