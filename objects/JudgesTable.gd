extends Node2D

var judges : = []


func _ready() -> void:
	judges.append($Judge1)
	judges.append($Judge2)
	judges.append($Judge3)
	
	playHeadBobAtSpeed(0.25)
	
	
func playHeadBobAtSpeed(speed : float) -> void:
	for judge in judges:
		judge.anim.play("head_bob", -1, speed)
