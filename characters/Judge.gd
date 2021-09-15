extends Sprite
class_name Judge

const HAND_OFFSET_INCREMENT : = 16

export(NodePath) var lookTargetPath

var lookTarget
var handOffsetSet : = false

onready var headAnim = $HeadAnimation as AnimationPlayer
onready var handAnim = $HandAnimation as AnimationPlayer

onready var leftHand = $LeftHand as Sprite
onready var rightHand = $RightHand as Sprite


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
		
		
func setHandOffset() -> void:
	if !handOffsetSet:
		var yOffset = randi() % 2
		rightHand.offset.y = HAND_OFFSET_INCREMENT * yOffset
		leftHand.offset.y = HAND_OFFSET_INCREMENT * yOffset
		handOffsetSet = true
