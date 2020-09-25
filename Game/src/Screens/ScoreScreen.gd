extends Node2D

signal end_game


func _ready():
	PlayerData.connect("start_game_timer", self, "start_timer")
	PlayerData.connect("stop_game_timer", self, "stop_timer")
	PlayerData.connect("game_ended", self, "game_over")


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


func game_over():
	stop_timer()
	$AnimationPlayer.play("game_over")
	$AnimationTimer.start()


func _on_AnimationTimer_timeout():
	var current = $AnimationPlayer.current_animation
	$AnimationPlayer.stop()
	if current == "game_over":
		emit_signal("end_game")
