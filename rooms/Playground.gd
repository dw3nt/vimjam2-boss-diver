extends "res://rooms/BaseRoom.gd"

onready var player = $Player
onready var judgesTable = $JudgesTable
onready var diveResults = $CanvasLayer/DiveResults


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


func _on_Floor_dive_finished():
	diveResults.points.append(player.stateWrap.points1)
	diveResults.points.append(player.stateWrap.points2)
	diveResults.points.append(player.stateWrap.points3)
	diveResults.anim.play("fade_in")
