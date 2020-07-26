extends KinematicBody2D

class_name PersistentState

var state
var stateFactory

var velocity = Vector2()

func _ready():
	stateFactory = StateFactory.new()
	change_state("idle")

# Input code was placed here for tutorial purposes.
func _process(_delta):
	if Input.is_action_pressed("ui_left"):
		moveLeft()
	elif Input.is_action_pressed("ui_right"):
		moveRight()

func moveLeft():
	state.moveLeft()

func moveRight():
	state.moveRight()

func change_state(newStateName):
	state.queue_free()
	state = stateFactory.get_state(newStateName).new()
	state.setup(funcref(self, "change_state"), $AnimatedSprite, self)
	state.name = "current_state"
	add_child(state)
