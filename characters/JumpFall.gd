extends PlayerState

const JUMP_FORCE : = 15.0
const FORWARD_FORCE : = 10.0

var shouldCheckGround : bool = false

onready var groundCheckDelayTimer = $GroundCheckDelay as Timer


func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity.y = -JUMP_FORCE
	fsm.velocity.x = FORWARD_FORCE
	
	fsm.player.set_collision_mask_bit(1, false)
	groundCheckDelayTimer.start()
	
	
func physics_process(delta : float) -> void:
	if shouldCheckGround && fsm.isOnFloor:
		fsm.change_state("GroundSplat")
		return
	
	fsm.velocity.y += GRAVITY
	fsm.velocity.x = lerp(fsm.velocity.x, 0.0, AIR_RESIST)


func _on_GroundCheckDelay_timeout():
	shouldCheckGround = true
