extends EnemyState

var current_player_position = Vector2.ZERO
var attack_prepare_timer: Timer
var attack_action_timer: Timer
var cnt = 0
var attack_speed = null


func process_state(delta):
	anim.play_attack()
	
func physics_process_state(delta):
	enemy.move_and_slide()

func enter():


	anim.attack_direction_unlock() # zeruje warunki pobierania kierunku w celu zablokowania kierunku animacji 
	attack_speed = enemy.attack_speed
	current_player_position = player.global_position
	
	draw.draw_current_position(current_player_position) ## debug ##
	
	clear_timers()
	attack_prepare_timer = Timer.new()
	attack_prepare_timer.one_shot = true
	attack_prepare_timer.wait_time = 0.4
	attack_prepare_timer.timeout.connect(on_prepare_timeout)
	attack_prepare_timer.autostart = true
	add_child(attack_prepare_timer)
		

func on_prepare_timeout():
	attack_action_timer = Timer.new()
	attack_action_timer.one_shot = true
	attack_action_timer.wait_time = 0.5
	attack_action_timer.timeout.connect(on_action_timeout)
	attack_action_timer.autostart = true
	add_child(attack_action_timer)
	
	enemy.velocity = (current_player_position - enemy.global_position).normalized() * attack_speed
	
func on_action_timeout():
	enemy.velocity = Vector2.ZERO
	transitioned.emit(self, "recovery")

func exit():
	clear_timers()
	draw.erease()  ## debug ##

func clear_timers():
	if attack_prepare_timer:
		attack_prepare_timer.timeout.disconnect(on_prepare_timeout)
		attack_prepare_timer.stop()
		attack_prepare_timer.queue_free()
		attack_prepare_timer = null
	if attack_action_timer:
		attack_action_timer.timeout.disconnect(on_action_timeout)
		attack_action_timer.stop()
		attack_action_timer.queue_free()
		attack_action_timer = null
