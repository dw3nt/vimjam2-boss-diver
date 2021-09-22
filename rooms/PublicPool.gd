extends Node2D

signal dive_results_displayed
signal retry_button_pressed
signal main_menu_button_pressed

const CAMERA_SCENE = preload("res://objects/Camera2D.tscn")

var diverScene : PackedScene = preload("res://characters/competitor/Competitor.tscn")
var diver

onready var judgesTable = $JudgesTable
onready var climbLadderPath = $ClimbLadderPath
onready var remoteTransform = $ClimbLadderPath/PathFollow2D/RemoteTransform2D
onready var diveResultsWrap = $CanvasLayer/DiveResults
onready var diveResultMessage = $CanvasLayer/DiveResults/MarginContainer/CenterContainer/VBoxContainer/FinalScoreWrap/PreScoreLabel
onready var diveResultScore = $CanvasLayer/DiveResults/MarginContainer/CenterContainer/VBoxContainer/FinalScoreWrap/FinalScoreLabel
onready var mainMenuButton = $CanvasLayer/DiveResults/MarginContainer/CenterContainer/VBoxContainer/ButtonsWrap/MainMenuButton
onready var retryButton = $CanvasLayer/DiveResults/MarginContainer/CenterContainer/VBoxContainer/ButtonsWrap/RetryButton
	
	
func initScene():
	initDiver()
	judgesTable.setJudges()
	
	
func initDiver() -> void:
	diver = diverScene.instance()
	diver.connect("entered_pool", self, "_on_Diver_entered_pool")
	diver.connect("ground_splat_finished", self, "_on_Diver_ground_splat_finished")
	judgesTable.judgeLookTarget = diver
	diver.climbLadderPath = climbLadderPath
	add_child(diver)
	remoteTransform.remote_path = remoteTransform.get_path_to(diver)
	call_deferred("initCamera")
	
	if diver is Competitor:
		diver.setCompetitorData(ChallengerTracker.getCurrentChallenger())
	
	
func initCamera() -> void:
	var camera = CAMERA_SCENE.instance()
	camera.current = true
	diver.add_child(camera)
	
	
func displayDiveResults() -> void:
	diveResultsWrap.points.append(diver.stateWrap.points1)
	diveResultsWrap.points.append(diver.stateWrap.points2)
	diveResultsWrap.points.append(diver.stateWrap.points3)
	diveResultsWrap.anim.play("fade_in")
	
	emit_signal("dive_results_displayed")


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
	emit_signal("retry_button_pressed")


func _on_DiveResults_main_menu_button_pressed():
	emit_signal("main_menu_button_pressed")


func _on_Diver_ground_splat_finished():
	judgesTable.playHeadBobAtSpeed(0.0)
	displayDiveResults()
