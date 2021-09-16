extends Node2D

var availableJudges : = []
var currentJudges : = []
var judgeInsts : = []


func _ready() -> void:
	judgeInsts.append($Judge1)
	judgeInsts.append($Judge2)
	judgeInsts.append($Judge3)
	
	availableJudges = range(judgeInsts[0].hframes / 2) 
	availableJudges.shuffle()
	
	playHeadBobAtSpeed(0.25)
	
	
func setJudges() -> void:
	for i in range(judgeInsts.size()):
		if i < currentJudges.size() && currentJudges.size() > 0:
			judgeInsts[i].setJudgeFrames(currentJudges[i])
		else:
			var judgeNum = availableJudges.pop_front()
			judgeInsts[i].setJudgeFrames(judgeNum)
			currentJudges.append(judgeNum)
			print(judgeNum)
	
	
func playHeadBobAtSpeed(speed : float) -> void:
	for judge in judgeInsts:
		judge.headAnim.play("head_bob", -1, speed)
		
		
func playClap() -> void:
	for judge in judgeInsts:
		judge.handAnim.play("clap", -1, 1.5)
		
