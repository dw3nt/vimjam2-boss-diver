extends Area2D
class_name Pool

signal pool_entered

var animationPlayers : = []


func _ready() -> void:
	animationPlayers.append($Sprite/AnimationPlayer)
	animationPlayers.append($Sprite2/AnimationPlayer)
	animationPlayers.append($Sprite3/AnimationPlayer)
	
	playPoolIdle(0.5)
	
	
func playPoolIdle(speed: float) -> void:
	for anim in animationPlayers:
		anim.play("pool_idle", -1, speed)


func _on_Pool_body_entered(body : Player):
	if body:
		var sloppy = body.enteredPool()
		if sloppy:
			playPoolIdle(2.0)
			
		emit_signal("pool_entered")
