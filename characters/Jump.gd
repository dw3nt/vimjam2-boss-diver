extends PlayerState

const JUMP_FORCE : float = 100.0
const MAX_JUMPS : int = 3

var jumpNumber : int = 1


func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity = Vector2.ZERO
	
	
func physics_process(delta : float) -> void:
	if fsm.isOnFloor:
		fsm.velocity.y = -JUMP_FORCE * jumpNumber
		
		if jumpNumber > MAX_JUMPS:
			fsm.change_state("Dive", { "jumpForce": -JUMP_FORCE * jumpNumber })
			return
			
		jumpNumber += 1
		
	fsm.velocity.y += GRAVITY
		
