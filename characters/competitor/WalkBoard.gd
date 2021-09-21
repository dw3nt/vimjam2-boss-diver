extends WalkBoard

const JUMP_TIMES : = [ 0.45, 0.85 ]

onready var moveTimer = $MoveTimer as Timer
onready var jumpTimer = $JumpTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	moveTimer.start()


func _on_MoveTimer_timeout():
	startMoving()
	jumpTimer.start(rand_range(JUMP_TIMES[0], JUMP_TIMES[1]))


func _on_JumpTimer_timeout():
	fsm.change_state("Jump")
