class_name DeathState
extends EnemyState

var timer : Timer
var pushed_timer : Timer
var current_player_position = Vector2.ZERO
var pushed_force = null


#func physics_process_state(delta):       ## do usuniecia
	#enemy.move_and_slide()
	
func enter():
	enemy.collision_layer =  0b1000
	enemy.collision_mask =  0b0001
	print("collisionmask: ", enemy.collision_mask)
	anim.play_death()
	#enemy.alive = false
	
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

	#pushed()                # to też


#func pushed():               #do usuniecia
	#pushed_force = enemy.pushed_force
	#current_player_position = player.global_position
	#enemy.velocity = -(current_player_position - enemy.global_position).normalized() * pushed_force


func on_timer_finished():
	timer.timeout.disconnect(on_timer_finished)
	timer.stop()
	timer.queue_free()
	timer = null
	
func on_pushed_timer_finished():	
	pushed_timer.timeout.disconnect(on_pushed_timer_finished)
	pushed_timer.stop()
	pushed_timer.queue_free()
	pushed_timer = null
	enemy.velocity = Vector2.ZERO



	if sprite_1:
		var tween_1 = create_tween()
		var tween_2 = create_tween()
		
		tween_1.tween_property(sprite_1, "modulate:a", 0, 3)
		tween_2.tween_property(sprite_2, "modulate:a", 0, 3)
		
		tween_1.tween_callback(enemy.queue_free)
		
