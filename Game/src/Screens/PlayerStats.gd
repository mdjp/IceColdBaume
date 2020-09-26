extends CanvasLayer

func _physics_process(delta):
	$MarginContainer/HBoxContainer/VBoxContainer/Stat01.text = "Number of balls left: " + str(PlayerData.number_of_balls)
	$MarginContainer/HBoxContainer/VBoxContainer/Stat02.text = "target Hole: " + str(PlayerData.target_hole)
	$MarginContainer/HBoxContainer/VBoxContainer/Stat03.text = "bonus: " + str(PlayerData.bonus)
	$MarginContainer/HBoxContainer/VBoxContainer/Stat04.text = "score: " + str(PlayerData.score)