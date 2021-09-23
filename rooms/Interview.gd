extends "res://rooms/BaseRoom.gd"

const MAIN_MENU_SCENE = "res://menus/MainMenu.tscn"
const INTERVIEW_RESULTS_SCENE = "res://menus/InterviewResults.tscn"

const PLAYER_SCENE = preload("res://characters/player/Player.tscn")
const COMPETITOR_SCENE = preload("res://characters/competitor/Competitor.tscn")

const MAX_ROUNDS : = 2

var victories : = 0
var roundNumber : = 0
var scoreToBeat : = 0.0

onready var publicPool = $PublicPool


func _ready() -> void:
	if params:
		publicPool.judgesTable.currentJudges = params.judges
		publicPool.diverScene = params.nextDiver
		scoreToBeat = params.scoreToBeat
		victories = params.victories
		roundNumber = params.roundNumber
	
	if publicPool.diverScene == COMPETITOR_SCENE:
		publicPool.diveResultMessage.text = "The score to beat is:"
		publicPool.diveResultsWrap.displayPoints = true
		publicPool.retryButton.text = "Compete"
	else:
		publicPool.diveResultMessage.text = "Your score is:"
		publicPool.diveResultsWrap.displayPoints = false
		publicPool.retryButton.text = "Next Round"
	
	publicPool.initScene()
	yield(get_tree().create_timer(0.25), "timeout")
	emit_signal("room_ready")


func _on_PublicPool_main_menu_button_pressed():
	emit_signal("room_change_requested", { "scene": MAIN_MENU_SCENE })


func _on_PublicPool_retry_button_pressed():
	if roundNumber >= MAX_ROUNDS && publicPool.diverScene == PLAYER_SCENE:
		emit_signal("room_change_requested", { "scene": INTERVIEW_RESULTS_SCENE })
	else:	
		emit_signal("room_change_requested", { "scene": filename, "params": createParams() })
		
	if publicPool.diverScene == PLAYER_SCENE:
		ChallengerTracker.interviewPoints[ChallengerTracker.currentChallengerKey].player.append(publicPool.diver.stateWrap.getPointsArray())
	else:
		ChallengerTracker.interviewPoints[ChallengerTracker.currentChallengerKey].competitor.append(publicPool.diver.stateWrap.getPointsArray())
		
	print(ChallengerTracker.interviewPoints[ChallengerTracker.currentChallengerKey])
	
	
func createParams() -> Dictionary:
	var params = {}	
	params.judges = publicPool.judgesTable.currentJudges
	params.victories = victories
	if publicPool.diverScene == PLAYER_SCENE:
		params.nextDiver = COMPETITOR_SCENE
		params.scoreToBeat = 0.0
		params.roundNumber = roundNumber + 1
	else:
		params.nextDiver = PLAYER_SCENE
		params.scoreToBeat = publicPool.diveResultsWrap.calculateScore()
		params.roundNumber = roundNumber
		
	return params


func _on_PublicPool_dive_results_displayed() -> void:
	if publicPool.diverScene == PLAYER_SCENE && scoreToBeat < publicPool.diveResultsWrap.calculateScore():
		victories += 1
