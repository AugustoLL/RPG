extends Node2D

#Load the scene with the Grass Effect animation
#Use preload instead of load so it only loads the effect once and shares it
const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func createGrassEffect():
		#Instance the scene
		var grassEffect = GrassEffect.instance()
		#Get the world node and add the instance to the world node as a child
		get_parent().add_child(grassEffect)
		#Put the animations in the global position of the grass
		grassEffect.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	createGrassEffect()
	queue_free()
