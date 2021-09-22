extends DiverState
class_name Jump

const JUMP_FORCE : float = 40.0
const MAX_JUMPS : int = 3

var maxJumpScale : = 0.0

var boardInRange : bool = false
var boardPosition : Vector2 = Vector2.ZERO
var boardHeight : float = -1.0
var boardDetectHeight : float = -1.0

var accurateInput : int = 1
var accuracy : float = 0.0

var jumpNumber : int = 1
var jumpScale : float = 0.0

var maxVelocityY : = 0.0

onready var jumpAudio = $JumpAudio as AudioStreamPlayer


func enter_state(params : Dictionary = {}) -> void:
	fsm.anim.play("jump_up")
	
	fsm.velocity = Vector2.ZERO
	if boardInRange:
		var xDiff = global_position.x - boardPosition.x
		if xDiff < 0:
			fsm.change_state("JumpFall")
		else:
			maxJumpScale = range_lerp(xDiff, 0.0, 40.0, 0.15, 1.0)
			fsm.points1 = clamp(maxJumpScale * 10, 0.0, 10.0)
			jumpScale += maxJumpScale
			playAndScaleJumpAudio()
	else:
		fsm.change_state("JumpFall")

	
	
func physics_process(delta : float) -> void:
	if fsm.isOnFloor && accurateInput < 1:
		fsm.change_state("JumpFall")
	elif fsm.isOnFloor && accurateInput == 1:
		fsm.anim.play("jump_up")
		playAndScaleJumpAudio()
		fsm.velocity.y = -JUMP_FORCE * jumpScale
		
		if abs(fsm.velocity.y) > maxVelocityY:
			maxVelocityY = abs(fsm.velocity.y)
		
		if jumpNumber >= MAX_JUMPS:
			fsm.change_state("Dive")
			return
			
		jumpNumber += 1
		accurateInput = -1
		accuracy = 0.0
		
	fsm.velocity.y += GRAVITY
	
#	for collision in fsm.slides:
#		print(collision.collider.name)


func calculateJumpInput() -> void:
	if boardInRange && fsm.velocity.y >= 0:
		accurateInput = 1
		var yDiff = boardPosition.y - global_position.y
		accuracy = range_lerp(yDiff, boardHeight, boardDetectHeight, maxJumpScale, 0)
		jumpScale += accuracy
	else:
		accurateInput = 0
		
		
func playAndScaleJumpAudio() -> void:
	jumpAudio.play()
	jumpAudio.pitch_scale += 0.2
	

func exit_state() -> void:
	fsm.points2 = clamp(range_lerp(maxVelocityY, 0.0, JUMP_FORCE * 3, 0.0, 10.0), 0.0, 10.0)
		
