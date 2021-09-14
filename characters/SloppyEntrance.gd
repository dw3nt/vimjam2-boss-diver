extends PlayerState

onready var particles = $Particles2D


func enter_state(params : Dictionary = {}) -> void:
	particles.emitting = true
