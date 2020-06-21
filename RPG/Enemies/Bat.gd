extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO
var state = CHASE
var velocity = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionArea = $PlayerDetectionArea
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	state = pickRandomState([IDLE, WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seekPlayer()
			if wanderController.getTimeLeft() == 0:
				pickRandomStateStartWanderTimer()
		WANDER:
			seekPlayer()
			if wanderController.getTimeLeft() == 0:
				pickRandomStateStartWanderTimer()
			accelerateTowardsPoint(wanderController.targetPosition, delta)

			var wanderTargetRange = int(round(global_position.distance_to(wanderController.targetPosition)))
			if  wanderTargetRange <= 4:
				pickRandomStateStartWanderTimer()
		CHASE:
			var player = playerDetectionArea.player
			if player != null:
				#Get the vector between us and the player
				accelerateTowardsPoint(player.global_position, delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0 
	
	if softCollision.isColliding():
		velocity += softCollision.getPushVector() * delta * 400
	velocity = move_and_slide(velocity)


func pickRandomStateStartWanderTimer():
	state = pickRandomState([IDLE, WANDER])
	wanderController.startWanderTimer(rand_range(1, 3))

func accelerateTowardsPoint(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func seekPlayer():
	if playerDetectionArea.canSeePlayer():
		state = CHASE

func pickRandomState(stateList):
	stateList.shuffle()
	return stateList.pop_front()

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockbackVector * 120
	hurtbox.createHitEffect()
	hurtbox.startInvincibility(0.3)

func _on_Stats_noHealth():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
