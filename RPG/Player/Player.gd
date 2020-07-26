extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var MAX_SPEED = 100
export var ROLL_SPEED = 140
export var ACCELERATION = 500
export var FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var rollVector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtBox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	animationTree.active = true
	swordHitbox.knockbackVector = rollVector
	stats.connect("noHealth", self, "queue_free")

func _process(delta):
	match state: 
		MOVE:
			moveState(delta)
		ROLL:
			rollState()
		ATTACK:
			attackState()



func moveState(delta: float):
	var inputVector = setVector()
	
	if inputVector != Vector2.ZERO:
		rollVector = inputVector
		swordHitbox.knockbackVector = inputVector
		animate(inputVector, false)
		move(inputVector, delta, false)
	else:
		animate(inputVector)
		move(inputVector, delta)
	
	updateVelocity()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL
		
func rollState():
	velocity = rollVector * ROLL_SPEED
	animationState.travel("Roll")
	updateVelocity()

func attackState():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	


func updateVelocity():
	velocity = move_and_slide(velocity)



func rollAnimationFinished():
	state = MOVE
	
func attackAnimationFinished():
	state = MOVE

func setVector() -> Vector2:
	var vector = Vector2.ZERO
	vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#Normalize the vector to avoid moving faster when moving diagonally
	vector = vector.normalized()
	return vector



func animate(var inputVector, var isIdle := true):
	if isIdle:
		animationState.travel("Idle")
	else:
		#Set the blend position to our inputVector, whenever we move
		animationTree.set("parameters/Idle/blend_position", inputVector)
		animationTree.set("parameters/Run/blend_position", inputVector)
		animationTree.set("parameters/Attack/blend_position", inputVector)
		animationTree.set("parameters/Roll/blend_position", inputVector)
		animationState.travel("Run")

func move(inputVector: Vector2, delta: float, isIdle := true):
	if isIdle:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		#velocity = inputVector * MAX_SPEED
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtBox.startInvincibility(0.6)
	hurtBox.createHitEffect()
	
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
