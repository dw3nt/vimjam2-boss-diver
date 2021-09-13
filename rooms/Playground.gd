extends "res://rooms/BaseRoom.gd"


func _ready() -> void:
	emit_signal("room_ready")


func _input(event):
	if event is InputEventKey and event.scancode == KEY_R and not event.echo:
		get_tree().reload_current_scene()
