extends BaseStateMachine
class_name PlayerStateMachine

export(NodePath) var playerPath

var player = null
var isOnFloor : bool = false

var points1 = 0.0	# how far out ont diving board you go
var points2 = 0.0 	# how high you jump
var points3 = 0.0	# how many points (and bonus if graceful dive)


func _ready() -> void:
	player = get_node(playerPath)
