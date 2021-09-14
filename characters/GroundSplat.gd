extends PlayerState

func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity = Vector2(0, GRAVITY)
	print(fsm.points1 + fsm.points2 + fsm.points3)
	fsm.anim.play("splat")
