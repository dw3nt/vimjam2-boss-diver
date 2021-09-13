extends BaseStateMachine
class_name PlayerStateMachine

export(NodePath) var playerPath

var player = null
var isOnFloor : bool = false


func _ready() -> void:
	player = get_node(playerPath)
