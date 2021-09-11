extends "res://menus/BaseMenu.gd"


func _ready():
#	emit_signal('room_ready')	# causes a flicker between boot splash and scene if enabled - all it does is play transition exit
	yield(get_tree().create_timer(1.0), "timeout")
	emit_signal("room_change_requested", {"scene": nextScene, "transition": transition})
