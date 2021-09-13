extends PlayerState

func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity = Vector2(0, GRAVITY)
