extends Particles2D

onready var timer = $Timer as Timer


func _ready() -> void:
	timer.start(lifetime)


func _on_Timer_timeout():
	queue_free()
