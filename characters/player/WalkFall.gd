extends PlayerState

func enter_state(params : Dictionary = {}) -> void:
	fsm.anim.play("walk-fall", -1, 1.5)
	
	
func physics_process(delta : float) -> void:
	fsm.velocity.y += GRAVITY
	fsm.velocity.x = lerp(fsm.velocity.x, 0.0, AIR_RESIST)
	
	
func enteredPool() -> bool:
	fsm.change_state("SloppyEntrance")
	return true