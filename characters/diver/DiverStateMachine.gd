extends BaseStateMachine
class_name DiverStateMachine

export(NodePath) var diverPath

var diver = null
var isOnFloor : bool = false
var slides : = []

var points1 = 0.0	# how far out ont diving board you go
var points2 = 0.0 	# how high you jump
var points3 = 0.0	# how many points (and bonus if graceful dive)


func _ready() -> void:
	diver = get_node(diverPath)
