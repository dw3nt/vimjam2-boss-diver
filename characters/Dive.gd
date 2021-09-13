extends PlayerState

const FORWARD_DIVE_SPEED : float = 100.0
const AIR_RESIST : float = 0.01


func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity.y = params.jumpForce
	fsm.velocity.x = FORWARD_DIVE_SPEED * params.forwardForceScale
	
	
func physics_process(delta : float) -> void:
	fsm.velocity.x = lerp(fsm.velocity.x, 0.0, AIR_RESIST)
	fsm.velocity.y += GRAVITY
