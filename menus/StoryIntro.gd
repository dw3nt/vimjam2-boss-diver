extends Control

signal scroll_finished

export(float) var initScrollSpeed : = 30.0

var scrollSpeed : float = initScrollSpeed

onready var storyContainer = $MarginContainer/CenterContainer/VBoxContainer as VBoxContainer
onready var visibility = $MarginContainer/CenterContainer/VBoxContainer/VisibilityNotifier2D as VisibilityNotifier2D


func _ready() -> void:
	visibility.rect = Rect2(
		Vector2(-10, -10),
		storyContainer.rect_size + Vector2(10, -100)
	)
	
	set_process(false)
	
	
func startScroll() -> void:
	set_process(true)


func _input(event) -> void:
	if event.is_action("ui_accept"):
		if event.is_pressed():
			scrollSpeed = initScrollSpeed * 8
		else:
			scrollSpeed = initScrollSpeed
		


func _process(delta : float) -> void:
	storyContainer.rect_position.y -= scrollSpeed * delta


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("scroll_finished")
