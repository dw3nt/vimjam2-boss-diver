extends "res://rooms/BaseRoom.gd"

onready var diver = $Diver
onready var judgesTable = $JudgesTable
onready var diveResults = $CanvasLayer/DiveResults


func _ready() -> void:
	randomize()
	emit_signal("room_ready")
	
	
func _input(event):
	if event is InputEventKey && event.scancode == KEY_R && event.is_pressed():
		get_tree().reload_current_scene()


func cueJudges(isSloppy : bool) -> void:
	var speed = 1.0
	if isSloppy:
		speed = 0.0
	else:
		judgesTable.playClap()
	
	judgesTable.playHeadBobAtSpeed(speed)


func _on_Floor_dive_finished():
	diveResults.points.append(diver.stateWrap.points1)
	diveResults.points.append(diver.stateWrap.points2)
	diveResults.points.append(diver.stateWrap.points3)
	diveResults.anim.play("fade_in")


func _on_DiveResults_retry_button_pressed():
	emit_signal("room_change_requested", { "scene": filename })
	
	
func _on_Player_entered_pool(isSloppy : bool) -> void:
	cueJudges(isSloppy)
	

func _on_Diver_entered_pool(isSloppy : bool) -> void:
	cueJudges(isSloppy)
