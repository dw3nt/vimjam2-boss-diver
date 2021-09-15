extends StaticBody2D
class_name Floor

signal dive_finished


func _on_DiveFinishedDetect_body_entered(body):
	emit_signal("dive_finished")
