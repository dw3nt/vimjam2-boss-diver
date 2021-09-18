extends Button

onready var pressedAudio = $PressedAudioPlayer
onready var hoverAudio = $HoverAudioPlayer


func _on_BaseButton_mouse_entered():
	hoverAudio.play()


func _on_BaseButton_pressed():
	pressedAudio.play()
