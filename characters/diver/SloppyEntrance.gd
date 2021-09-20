extends DiverState
class_name SloppyEntrance

onready var particles = $Particles2D
onready var audio = $SloppyDiveAudio


func enter_state(params : Dictionary = {}) -> void:
	particles.emitting = true
	audio.play()
