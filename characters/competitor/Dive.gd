extends Dive

const STIKE_POSE_TIMES : = [0.2, 0.5]

onready var strikePoseTimer = $StrikePoseTimer as Timer


func enter_state(params : Dictionary = {}) -> void:
	.enter_state(params)
	strikePoseTimer.start(rand_range(STIKE_POSE_TIMES[0], STIKE_POSE_TIMES[1]) + 1.0)
	
	
func _on_PoseTimer_timeout() -> void:
	._on_PoseTimer_timeout()
	strikePoseTimer.start(rand_range(STIKE_POSE_TIMES[0], STIKE_POSE_TIMES[1]))


func _on_StrikePoseTimer_timeout() -> void:
	strikePose()
	
	
func exit_state() -> void:
	.exit_state()
	strikePoseTimer.stop()
