extends Control

var hearts = 5 setget setHearts
var maxHearts = 5 setget setMaxHearts

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func setHearts(value):
	hearts = clamp(value, 0, maxHearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15

func setMaxHearts(value):
	maxHearts = max(value, 1)
	self.hearts = min(hearts, maxHearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = maxHearts * 15

func _ready():
	self.maxHearts = PlayerStats.maxHealth
	self.hearts = PlayerStats.health
	# warning-ignore:return_value_discarded
	PlayerStats.connect("healthChanged", self, "setHearts")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("maxHealthChanged", self, "setMaxHearts")
