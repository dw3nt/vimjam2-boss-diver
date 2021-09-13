extends StaticBody2D
class_name DivingBoard

var boardHeight : float
var detectHeight : float

onready var jumpDetect = $JumpDetect


func _ready() -> void:
	boardHeight = $CollisionShape2D.shape.extents.y
	detectHeight = $JumpDetect/CollisionShape2D.shape.extents.y


func _on_JumpDetect_body_entered(body : Player) -> void:
	body.enteredBoardRange(global_position, boardHeight, detectHeight)


func _on_JumpDetect_body_exited(body : Player) -> void:
	body.exitedBoardRange()
