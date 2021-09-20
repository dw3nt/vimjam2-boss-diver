extends "res://rooms/BaseRoom.gd"

const DIVER_SCENE = preload("res://characters/player/Player.tscn")
const CAMERA_SCENE = preload("res://objects/Camera2D.tscn")

export(String, FILE, "*.tscn") var mainMenuScene

var diver : Diver

onready var judgesTable = $JudgesTable
onready var diveResults = $CanvasLayer/DiveResults
onready var climbLadderPath = $ClimbLadderPath
onready var remoteTransform = $ClimbLadderPath/PathFollow2D/RemoteTransform2D


func _ready() -> void:
	if params:
		judgesTable.currentJudges = params.judges

	initDiver()
	judgesTable.setJudges()
	
	
	emit_signal("room_ready")
	
	
func initDiver() -> void:
	diver = DIVER_SCENE.instance()
	diver.connect("entered_pool", self, "_on_Diver_entered_pool")
	diver.connect("ground_splat_finished", self, "_on_Diver_ground_splat_finished")
	judgesTable.judgeLookTarget = diver
	diver.climbLadderPath = climbLadderPath
	add_child(diver)
	remoteTransform.remote_path = remoteTransform.get_path_to(diver)
	call_deferred("initCamera")
	
	
func initCamera() -> void:
	var camera = CAMERA_SCENE.instance()
	camera.current = true
	diver.add_child(camera)
	
	
func displayDiveResults() -> void:
	diveResults.points.append(diver.stateWrap.points1)
	diveResults.points.append(diver.stateWrap.points2)
	diveResults.points.append(diver.stateWrap.points3)
	diveResults.anim.play("fade_in")


func _on_Diver_entered_pool(isSloppy : bool) -> void:
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


func _on_Diver_ground_splat_finished():
	judgesTable.playHeadBobAtSpeed(0.0)
	displayDiveResults()
