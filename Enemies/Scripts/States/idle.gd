extends EnemyState

@onready var detection = owner.find_child("DetectionRadius")
@onready var progress_bar = owner.find_child("ProgressBar")

var player_detected: bool = false:
	set(value):
		player_detected = value
		detection.set_deferred("disabled", value)
		progress_bar.set_deferred("visible", value)
		
func transition():
	if player_detected:
		get_parent().change_state("Chase")

func _on_player_detection_body_entered(body):
	if body.is_in_group("Player"):
		player_detected = true

## najprawdopodobniej trzeba dodac onbodyexited player_detection = false
