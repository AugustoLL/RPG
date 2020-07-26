extends State

class_name RunState

var moveSpeed = Vector2(180, 0)
var minMoveSpeed = 0.005
var friction = 0.32

func _ready():
	animatedSprite.play("run")
	if animatedSprite.flip_h:
		moveSpeed.x *= -1
	persistentState.velocity += moveSpeed

func _physics_process(_delta):
	if abs(velocity) < minMoveSpeed:
		 changeState.call_func("idle")
	persistentState.velocity.x *= friction

func moveLeft():
	if animatedSprite.flip_h:
		persistentState.velocity += moveSpeed
	else:
		changeState.call_func("idle")

func moveRight():
	if not animatedSprite.flip_h:
		persistentState.velocity += moveSpeed
	else:
		changeState.call_func("idle")
