extends Node

const CHALLENGERS : Array = [
	preload("res://resources/competitors/Chad.tres"),
	preload("res://resources/competitors/Tammy.tres"),
	preload("res://resources/competitors/Kenny.tres"),
	preload("res://resources/competitors/Milo.tres"),
	preload("res://resources/competitors/Becky.tres")
]

var currentChallengerData : Array = [null, null, null, null, null]
var currentChallengerKey : int = 0

var interviewPoints = [
	{ "player": [], "competitor": [] },
	{ "player": [], "competitor": [] },
	{ "player": [], "competitor": [] },
	{ "player": [], "competitor": [] },
	{ "player": [], "competitor": [] },
]


func getCurrentChallenger() -> CompetitorData:
	var currentChallenger = currentChallengerData[currentChallengerKey]
	if currentChallenger == null:
		currentChallenger = chooseChallenger()
		
	return currentChallenger
		
		
func chooseChallenger() -> CompetitorData:
	var potentialChallengers = []
	for challenger in CHALLENGERS:
		if challenger.difficulty == (currentChallengerKey + 1):
			potentialChallengers.append(challenger)
			
	currentChallengerData[currentChallengerKey] = potentialChallengers[randi() % potentialChallengers.size()]
	return currentChallengerData[currentChallengerKey]
	
	
func getPointsForRound(diverKey : String, roundOffset : int) -> String:
	if interviewPoints[currentChallengerKey][diverKey].size() > roundOffset:
		return str("%.1f" % getRoundTotalScore(currentChallengerKey, diverKey, roundOffset))
	else:
		return "n/a"
	
	
func getRoundTotalScore(challengerOffset : int, diverKey : String, roundOffset : int) -> float:
	var totalPoints = 0.0
	for points in interviewPoints[challengerOffset][diverKey][roundOffset]:
		totalPoints += points
		
	return totalPoints
	
	
func getInterviewTotalScore(challengerOffset : int, diverKey : String) -> float:
	var totalPoints = 0.0
	for roundOffset in range(interviewPoints[challengerOffset][diverKey].size()):
		totalPoints += getRoundTotalScore(challengerOffset, diverKey, roundOffset)
		
	return totalPoints
