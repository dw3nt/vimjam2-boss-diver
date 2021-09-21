extends Jump


func input(event) -> void:
	if Input.is_action_pressed("jump") && accurateInput == -1:
		calculateJumpInput()
