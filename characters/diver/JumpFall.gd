extends DiverState
class_name JumpFall

const JUMP_FORCE : = 15.0
const FORWARD_FORCE : = 10.0

var shouldCheckGround : bool = false

onready var groundCheckDelayTimer = $GroundCheckDelay as Timer
onready var fallAudio = $FallAudio as AudioStreamPlayer


func enter_state(params : Dictionary = {}) -> void:
	fallAudio.play()
	
	fsm.velocity.y = -JUMP_FORCE
	fsm.velocity.x = FORWARD_FORCE
	
	fsm.diver.set_collision_mask_bit(1, false)
	groundCheckDelayTimer.start()
	
	fsm.anim.play("walk-fall")
	fsm.sprite.rotation_degrees = 90
	fsm.sprite.z_index = 10
	
	
func physics_process(delta : float) -> void:
	if shouldCheckGround && fsm.isOnFloor:
		fsm.change_state("GroundSplat")
		return
	
	fsm.velocity.y += GRAVITY
	fsm.velocity.x = lerp(fsm.velocity.x, 0.0, AIR_RESIST)
	
	
func enteredPool() -> bool:
	fsm.change_state("SloppyEntrance")
	return true


func _on_GroundCheckDelay_timeout():
	shouldCheckGround = true
