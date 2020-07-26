extends Node2D

class_name State

var changeState
var animatedSprite
var persistentState
var velocity

func _physics_process(_delta):
	persistentState.move_and_slide(persistentState.velocity, Vector2.UP)
	
func setup(changeState, animatedSprite, persistentState):
	self.changeState = changeState
	self.animatedSprite = animatedSprite
	self.persistentState = persistentState
	
func moveLeft():
	pass
func moveRight():
	pass
func moveUp():
	pass
func moveDown():
	pass
