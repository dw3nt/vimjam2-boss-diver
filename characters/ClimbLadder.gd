extends PlayerState

const CLIMB_SPEED : = 100

var pathFollow : PathFollow2D


func enter_state(params : Dictionary = {}) -> void:
	fsm.anim.play("idle")
	
	
func process(delta : float) -> void:
	if pathFollow.unit_offset < 1.0:
		pathFollow.offset += CLIMB_SPEED * delta
	else:
		fsm.change_state("WalkBoard")
