extends Jump

const JUMP_TIMES : = [0.2, 0.4]

onready var jumpTimer = $JumpTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	.enter_state(params)
	jumpTimer.start(rand_range(JUMP_TIMES[0], JUMP_TIMES[1]) * jumpNumber)


func _on_JumpTimer_timeout() -> void:
	calculateJumpInput()
	jumpTimer.start(rand_range(JUMP_TIMES[0], JUMP_TIMES[1]) * jumpNumber)
	
	
func exit_state() -> void:
	.exit_state()
	jumpTimer.stop()
