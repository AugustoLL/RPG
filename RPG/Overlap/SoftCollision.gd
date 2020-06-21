extends Area2D

func isColliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0

func getPushVector():
	var areas = get_overlapping_areas()
	var pushVector = Vector2.ZERO
	if isColliding():
		var area = areas[0]
		pushVector = area.global_position.direction_to(global_position)
		pushVector = pushVector.normalized()
	return pushVector
