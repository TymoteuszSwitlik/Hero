extends Node
class_name MovementComp

@onready var enemy: Enemy = get_owner()


## chce zeby tylko tutaj była informacja o poruszaniu się, odepchnieciu, ogłuszeniu, spowolnieniu itd.
## musze wywalic wszystko z stanow i zostawić tam tylko odwołania do tego wezła
## niech stany nie zmieniaja bezposrednio predkosci, tylko niech podaja parametr do funkcji
## a funkcja bedzie decydowac co z tym robimy (zeby dac mozliwosc dodania do predkosci modyfikatorow)   	

var state_velocity = Vector2.ZERO
var push_force = null
var modifyer = Vector2.ZERO



func _physics_process(delta):
	get_velocity()
	enemy.move_and_slide()

func get_velocity():
	pass
