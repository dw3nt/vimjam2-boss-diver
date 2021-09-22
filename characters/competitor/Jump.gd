extends Jump

const JUMP_HEIGHT_PERCENTAGES = [0.3, 0.6]

var wasMovingDown : bool = false
var hasCalculatedJump : bool = false

var startY : float
var maxHeightY : float

var inputPercent : float = 0.0
var inputHeight : float = 0.0


func enter_state(params : Dictionary = {}) -> void:
	.enter_state(params)
	startY = global_position.y
	
	
func physics_process(delta : float) -> void:
	.physics_process(delta)
	
	if fsm.velocity.y > 0 && !wasMovingDown:
		hasCalculatedJump = false
		maxHeightY = global_position.y
		inputPercent = rand_range(JUMP_HEIGHT_PERCENTAGES[0], JUMP_HEIGHT_PERCENTAGES[1])
		inputHeight = range_lerp(inputPercent, 0.0, 1.0, maxHeightY, startY)
		
	if fsm.velocity.y > 0 && global_position.y >= inputHeight && !hasCalculatedJump:
		hasCalculatedJump = true
		calculateJumpInput()
	
	wasMovingDown = sign(fsm.velocity.y) > 0
