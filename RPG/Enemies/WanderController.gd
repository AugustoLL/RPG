extends Node2D

export(int) var wanderRange = 32

onready var timer = $Timer
onready var startPosition = global_position
onready var targetPosition = global_position


func updateTargetPosition():
	var targetVector = Vector2(rand_range(-wanderRange, wanderRange), rand_range(-wanderRange, wanderRange))
	targetPosition = startPosition + targetVector

func getTimeLeft():
	return timer.time_left

func startWanderTimer(duration):
	timer.start(duration)

func _on_Timer_timeout():
	updateTargetPosition()
