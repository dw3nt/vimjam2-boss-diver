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


func getCurrentChallenger() -> CompetitorData:
	var currentChallenger = currentChallengerData[currentChallengerKey]
	if currentChallenger == null:
		currentChallenger = chooseChallenger()
		
	return currentChallenger
		
		
func chooseChallenger() -> CompetitorData:
	var potentialChallengers = []
	for challenger in CHALLENGERS:
		print(challenger.difficulty)
		if challenger.difficulty == (currentChallengerKey + 1):
			potentialChallengers.append(challenger)
			
	currentChallengerData[currentChallengerKey] = potentialChallengers[randi() % potentialChallengers.size()]
	return currentChallengerData[currentChallengerKey]
