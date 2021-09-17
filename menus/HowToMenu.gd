extends Control

signal main_menu_pressed


func _on_MainMenu_pressed() -> void:
	emit_signal("main_menu_pressed")
