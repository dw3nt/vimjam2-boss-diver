extends "res://rooms/BaseRoom.gd"

export(String, FILE, "*.tscn") var mainMenuScene

onready var player = $Player
onready var judgesTable = $JudgesTable
onready var diveResults = $CanvasLayer/DiveResults


func _ready() -> void:
	if params:
		judgesTable.currentJudges = params.judges
	
	judgesTable.setJudges()
	
	emit_signal("room_ready")
	
	
func displayDiveResults() -> void:
	diveResults.points.append(player.stateWrap.points1)
	diveResults.points.append(player.stateWrap.points2)
	diveResults.points.append(player.stateWrap.points3)
	diveResults.anim.play("fade_in")


func _on_Player_entered_pool(isSloppy : bool) -> void:
	var speed = 1.0
	if isSloppy:
		speed = 0.0
	else:
		judgesTable.playClap()
	
	judgesTable.playHeadBobAtSpeed(speed)


func _on_Floor_dive_finished():
	displayDiveResults()


func _on_DiveResults_retry_button_pressed():
	emit_signal("room_change_requested", { "scene": filename, "params": { "judges": judgesTable.currentJudges } })


func _on_DiveResults_main_menu_button_pressed():
	emit_signal("room_change_requested", { "scene": mainMenuScene })


func _on_Player_ground_splat_finished():
	judgesTable.playHeadBobAtSpeed(0.0)
	displayDiveResults()
