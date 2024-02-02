extends Node2D


func _ready():
	PlayerData.connect("target_updated", self, "_change_target")
	_set_hole_target_status(PlayerData.target_hole, true)


func _change_target(old_target, new_target):
	_set_hole_target_status(old_target, false)
	_set_hole_target_status(new_target, true)


func _set_hole_target_status(number, target_status):
	var hole = get_node("Holes/" + str(number) + "/Hole")
	if hole != null:
		hole.update_status(target_status)
