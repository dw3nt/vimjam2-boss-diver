extends Dive


func input(event) -> void:
	if canInput && event.is_action_pressed("walk") || event.is_action_pressed("jump"):
		strikePose()
