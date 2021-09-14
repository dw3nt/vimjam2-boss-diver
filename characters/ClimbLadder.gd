extends PlayerState

const CLIMB_SPEED : = 80

var pathAnimMap = {	
	1: "walk",
	2: "climb",
	3: "climb",
	4: "walk",
	5: "idle"
}

var path : Path2D
var pathFollow : PathFollow2D
var nextPointIndex : int = 0


func enter_state(params : Dictionary = {}) -> void:
	path = pathFollow.get_parent()
	fsm.anim.play("walk")
	
	
func process(delta : float) -> void:
	if pathFollow.unit_offset == 0.0:
		print(global_position)
	
	if pathFollow.unit_offset < 1.0:
		pathFollow.offset += CLIMB_SPEED * delta
	else:
		fsm.change_state("WalkBoard")
		
		
	if nextPointIndex < path.curve.get_point_count() && global_position.x > path.curve.get_point_position(nextPointIndex).x:
		nextPointIndex += 1
		updateClimbAnimation()
		
		
func updateClimbAnimation() -> void:
	if pathAnimMap.keys().has(nextPointIndex):
		fsm.anim.play(pathAnimMap[nextPointIndex])
