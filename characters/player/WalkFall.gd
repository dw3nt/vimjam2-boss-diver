extends PlayerState

onready var fallAudio = $FallAudio as AudioStreamPlayer


func enter_state(params : Dictionary = {}) -> void:
	fallAudio.play()
	fsm.anim.play("walk-fall", -1, 1.5)
	
	
func physics_process(delta : float) -> void:
	fsm.velocity.y += GRAVITY
	fsm.velocity.x = lerp(fsm.velocity.x, 0.0, AIR_RESIST)
	
	
func process(delta : float) -> void:
	fallAudio.volume_db -= 8.0 * delta
	
	
func enteredPool() -> bool:
	fsm.change_state("SloppyEntrance")
	return true
