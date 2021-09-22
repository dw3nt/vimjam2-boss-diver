extends Diver
class_name Competitor

onready var walkBoardState = $DiverStateMachine/WalkBoard


func setCompetitorData(data) -> void:
	sprite.texture = data.image
	
	walkBoardState.walkDistances = data.walkDistances
	jumpState.jumpHeightPercentages = data.jumpHeightPrecentages
	diveState.strikePoseTimes = data.poseTimeCooldowns
