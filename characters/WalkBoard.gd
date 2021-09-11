extends PlayerState

const WALK_SPEED : = 70

var isMoving : bool = false
var moveDir : = Vector2.ZERO


func enter_state(params : Dictionary = {}) -> void:
	pass # play walk anim
	
	
func input(event) -> void:
	if event.is_action_pressed("walk"):
		if !isMoving:
			moveDir = Vector2.RIGHT
			isMoving = true
		else:
			fsm.change_state("Jump")
	
	
func physics_process(delta : float) -> void:
	fsm.velocity = moveDir * WALK_SPEED
	
	
func exit_state() -> void:
	moveDir = Vector2.ZERO
	fsm.velocity = Vector2.ZERO
