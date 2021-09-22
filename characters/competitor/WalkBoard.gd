extends WalkBoard

const WALK_DISTANCES = [55.0, 65.0]

var isCheckingDistance : = true
var goalX : float

onready var moveTimer = $MoveTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	moveTimer.start()
	goalX = rand_range(WALK_DISTANCES[0], WALK_DISTANCES[1]) + global_position.x
	
	
func physics_process(delta : float) -> void:	
	.physics_process(delta)
	
	if isCheckingDistance && global_position.x >= goalX:
		fsm.change_state("Jump")
		isCheckingDistance = false


func _on_MoveTimer_timeout():
	startMoving()
