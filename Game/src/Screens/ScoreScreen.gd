extends CanvasLayer


func _ready():
	PlayerData.connect("start_game_timer", self, "start_timer")
	PlayerData.connect("end_game", self, "stop_timer")


func _process(delta):
	$Background/MarginContainer/VBoxContainer/Score.text = "Score: " + str(PlayerData.score)
	$Background/MarginContainer/VBoxContainer/Bonus.text = "Bonus: " + str(PlayerData.bonus)


func _on_timeout():
	PlayerData.bonus -= 10


func start_timer():
	$BonusTimer.start(4)


func stop_timer():
	$BonusTimer.stop()