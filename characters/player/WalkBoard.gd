extends WalkBoard


func input(event) -> void:
	if event.is_action_pressed("walk") && !isMoving:
		startMoving()
	elif event.is_action_pressed("jump"):
		fsm.change_state("Jump")
