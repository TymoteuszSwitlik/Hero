class_name MovementComp
extends Node

@onready var enemy: Enemy = get_owner()
@onready var health: HealthComp = owner.find_child("HealthComponent")
@onready var player: Player = get_tree().get_first_node_in_group("Player")

signal end_parry()


## chce zeby tylko tutaj była informacja o poruszaniu się, odepchnieciu, ogłuszeniu, spowolnieniu itd.
## musze wywalic wszystko z stanow i zostawić tam tylko odwołania do tego wezła
## niech stany nie zmieniaja bezposrednio predkosci, tylko niech podaja parametr do funkcji
## a funkcja bedzie decydowac co z tym robimy (zeby dac mozliwosc dodania do predkosci modyfikatorow)   	
var push_timer: Timer
var main_velocity = Vector2.ZERO
var state_velocity = Vector2.ZERO
var previous_state_velocity = Vector2.ZERO
var modifyer = Vector2.ZERO
var push_force = null
var block_velocity = false


func _ready():
	health.health_changed.connect(on_damaged)
	health.health_depleted.connect(on_death)
	health.parried.connect(on_parry)
	
	push_timer = Timer.new()
	push_timer.wait_time = 0.5 #0.5
	push_timer.timeout.connect(on_timeout)
	push_timer.autostart = false
	push_timer.one_shot = true
	add_child(push_timer)

func _physics_process(delta):
	get_velocity()
	enemy.move_and_slide()
	
func get_velocity():
	if !block_velocity:                   ## during parrying velocity should not change even if state changed
		main_velocity = state_velocity
	
	enemy.velocity = main_velocity
	

func on_damaged(new_health: float, attack: Attack):
	pushed(attack)
	
func on_death(attack: Attack):
	pushed(attack)

func on_parry(attack: Attack):
	
	attack.push_force = attack.push_force / 4
	pushed(attack)



func on_timeout():               ## return enemy.velocity to previous state
	end_parry.emit()
	block_velocity = false
	state_velocity = previous_state_velocity
	
	
func pushed(attack: Attack):     ## push enemy in opposed direction than player
	block_velocity = true
	main_velocity = -(enemy.global_position.direction_to(player.global_position) * attack.push_force)
	push_timer.start()
