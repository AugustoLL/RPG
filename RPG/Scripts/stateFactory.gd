class_name StateFactory

var states

func _init():
	states = {
		"idle": IdleState,
		"run": RunState
}

func getState(stateName):
	if states.has(stateName):
		return states.get(stateName)
	else:
		printerr("No state ", stateName, " in state factory!")
