extends AnimatedSprite

func _ready():
	var _error = connect("animation_finished", self, "_on_animation_finished")
	#Set the frame to 0 before playing it so it doesn't start after the first frame
	frame = 0
	#Play the animation
	play("Animate")

#Signal to destroy the animation when the animation is over
func _on_animation_finished():
	queue_free()
