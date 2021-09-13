extends Area2D
class_name Pool

var moveSpeed : = 6.0

signal pool_entered

onready var sprite = $Sprite


func _process(delta : float) -> void:
	sprite.region_rect.position.x += moveSpeed * delta
	if abs(sprite.region_rect.position.x) > 12:
		moveSpeed *= -1


func _on_Pool_body_entered(body : Player):
	if body:
		body.enteredPool()
		emit_signal("pool_entered")
