extends PlayerState

const JUMP_FORCE : float = 40.0
const MAX_JUMPS : int = 3

var maxJumpScale : = 0.0

var boardInRange : bool = false
var boardPosition : Vector2 = Vector2.ZERO
var boardHeight : float = -1.0
var boardDetectHeight : float = -1.0

var accurateInput : int = 1
var accuracy : float = 0.0

var jumpNumber : int = 1
var jumpScale : float = 0.0


func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity = Vector2.ZERO
	var xDiff = global_position.x - boardPosition.x
	if xDiff < 0:
		fsm.change_state("JumpFall")
	else:
		maxJumpScale = range_lerp(xDiff, 0.0, 40.0, 0.15, 1.0)
		jumpScale += maxJumpScale
	
	
func input(event) -> void:
	if Input.is_action_pressed("jump") && accurateInput == -1:
		if boardInRange && fsm.velocity.y >= 0:
			accurateInput = 1
			var yDiff = boardPosition.y - global_position.y
			accuracy = range_lerp(yDiff, boardHeight, boardDetectHeight, maxJumpScale, 0)
			jumpScale += accuracy
		else:
			accurateInput = 0
	
	
func physics_process(delta : float) -> void:
	if fsm.isOnFloor && accurateInput < 1:
		fsm.change_state("JumpFall")
	elif fsm.isOnFloor && accurateInput == 1:
		fsm.velocity.y = -JUMP_FORCE * jumpScale
		
		if jumpNumber > MAX_JUMPS:
			fsm.change_state("Dive", { "jumpForce": -JUMP_FORCE * jumpNumber, "forwardForceScale": maxJumpScale })
			return
			
		jumpNumber += 1
		accurateInput = -1
		accuracy = 0.0
		
	fsm.velocity.y += GRAVITY
		
