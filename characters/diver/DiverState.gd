extends BaseState
class_name DiverState

const GRAVITY : float = 1.0
const AIR_RESIST : float = 0.01

var fsm : DiverStateMachine


func enteredPool() -> bool:
	return true
