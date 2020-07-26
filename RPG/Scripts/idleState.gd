extends State

class_name IdleState

func _ready():
	animatedSprite.play("idle")

func _flip_direction():
	animatedSprite.flip_h = not animatedSprite.flip_h

func moveLeft():
	if animatedSprite.flip_h:
		changeState.call_func("run")
	else:
		_flip_direction()

func moveRight():
	if animatedSprite.flip_h:
		changeState.call_func("run")
	else:
		_flip_direction()
