extends Area2D

#Load the scene with the Grass Effect animation
#Use preload instead of load so it only loads the effect once and shares it
const HitEffect = preload("res://Effects/HitEffect.tscn")

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

var invincible = false setget setInvincible

signal invincibility_started
signal invincibility_ended


func createHitEffect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func setInvincible(value: bool):
	invincible = value
	if invincible:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func startInvincibility(duration):
	self.invincible = true
	timer.start(duration)


func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invincibility_started():
	collisionShape.set_deferred("disabled", true)

func _on_Hurtbox_invincibility_ended():
	collisionShape.disabled = false
