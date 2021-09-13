extends PlayerState

func enter_state(params : Dictionary = {}) -> void:
	print('walk fall')
	
	
func physics_process(delta : float) -> void:
	fsm.velocity.y += GRAVITY
