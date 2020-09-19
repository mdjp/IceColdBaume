extends CanvasLayer

func _physics_process(delta):
	$MarginContainer/HBoxContainer/VBoxContainer/Stat01.text = "Number of balls left: " + str(PlayerData.number_of_balls)
	$MarginContainer/HBoxContainer/VBoxContainer/Stat02.text = "Goal Hole: " + str(PlayerData.goal_hole)