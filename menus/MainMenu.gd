extends "res://menus/BaseMenu.gd"

export(String, FILE, "*.tscn") var practiceScene

onready var menuContainer = $MenuContainer
onready var anim = $AnimationPlayer
onready var storyIntro = $StoryIntro


func _ready() -> void:
	emit_signal("room_ready")


func _on_PlayButton_pressed() -> void:
	anim.play("fade_out")


func _on_PracticeButton_pressed() -> void:
	emit_signal("room_change_requested", {
		"scene": practiceScene,
		"transition": transition
	})


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_StoryIntro_scroll_finished():
	emit_signal("room_change_requested", {
		"scene": practiceScene,
		"transition": transition
	})
