extends Dive


func input(event) -> void:
	if canInput && event.is_action_pressed("walk") || event.is_action_pressed("jump"):
		inputs += 1
		canInput = false
		fsm.sprite.frame = choosePoseFrame()
		poseTimer.start(inputCooldown)
		poseAudio.pitch_scale += 0.05
		poseAudio.play()
		instancePoseParticles()
