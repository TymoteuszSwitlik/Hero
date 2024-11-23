class_name HurtState
extends EnemyState


var timer : Timer
var pushed_timer : Timer
var current_player_position = Vector2.ZERO
var pushed_force = null


func process_state(delta):
	anim.play_hurt()
	
	
func physics_process_state(delta):
	enemy.move_and_slide()
	
	
func enter():
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.8
	timer.autostart = true
	timer.timeout.connect(on_timer_finished)
	add_child(timer)
	
	pushed_timer = Timer.new()
	pushed_timer.one_shot = true
	pushed_timer.wait_time = 0.5
	pushed_timer.autostart = true
	pushed_timer.timeout.connect(on_pushed_timer_finished)
	add_child(pushed_timer)
	
	pushed()


func pushed():
	pushed_force = enemy.pushed_force
	current_player_position = player.global_position
	enemy.velocity = -(current_player_position - enemy.global_position).normalized() * pushed_force


func on_timer_finished():
	transitioned.emit(self, "wander")

func on_pushed_timer_finished():
	enemy.velocity = Vector2.ZERO



func exit():
	timer.timeout.disconnect(on_timer_finished)
	timer.stop()
	timer.queue_free()
	timer = null
	
	pushed_timer.timeout.disconnect(on_pushed_timer_finished)
	pushed_timer.stop()
	pushed_timer.queue_free()
	pushed_timer = null
