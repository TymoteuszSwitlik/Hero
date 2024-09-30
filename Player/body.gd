extends Node2D

func play_idle_animation_right():
	$AnimationPlayer.play("IdleRight")
	
func play_idle_animation_left():
	$AnimationPlayer.play("IdleLeft")

func play_run_animation_right():
	$AnimationPlayer.play("RunRight")	
	
func play_run_animation_left():
	$AnimationPlayer.play("RunLeft")	

#func play_attack_animation_right():
	#$AnimationPlayer.play("AttackRight")	
	#
#func play_attack_animation_left():
	#$AnimationPlayer.play("AttackLeft")	
