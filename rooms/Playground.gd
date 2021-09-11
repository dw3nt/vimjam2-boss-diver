extends "res://rooms/BaseRoom.gd"

var pathFollowed = false


func _ready() -> void:
	emit_signal("room_ready")
