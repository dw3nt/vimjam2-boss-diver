extends Sprite
class_name Judge

const HAND_OFFSET_INCREMENT : = 16

export(NodePath) var lookTargetPath

var judgeNumber : int = -1
var lookTarget
var handOffsetSet : = false

var judgeFrame0 : int = 0
var judgeFrame1 : int = 1

onready var headAnim = $HeadAnimation as AnimationPlayer
onready var handAnim = $HandAnimation as AnimationPlayer

onready var leftHand = $LeftHand as Sprite
onready var rightHand = $RightHand as Sprite


func _ready() -> void:
	lookTarget = get_node(lookTargetPath)
	
	
func setJudgeFrames(number : int) -> void:	
	judgeNumber = number
	judgeFrame0 = number * 2 
	judgeFrame1 = number * 2 + 1
	rightHand.frame = number
	leftHand.frame = number
	
	if randi() % 2 == 0:
		frame = judgeFrame0
	else:
		frame = judgeFrame1
	
	
func _process(_delta : float) -> void:
	flip_h = global_position.x > lookTarget.global_position.x
	
	
func switchHeadBobFrame() -> void:
	if frame == judgeFrame0:
		frame = judgeFrame1
	elif frame == judgeFrame1:
		frame = judgeFrame0
		
		
func setHandOffset() -> void:
	if !handOffsetSet:
		var yOffset = randi() % 2
		rightHand.offset.y = HAND_OFFSET_INCREMENT * yOffset
		leftHand.offset.y = HAND_OFFSET_INCREMENT * yOffset
		handOffsetSet = true
