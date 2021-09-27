extends TextureButton

onready var hoverAudio = $HoverAudio


func _on_ArrowButton_mouse_entered():
	hoverAudio.play()
