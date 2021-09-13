extends Area2D
class_name Pool

signal pool_entered


func _on_Pool_body_entered(body : Player):
	if body:
		body.enteredPool()
		emit_signal("pool_entered")
