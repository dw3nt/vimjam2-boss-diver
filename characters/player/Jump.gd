extends Jump


func input(event) -> void:
	if Input.is_action_pressed("jump") && accurateInput == -1:
		if boardInRange && fsm.velocity.y >= 0:
			accurateInput = 1
			var yDiff = boardPosition.y - global_position.y
			accuracy = range_lerp(yDiff, boardHeight, boardDetectHeight, maxJumpScale, 0)
			jumpScale += accuracy
		else:
			accurateInput = 0
