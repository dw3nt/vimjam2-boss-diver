extends Area2D
class_name Pool

signal pool_entered


func _ready() -> void:
	$Sprite/AnimationPlayer.play("pool_idle", -1, 0.5)
	$Sprite2/AnimationPlayer.play("pool_idle", -1, 0.5)
	$Sprite3/AnimationPlayer.play("pool_idle", -1, 0.5)


func _on_Pool_body_entered(body : Player):
	if body:
		body.enteredPool()
		emit_signal("pool_entered")
