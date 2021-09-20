extends DiverState
class_name GracefulEntrance

onready var particles = $Particles2D
onready var audio = $GracefulDiveAudio


func enter_state(params : Dictionary = {}) -> void:
	particles.emitting = true
	audio.play()
