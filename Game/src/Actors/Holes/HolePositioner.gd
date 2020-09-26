tool
extends Node

export var hole_scene: PackedScene

func _ready():
	_add_holes()


func _get_configuration_warning() -> String:
	return "The hole scene property can't be empty" if not hole_scene else ""


func _add_holes():
	for child in self.get_children():
		var hole = hole_scene.instance()
		if hole.is_in_group("Goal"):
			hole.hole_number = int(child.name)
		child.add_child(hole)