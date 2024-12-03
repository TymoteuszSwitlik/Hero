extends Enemy

@export_group("Enemy Parameters")
@export var wander_speed = 10.0       ## how fast is moving
@export var chase_speed = 20.0        ## how fast is chasing player
@export var attack_speed = 100.0      ## how fast is moving while attacking
@export var max_health = 3            ## how much hp have
@export var pushed_force = 100        ## how much is being pushed
#@export var attack_power = 1         ## how much damage is dealing

@export_group("Vision Ranges") 
@export var detection_radius = 90.0  ## how far sees player                   70
@export var chase_radius = 100.0      ## how far is chasing player            100
@export var attack_radius = 80.0      ## how close player should be to attack  40
