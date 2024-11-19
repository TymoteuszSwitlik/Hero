extends Node2D

@onready var player = owner.find_child("Player")
@onready var slime = owner.find_child("Slime")

var current_player_position = Vector2.ZERO
var lock = true
var direction = Vector2.ZERO
var pla = Vector2.ZERO
var sli = Vector2.ZERO
var distance = Vector2.ZERO
var slime_is_living = true

func _process(delta):
	if slime_is_living:
		if slime.alive:
			pla = player.global_position
			sli = slime.global_position
			direction = (pla - sli).normalized() * 20
			distance = (sli - direction)
		else:
			slime_is_living = false
			
	queue_redraw()
	
func draw_current_position(position):
	lock = false
	current_player_position = position
	queue_redraw()

func erease():
	lock = true
	queue_redraw()

func _draw():
	if slime_is_living:
		if slime.alive:
			#draw_circle(global_position, 1, Color.BLUE)
			#draw_circle(player.global_position, 1, Color.BLUE)
			#draw_circle(slime.global_position, 1, Color.BLUE)
			draw_dashed_line(slime.global_position, distance, Color.RED, 1)
	
	if !lock:
		draw_circle(current_player_position, 2, Color.RED)
