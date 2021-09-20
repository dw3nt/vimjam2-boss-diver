extends WalkBoard


func input(event) -> void:
	if event.is_action_pressed("walk") && !isMoving:
		isMoving = true
		fsm.anim.play("walk")
		audioTimer.start()
	elif event.is_action_pressed("jump"):
		fsm.change_state("Jump")
