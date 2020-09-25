extends Node2D


func _ready():
	PlayerData.connect("start_game_timer", self, "start_timer")
	PlayerData.connect("end_game", self, "stop_timer")


func _process(delta):
	$Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Balls.text = str(PlayerData.number_of_balls)
	$Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/Bonus.text = str(PlayerData.bonus)
	$Background/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer5/Score.text = str(PlayerData.score)


func _on_timeout():
	PlayerData.bonus -= 10


func start_timer():
	$BonusTimer.start(4)


func stop_timer():
	$BonusTimer.stop()