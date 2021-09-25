extends "res://menus/BaseMenu.gd"

const MAIN_MENU_SCENE : = "res://menus/MainMenu.tscn"

var challengerScore : float = 0.0
var playerScore : float = 0.0

onready var resultsLabel = $MarginContainer/CenterContainer/VBoxContainer/ResultsLabel

onready var competitorNameLabel = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/CompetitorResultsWrap/CompetitorName
onready var competitorScoreRound1 = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/CompetitorResultsWrap/RoundScoreWrap/RoundScore1
onready var competitorScoreRound2 = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/CompetitorResultsWrap/RoundScoreWrap/RoundScore2
onready var competitorScoreRound3 = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/CompetitorResultsWrap/RoundScoreWrap/RoundScore3
onready var competitorTotalScore = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/CompetitorResultsWrap/TotalScoreLabel

onready var playerScoreRound1 = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/PlayerResultWrap/Round1ScoreWrap/RoundScore1
onready var playerScoreRound2 = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/PlayerResultWrap/Round1ScoreWrap/RoundScore2
onready var playerScoreRound3 = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/PlayerResultWrap/Round1ScoreWrap/RoundScore3
onready var playerTotalScore = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/PlayerResultWrap/TotalScoreLabel


func _ready() -> void:
	initResultsLabel()
	initCompetitorData()
	initPlayerData()
	
	ChallengerTracker.currentChallengerKey += 1		# do this after initing results with current key
	emit_signal("room_ready")
	
	
func initResultsLabel() -> void:
	challengerScore = ChallengerTracker.getInterviewTotalScore(ChallengerTracker.currentChallengerKey, "competitor")
	playerScore = ChallengerTracker.getInterviewTotalScore(ChallengerTracker.currentChallengerKey, "player")
	
	if playerScore > challengerScore:
		resultsLabel.text = "Congratulations! You are the winner!"
	else:
		resultsLabel.text = "Too bad! " + ChallengerTracker.getCurrentChallenger().name + " is the winner."
	
	
func initCompetitorData() -> void:
	competitorNameLabel.text = ChallengerTracker.getCurrentChallenger().name
	competitorScoreRound1.text = str("%.1f" % ChallengerTracker.getRoundTotalScore(ChallengerTracker.currentChallengerKey, "competitor", 0))
	competitorScoreRound2.text = str("%.1f" % ChallengerTracker.getRoundTotalScore(ChallengerTracker.currentChallengerKey, "competitor", 1))
	competitorScoreRound3.text = str("%.1f" % ChallengerTracker.getRoundTotalScore(ChallengerTracker.currentChallengerKey, "competitor", 2))
	competitorTotalScore.text = str("%.1f" % challengerScore)
	
	
func initPlayerData() -> void:
	playerScoreRound1.text = str("%.1f" % ChallengerTracker.getRoundTotalScore(ChallengerTracker.currentChallengerKey, "player", 0))
	playerScoreRound2.text = str("%.1f" % ChallengerTracker.getRoundTotalScore(ChallengerTracker.currentChallengerKey, "player", 1))
	playerScoreRound3.text = str("%.1f" % ChallengerTracker.getRoundTotalScore(ChallengerTracker.currentChallengerKey, "player", 2))
	playerTotalScore.text = str("%.1f" % playerScore)


func _on_MenuButton_pressed() -> void:
	emit_signal("room_change_requested", { "scene": MAIN_MENU_SCENE } )
