extends Control

signal scroll_finished

export(float) var initScrollSpeed : = 30.0

var isScrolling : bool = false
var scrollSpeed : float = initScrollSpeed
var scrollSkipRequested : bool = false

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
	isScrolling = true


func _input(event) -> void:
	if event.is_action("scroll_speed_up"):
		if event.is_pressed():
			scrollSpeed = initScrollSpeed * 8
		else:
			scrollSpeed = initScrollSpeed
			
	if event.is_action("scroll_skip") && event.is_pressed():
		if !scrollSkipRequested:
			emit_signal("scroll_finished")
			scrollSkipRequested = true
		


func _process(delta : float) -> void:
	storyContainer.rect_position.y -= scrollSpeed * delta


func _on_VisibilityNotifier2D_screen_exited():
	if !scrollSkipRequested && isScrolling:
		emit_signal("scroll_finished")
		scrollSkipRequested = true
