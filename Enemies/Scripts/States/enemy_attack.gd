extends EnemyState

signal attack_start	
signal attack_end	

@export var attack_speed: = 50.0

var attack_start_timer: Timer
var attack_end_timer: Timer
var action_trigger = false

func enter():
	enemy.velocity = Vector2.ZERO
	
	attack_start_timer = Timer.new()
	attack_start_timer.wait_time = randi_range(2, 4)
	attack_start_timer.timeout.connect(on_attack_start)
	attack_start_timer.autostart = true
	add_child(attack_start_timer)

	attack_end_timer = Timer.new()
	attack_end_timer.wait_time = 0.5
	attack_end_timer.timeout.connect(on_attack_end)
	add_child(attack_end_timer)

func on_attack_start():
	attack_end_timer.start()
	enemy.velocity = (player.global_position - enemy.global_position).normalized() * attack_speed
	
	attack_start_timer.stop()
	
func on_attack_end():
	attack_end.emit()
	enemy.velocity = Vector2.ZERO
	
	attack_end_timer.stop()
	
	transitioned.emit(self, "chase")
	
func process_state(delta: float):
	if attack_start_timer.time_left >= 0.40 and attack_start_timer.time_left <= 0.5 and !action_trigger:
		attack_start.emit()
		
		action_trigger = true
		
	if attack_start_timer.time_left <= 0:
		action_trigger = false
		
	
func physics_process_state(delta: float):
		
	enemy.move_and_slide()
	
