extends PlayerState

func enter_state(params : Dictionary = {}) -> void:
	print('grace')
	print(fsm.points1 + fsm.points2 + fsm.points3)
