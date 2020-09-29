extends Node2D

signal end_game


func _ready():
	PlayerData.connect("start_game_timer", self, "start_timer")
	PlayerData.connect("stop_game_timer", self, "stop_timer")
	
	PlayerData.connect("score_updated", self, "score_changed")
	PlayerData.connect("bonus_updated", self, "display_bonus")
	PlayerData.connect("round_updated", self, "display_round")
	PlayerData.connect("ball_count_updated", self, "display_ballcount")
	
	PlayerData.connect("game_ended", self, "game_over")
	
	display_bonus()
	display_round()
	display_ballcount()


func _process(delta):
	pass


func _on_timeout():
	PlayerData.bonus -= 10


func start_timer():
	$BonusTimer.start(4)


func stop_timer():
	$BonusTimer.stop()


func score_changed(old_value, new_value):
	animate_value(old_value, new_value)
	$AnimationTimer.start()


func display_bonus():
	$Background/MarginContainer/HBoxContainer/right/bonusValue/Container/Bonus.text = str(PlayerData.bonus).pad_zeros(4)


func display_round():
	$Background/MarginContainer/HBoxContainer/leftContainer/statuses/RoundLabel.text = "SET\n" + str(PlayerData.set)
	if PlayerData.set > 1:
		$AnimationPlayer.play("new_round")
		$AnimationTimer.start()


func display_ballcount():
	$Background/MarginContainer/HBoxContainer/right/Container/ballCount/Balls.text = str(PlayerData.number_of_balls)


func game_over():
	stop_timer()
	$AnimationPlayer.play("game_over")
	$AnimationTimer.start()


func _on_AnimationTimer_timeout():
	var current = $AnimationPlayer.current_animation
	$AnimationPlayer.stop()
	if current == "game_over":
		emit_signal("end_game")


func animate_value(start, end):
	$Tween.interpolate_method(self, "set_score_text", start, end, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	$AnimationPlayer.play("score_updated")


func set_score_text(value):
	var display_number = stepify(value, 10)
	$Background/MarginContainer/HBoxContainer/right/scoreValue/Container/Score.text = str(display_number).pad_zeros(5)
