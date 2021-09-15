extends PlayerState

onready var particles = $Particles2D


func enter_state(params : Dictionary = {}) -> void:
	particles.emitting = true
	print(fsm.points1 + fsm.points2 + fsm.points3)
