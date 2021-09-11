extends "res://rooms/BaseRoom.gd"

var pathFollowed = false

onready var ladderPathFollow : PathFollow2D = $ClimbLadderPath/PathFollow2D
onready var player : Player = $ClimbLadderPath/PathFollow2D/Player


func _ready() -> void:
	emit_signal("room_ready")
	
	
func _process(delta) -> void:
	followPath(delta)
	
	
func followPath(delta) -> void:
	if !pathFollowed:
		ladderPathFollow.offset += 100 * delta
		
		if ladderPathFollow.unit_offset >= 1.0:
			pathFollowed = true
			player.canWalk = true
