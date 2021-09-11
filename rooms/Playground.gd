extends "res://rooms/BaseRoom.gd"


func _ready() -> void:
	emit_signal("room_ready")
