extends DiverState
class_name GroundSplat

signal ground_splat_finished

onready var splatAudio = $SplatAudio as AudioStreamPlayer
onready var timer = $Timer as Timer


func enter_state(params : Dictionary = {}) -> void:
	fsm.sprite.rotation_degrees = 0
	fsm.velocity = Vector2(0, GRAVITY)
	fsm.anim.play("splat")
	splatAudio.play()
	timer.start()
	

func _on_Timer_timeout():
	emit_signal("ground_splat_finished")
