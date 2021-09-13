extends PlayerState

const FORWARD_DIVE_SPEED : float = 65.0
const GRACEFUL_BONUS : = 5
const SLOPPY_BONUS : = -3

var canInput : = true
var inputCooldown : = 0.35

var expectedInputs = 15
var inputs : = 0

onready var poseTimer = $PoseTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity.y = params.jumpForce
	fsm.velocity.x = FORWARD_DIVE_SPEED
	
	
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
		inputs += GRACEFUL_BONUS
		fsm.change_state("GracefulEntrance")
	else:
		inputs += SLOPPY_BONUS
		fsm.change_state("SloppyEntrance")


func _on_PoseTimer_timeout() -> void:
	canInput = true
	
	
func exit_state() -> void:
	if inputs > expectedInputs:
		expectedInputs = inputs	# aka - you get 10 points for going over the expected
	fsm.points3 = range_lerp(inputs, 0.0, expectedInputs, 0.0, 10.0)
