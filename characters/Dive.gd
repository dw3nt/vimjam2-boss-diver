extends PlayerState

const FORWARD_DIVE_SPEED : float = 100.0

var inputs : = 0


func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity.y = params.jumpForce
	fsm.velocity.x = FORWARD_DIVE_SPEED * params.forwardForceScale
	
	
func input(event) -> void:
	if event.is_action_pressed("walk") || event.is_action_pressed("jump"):
		inputs += 1
	
	
func physics_process(delta : float) -> void:
	fsm.velocity.x = lerp(fsm.velocity.x, 0.0, AIR_RESIST)
	fsm.velocity.y += GRAVITY
