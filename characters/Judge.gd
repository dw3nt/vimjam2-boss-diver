extends Sprite

export(NodePath) var lookTargetPath

var lookTarget

onready var anim = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	frame = randi() % 2
	
	lookTarget = get_node(lookTargetPath)
	
	
func _process(_delta : float) -> void:
	flip_h = global_position.x > lookTarget.global_position.x
	
	
func switchHeadBobFrame() -> void:
	if frame == 0:
		frame = 1
	elif frame == 1:
		frame = 0
