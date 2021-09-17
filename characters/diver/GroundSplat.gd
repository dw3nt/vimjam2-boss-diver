extends DiverState

func enter_state(params : Dictionary = {}) -> void:
	fsm.sprite.rotation_degrees = 0
	fsm.velocity = Vector2(0, GRAVITY)
	fsm.anim.play("splat")
