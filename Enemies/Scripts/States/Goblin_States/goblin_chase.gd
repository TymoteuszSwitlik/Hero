class_name GoblinChaseState
extends ChaseState

var is_going_around = false                                           ## if true goblin velocity is angular
var going_around_condition_trigger = false                            ## if true goblin cant try to go around
#var going_around_condition_trigger_2 = false                          ##
var test = false
var test_transition = false
											## if false blocks transitioning to another state
var angular_direction = 0
var angular_distance_trigger = 0
var angular_distance_trigger_2 = 0
var point_around_player = Vector2.ZERO
var offset = Vector2.ZERO
var current_around_player_position = Vector2.ZERO
var around_direction_timer: Timer                                     ## timer to try going around
var cnt_going_around = 0                                              ## makes sure that second going around is triggered only once 
#var cnt_can_transition = 0                                            ## makes sure that goblin is facing player after circleing
var cnt_test = 0                                            ## makes sure that goblin is facing player after circleing

## NIEKONIECZNIE CHCE TO NADPISAC 
#func physics_process_state(delta):
	#try_transition() ##jak to gowno zablokowac i kiedy
	#get_velocity()

## i jeszce niech ma mozliwosc wycofania sie do drugiej lini np. gdy mu się konczy zycie???

func physics_process_state(delta):
	get_velocity()
	
	
		
	try_transition()
		
		


func enter():
	super()
	print("NOWY CHASE")
	#cnt_going_around = 0
	
	is_going_around = false
	going_around_condition_trigger = false
	###can_transition = true        
	
	angular_distance_trigger = randi_range(45, 65)
	angular_distance_trigger_2 = randi_range(30, 40)
	#print("odległosc 1: ", angular_distance_trigger)
	#print("odleglosc 2: ", angular_distance_trigger_2)
	
	## how long is going around timer
	around_direction_timer = Timer.new()
	around_direction_timer.one_shot = true
	get_around_direction_timer_wait_time()
	
	around_direction_timer.timeout.connect(on_around_direction_timeout)
	around_direction_timer.autostart = false
	add_child(around_direction_timer)
	
	
		

func get_velocity():
	if !going_around_condition_trigger and get_distance_to_player() <= angular_distance_trigger:
		going_around_condition_trigger = true
		try_going_around()
		print("dalsze okrążenie")
		print("czas okrążania: ", around_direction_timer.wait_time)
		#print("counter: ", cnt_going_around)
	
	### try second going around
	if get_distance_to_player() <= angular_distance_trigger_2 and cnt_going_around == 0:
		print("bliższe okrązenie")
		cnt_going_around = cnt_going_around + 1
		#around_direction_timer.wait_time = 1   ##to nie to miejsce
		going_around_condition_trigger = false
	
	## going normaly
	if !is_going_around:
		var last_follow_type = follow_type
		
		## follow player 
		if obstacle_detect.see_player and can_follow_player:
			follow_type = true                  ## is following player
			
			follow_player()
			#
			#navigation.exit()                   ## stop nav_agent physics process
			#movement_comp.state_velocity = direction_comp.movement_direction.rotated(rand_chase_direction) * enemy.chase_speed
		#
		
		
		## follow nav_agent (path to player)
		else:
			if follow_type:                     ## once after changing from follow player
				can_follow_player = false       ## stop allowing to follow player
			follow_type = false                 ## is following nav_agent
			
			follow_nav()
			
			#navigation.enter()                  ## start nav_agent physics process
			#call_deferred("follow_path")
		
		if last_follow_type != follow_type and !follow_type:   ## once after changing from follow player to follow nav_agent
			follow_path_timer.start()	                       ## start timer so after 1s again allow to follow player
			
	## going around player
	else:
		follow_circle()
		#print("CHODZE DOOKOLA LALALA GOBLIN CHASE")
		#var direction_to_player = enemy.global_position.direction_to(current_around_player_position)
		#var tangential_direction = Vector2(-direction_to_player.y, direction_to_player.x)
	#
		#movement_comp.state_velocity = tangential_direction * angular_direction * enemy.chase_speed


func follow_player():
	if obstacle_detect.see_player and can_follow_player:
			navigation.exit()                   ## stop nav_agent physics process
			movement_comp.state_velocity = direction_comp.movement_direction.rotated(rand_chase_direction) * enemy.chase_speed


func follow_nav():
			navigation.enter()                  ## start nav_agent physics process
			call_deferred("follow_path")


func follow_circle():
	var direction_to_player = enemy.global_position.direction_to(current_around_player_position)
	var tangential_direction = Vector2(-direction_to_player.y, direction_to_player.x)
	
	movement_comp.state_velocity = tangential_direction * angular_direction * enemy.chase_speed


func try_transition():
	if get_distance_to_player() > enemy.chase_radius:
		transitioned.emit(self, "wander")
		return
		
		
	## CHCE ZEBY PO ZAKONCZENIU OKRAZANIA JESZCZE NA CHWILE SZEDL W STRONE GRACZA COBY PATRZYL NA NIEGO A NIE W BOK	
		
	if test:
		cnt_test = cnt_test + 1 
		if cnt_test == 4:
			test = false			
		
		
	if !is_going_around:       ### DO PRZETESTOWANIA CZY ABY NA PEWNO MA NIE ZMIENIAC STANU ?? ###
		if get_distance_to_player() <= enemy.attack_radius and obstacle_detect.see_player:
			transitioned.emit(self, "prepare")
			return	


func try_going_around():
	#print("zablokowane probowanie okrazania GOBLIN CHASE")
	if randi_range(0, 2) == 0:                                              # 33% chance to start going around (0, 1)
		current_around_player_position = player.global_position             # save current player position
		angular_direction = -1 if randf() < 0.5 else 1                      # -1 clockwise, 1 counterclockwise
		
		around_direction_timer.start()                                      # start going around timer
		#print("czas chodzenia dookola: ", around_direction_timer.time_left,  "      GOBLIN CHASE")
		
		is_going_around = true                                              # set to start circular movement

	#else:                                                                   # 50% chance to keep going towards player
		#print("nie dookołą   GOBLIN CHASE")
		

func get_around_direction_timer_wait_time():	## warunrk ktory ma zmieniac wait_time w zaleznosci od blisksci do gracza
	#around_direction_timer.wait_time = randi_range(1, 5) ## DO STESTOWANIA
	#around_direction_timer.wait_time = 3 ## DO STESTOWANIA                     ## +/- 5s = 180, 3s = 90, 
	
	if get_distance_to_player() >= angular_distance_trigger:
		around_direction_timer.wait_time = randf_range(3, 5)
	else:
		around_direction_timer.wait_time = randf_range(1, 3)


func on_around_direction_timeout():
	#print("KONIEC CHODZENIA DOOKOLA")
	is_going_around = false
	get_velocity()
	cnt_going_around = 0
