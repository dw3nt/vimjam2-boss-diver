extends KinematicBody2D
class_name Diver

signal entered_pool
signal ground_splat_finished

export(Texture) var spriteTexture

var climbLadderPath

onready var stateWrap = $DiverStateMachine as DiverStateMachine
onready var jumpState = $DiverStateMachine/Jump
onready var diveState = $DiverStateMachine/Dive
onready var climbState = $DiverStateMachine/ClimbLadder

onready var sprite = $Sprite as Sprite
onready var collider = $CollisionShape2D as CollisionShape2D


func _ready() -> void:
	if spriteTexture:
		sprite.texture = spriteTexture

	climbState.path = climbLadderPath
	
	stateWrap.diver = self
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
	
	
func enteredPool() -> bool:
	var isSloppy = stateWrap.state.enteredPool()
	emit_signal("entered_pool", isSloppy)
	return isSloppy
	
	
func _input(event) -> void:
	stateWrap.state.input(event)
	
	
func _process(delta) -> void:
	stateWrap.state.process(delta)


func _physics_process(delta) -> void:
	stateWrap.state.physics_process(delta)
	move_and_slide(stateWrap.velocity, Vector2.UP)
	
	stateWrap.slides.clear()
	if stateWrap.state.name == jumpState.name:
		for i in get_slide_count():
			stateWrap.slides.append(get_slide_collision(i))
	
	stateWrap.isOnFloor = is_on_floor()


func _on_GroundSplat_ground_splat_finished():
	emit_signal("ground_splat_finished")
