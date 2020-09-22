extends Control


func _ready() -> void:
	var label = $Background/MarginContainer/VBoxContainer/Label
	label.text = label.text % [PlayerData.score, PlayerData.target_hole - 1]