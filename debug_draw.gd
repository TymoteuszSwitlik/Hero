class_name DebugDraw
extends Node2D

@onready var player: Player = owner.find_child("Player")

var current_player_position = Vector2.ZERO
var lock = true
var direction = Vector2.ZERO
var pla = Vector2.ZERO
var sli: Array[Vector2] = []
var push_distance: Array[Vector2] = []
var enemies = []
var alive = []


func _ready():
	
	enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		push_distance.append(Vector2.ZERO)
		sli.append(Vector2.ZERO)
		alive.append(true)
	#print(enemies.size())
	#print(enemies[3])

func _process(delta):
	pla = player.global_position
	var cnt =1
	
	for enemy in enemies:
		#print(cnt)
		if is_instance_valid(enemies[cnt-1]):
		#if alive[cnt-1]:
			if !enemy.alive:
				alive[cnt-1] = false
				
			sli[cnt-1] = enemy.global_position
			direction = (pla - sli[cnt-1]).normalized() * 20
			push_distance[cnt-1] = (sli[cnt-1] - direction)
			
		
		cnt = cnt + 1
		if cnt == enemies.size()+1:
			cnt = 1
	
		#else:
			#slime_is_living = false
				
	queue_redraw()
	
func draw_current_position(position):
	lock = false
	current_player_position = position
	queue_redraw()

func erease():
	lock = true
	queue_redraw()

func _draw():
	#if slime_is_living:
	var cnt = 1
	
	for enemy in enemies:
		if alive[cnt-1]:
			## push direction
			#draw_dashed_line(enemy.global_position, push_distance[cnt-1], Color.RED, 1)
			## moving direction
			var moving_direction = enemy.global_position + enemy.velocity.normalized() * 20
			#draw_dashed_line(enemy.global_position, moving_direction, Color.YELLOW, 1)
		
		cnt = cnt + 1
		if cnt == enemies.size()+1:
			cnt = 1
	
	if !lock:
		draw_circle(current_player_position, 2, Color.RED)
