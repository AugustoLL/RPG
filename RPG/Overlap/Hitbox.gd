extends Area2D

export var damage = 1
var player = null

func canHitPlayer():
	return player != null

func _on_Hitbox_body_entered(body):
	player = body

func _on_Hitbox_body_exited(_body):
	player = null
