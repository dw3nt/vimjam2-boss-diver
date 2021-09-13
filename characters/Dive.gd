extends PlayerState

const FORWARD_DIVE_SPEED : float = 100.0

var canInput : = true
var inputCooldown : = 0.35

var inputs : = 0

onready var poseTimer = $PoseTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity.y = params.jumpForce
	fsm.velocity.x = FORWARD_DIVE_SPEED * params.forwardForceScale
	
	
func input(event) -> void:
	if canInput && event.is_action_pressed("walk") || event.is_action_pressed("jump"):
		inputs += 1
		canInput = false
		poseTimer.start(inputCooldown)
	
	
func physics_process(delta : float) -> void:
	fsm.velocity.x = lerp(fsm.velocity.x, 0.0, AIR_RESIST)
	fsm.velocity.y += GRAVITY
	
	
func enteredPool() -> void:
	if canInput:
		fsm.change_state("GracefulEntrance")
	else:
		fsm.change_state("SloppyEntrance")


func _on_PoseTimer_timeout():
	canInput = true
