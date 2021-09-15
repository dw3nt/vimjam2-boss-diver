extends "res://rooms/BaseRoom.gd"

onready var judgesTable = $JudgesTable


func _ready() -> void:
	randomize()
	emit_signal("room_ready")


func _input(event):
	if event is InputEventKey and event.scancode == KEY_R and not event.echo:
		get_tree().reload_current_scene()


func _on_Player_entered_pool(isSloppy : bool) -> void:
	var speed = 1.0
	if isSloppy:
		speed = 0.0
	else:
		judgesTable.playClap()
	
	judgesTable.playHeadBobAtSpeed(speed)
