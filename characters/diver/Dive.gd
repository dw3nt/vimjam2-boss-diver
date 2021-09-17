extends DiverState

const POSE_PARTICLES_SCENE = preload("res://effects/PoseParticles.tscn")

const FORWARD_DIVE_SPEED : float = 65.0
const GRACEFUL_BONUS : = 5
const SLOPPY_BONUS : = -3

const POSE_FRAME_RANGE : = [15, 21]
const DIVE_FRAME : = 13

var isDiving = false

var canInput : = true
var inputCooldown : = 0.5

var expectedInputs = 15
var inputs : = 0

onready var poseTimer = $PoseTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	fsm.velocity.x = FORWARD_DIVE_SPEED
	
	
func input(event) -> void:
	if canInput && event.is_action_pressed("walk") || event.is_action_pressed("jump"):
		inputs += 1
		canInput = false
		fsm.sprite.frame = choosePoseFrame()
		poseTimer.start(inputCooldown)
		instancePoseParticles()
	
	
func physics_process(delta : float) -> void:
	fsm.velocity.x = lerp(fsm.velocity.x, 0.0, AIR_RESIST)
	fsm.velocity.y += GRAVITY
	
	if !isDiving && fsm.velocity.y >= 0:
		fsm.anim.play("dive")
		isDiving = true
	
	
func enteredPool() -> bool:
	if canInput:
		inputs += GRACEFUL_BONUS
		fsm.change_state("GracefulEntrance")
		return false
	else:
		inputs += SLOPPY_BONUS
		fsm.change_state("SloppyEntrance")
		return true
		
		
func choosePoseFrame() -> int:
	return randi() % (POSE_FRAME_RANGE[1] - POSE_FRAME_RANGE[0]) + POSE_FRAME_RANGE[0]
	
	
func instancePoseParticles() -> void:
	var inst = POSE_PARTICLES_SCENE.instance()
	add_child(inst)
	inst.emitting = true


func _on_PoseTimer_timeout() -> void:
	canInput = true
	fsm.sprite.frame = DIVE_FRAME
	
	
func exit_state() -> void:
	if inputs > expectedInputs:
		expectedInputs = inputs	# aka - you get 10 points for going over the expected
	fsm.points3 = range_lerp(inputs, 0.0, expectedInputs, 0.0, 10.0)
