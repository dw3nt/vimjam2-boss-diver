extends DiverState
class_name WalkBoard

const WALK_SPEED : = 70

var changeToWalkFall : bool = false
var isMoving : bool = false
var moveDir : = Vector2.ZERO

onready var climbAudio = $WalkAudio as AudioStreamPlayer
onready var audioTimer = $AudioTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	pass
	
	
func physics_process(delta : float) -> void:
	if isMoving:
		fsm.velocity.x = WALK_SPEED
		
	if !fsm.isOnFloor:
		fsm.velocity.y += GRAVITY
		if fsm.velocity.y > GRAVITY * 2:
			changeToWalkFall = true
			fsm.change_state("WalkFall")
	else:
		fsm.velocity.y = GRAVITY
	
	
func exit_state() -> void:
	if !changeToWalkFall:
		moveDir = Vector2.ZERO
		fsm.velocity = Vector2.ZERO
		
	climbAudio.stop()
	audioTimer.stop()


func _on_AudioTimer2_timeout():
	climbAudio.play()
