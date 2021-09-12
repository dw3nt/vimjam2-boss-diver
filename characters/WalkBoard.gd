extends PlayerState

const WALK_SPEED : = 70

var isMoving : bool = false
var moveDir : = Vector2.ZERO


func enter_state(params : Dictionary = {}) -> void:
	pass # play walk anim
	
	
func input(event) -> void:
	if event.is_action_pressed("walk"):
		if !isMoving:
			isMoving = true
		else:
			fsm.change_state("Jump")
	elif event.is_action_pressed("jump"):
		fsm.change_state("Jump")
	
	
func physics_process(delta : float) -> void:
	if isMoving:
		fsm.velocity.x = WALK_SPEED
		
	if !fsm.isOnFloor:
		fsm.velocity.y += GRAVITY
	else:
		fsm.velocity.y = GRAVITY
	
	
func exit_state() -> void:
	moveDir = Vector2.ZERO
	fsm.velocity = Vector2.ZERO
