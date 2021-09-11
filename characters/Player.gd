extends KinematicBody2D
class_name Player

export(NodePath) var followPath

onready var stateWrap = $PlayerStateMachine as PlayerStateMachine
onready var sprite = $Sprite as Sprite


func _ready() -> void:
	$PlayerStateMachine/ClimbLadder.pathFollow = get_node(followPath)
	
	stateWrap.ready()
	
	
func _input(event) -> void:
	stateWrap.state.input(event)
	
	
func _process(delta) -> void:
	stateWrap.state.process(delta)


func _physics_process(delta) -> void:
	stateWrap.state.physics_process(delta)
	move_and_slide(stateWrap.velocity)
