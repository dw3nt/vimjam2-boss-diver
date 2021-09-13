extends KinematicBody2D
class_name Player

export(NodePath) var followPath

onready var stateWrap = $PlayerStateMachine as PlayerStateMachine
onready var jumpState = $PlayerStateMachine/Jump
onready var diveState = $PlayerStateMachine/Dive

onready var sprite = $Sprite as Sprite
onready var collider = $CollisionShape2D as CollisionShape2D


func _ready() -> void:
	$PlayerStateMachine/ClimbLadder.pathFollow = get_node(followPath)
	
	stateWrap.ready()
	
	
func enteredBoardRange(boardPos : Vector2, boardHeight : float, boardDetectHeight : float) -> void:
	jumpState.boardInRange = true
	jumpState.boardPosition = boardPos
	jumpState.boardHeight = boardHeight
	jumpState.boardDetectHeight = boardDetectHeight
	
	
func exitedBoardRange() -> void:
	jumpState.boardInRange = false
	jumpState.boardPosition = Vector2.ZERO
	jumpState.boardHeight = -1.0
	jumpState.boardDetectHeight = -1.0
	
	
func enteredPool() -> void:
	stateWrap.state.enteredPool()
	
	
func _input(event) -> void:
	stateWrap.state.input(event)
	
	
func _process(delta) -> void:
	stateWrap.state.process(delta)


func _physics_process(delta) -> void:
	stateWrap.state.physics_process(delta)
	move_and_slide(stateWrap.velocity, Vector2.UP)
	
	stateWrap.isOnFloor = is_on_floor()
