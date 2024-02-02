tool
extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timer = null
export(String, FILE) var next_scene_path: = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("start_game"):
		print("started")
		PlayerData.reset()
		get_tree().change_scene(next_scene_path)
