extends Area2D
class_name Pool

signal pool_entered

const BASE_ANIMATION_SPEED : = 0.5
const ANIMATION_SPEED_REDUCTION : = 0.5

var animationPlayers : = []
var animationSpeed : = 0.5

onready var roughTimer = $RoughTimer as Timer


func _ready() -> void:
	animationPlayers.append($Sprite/AnimationPlayer)
	animationPlayers.append($Sprite2/AnimationPlayer)
	animationPlayers.append($Sprite3/AnimationPlayer)
	
	playPoolIdle(animationSpeed)
	
	
func playPoolIdle(speed: float) -> void:
	for anim in animationPlayers:
		anim.play("pool_idle", -1, speed)


func _on_Pool_body_entered(body : Player):
	if body:
		var sloppy = body.enteredPool()
		if sloppy:
			animationSpeed = 2.0
			playPoolIdle(animationSpeed)
			roughTimer.start()
			
		emit_signal("pool_entered")


func _on_RoughTimer_timeout():
	if animationSpeed > BASE_ANIMATION_SPEED:
		animationSpeed = max(animationSpeed - ANIMATION_SPEED_REDUCTION, BASE_ANIMATION_SPEED)
		roughTimer.start(1.5)
		
	playPoolIdle(animationSpeed)
