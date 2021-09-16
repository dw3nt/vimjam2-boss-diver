extends "res://menus/BaseMenu.gd"

export(String, FILE, "*.tscn") var practiceScene


func _ready() -> void:
	emit_signal("room_ready")


func _on_PlayButton_pressed() -> void:
	pass # Replace with function body.


func _on_PracticeButton_pressed() -> void:
	emit_signal("room_change_requested", {
		"scene": practiceScene,
		"transition": transition
	})


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
