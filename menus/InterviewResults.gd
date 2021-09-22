extends "res://menus/BaseMenu.gd"


func _ready() -> void:
	emit_signal("room_ready")
