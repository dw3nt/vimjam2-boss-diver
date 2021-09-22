extends "res://rooms/BaseRoom.gd"

const MAIN_MENU_SCENE = "res://menus/MainMenu.tscn"

onready var publicPool = $PublicPool


func _ready() -> void:
	if params:
		publicPool.judgesTable.currentJudges = params.judges
	
	publicPool.diverScene = preload("res://characters/player/Player.tscn")
	publicPool.initScene()
	
	yield(get_tree().create_timer(0.25), "timeout")
	emit_signal("room_ready")


func _on_PublicPool_main_menu_button_pressed():
	emit_signal("room_change_requested", { "scene": MAIN_MENU_SCENE })


func _on_PublicPool_retry_button_pressed():
	emit_signal("room_change_requested", { "scene": filename, "params": { "judges": publicPool.judgesTable.currentJudges } })
