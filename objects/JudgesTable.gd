extends Node2D

var judges : = []


func _ready() -> void:
	judges.append($Judge1)
	judges.append($Judge2)
	judges.append($Judge3)
	
	playHeadBobAtSpeed(0.25)
	
	
func playHeadBobAtSpeed(speed : float) -> void:
	for judge in judges:
		judge.headAnim.play("head_bob", -1, speed)
		
		
func playClap() -> void:
	for judge in judges:
		judge.handAnim.play("clap", -1, 1.5)
