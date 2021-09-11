extends KinematicBody2D
class_name Player

export(float) var walkSpeed = 50

var canWalk : bool = false
var isWalking : bool = false


func _input(event) -> void:
	if canWalk && event.is_action_pressed("walk"):
		if !isWalking:
			print('walk')
			isWalking = true
		else:
			print('stop')
			isWalking = false
			canWalk = false
		
		
func _physics_process(_delta) -> void:
	if isWalking:
		move_and_slide(Vector2.RIGHT * walkSpeed)
