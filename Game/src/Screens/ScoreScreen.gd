extends Node2D


func _ready():
	PlayerData.connect("start_game_timer", self, "start_timer")
	PlayerData.connect("stop_game_timer", self, "stop_timer")


func _process(delta):
	$Background/MarginContainer/HBoxContainer/leftContainer/statuses/RoundLabel.text = "SET\n" + str(PlayerData.set)
	$Background/MarginContainer/HBoxContainer/right/Container/ballCount/Balls.text = str(PlayerData.number_of_balls)
	$Background/MarginContainer/HBoxContainer/right/bonusValue/Container/Bonus.text = str(PlayerData.bonus).pad_zeros(4)
	$Background/MarginContainer/HBoxContainer/right/scoreValue/Container/Score.text = str(PlayerData.score).pad_zeros(5)


func _on_timeout():
	PlayerData.bonus -= 10


func start_timer():
	$BonusTimer.start(4)


func stop_timer():
	$BonusTimer.stop()