extends Node

signal score_updated
#signal bonus_updated
signal target_updated
signal reset_beam
signal add_ball
signal game_ended
signal start_game_timer
signal stop_game_timer

var score setget set_score
var bonus setget set_bonus
var set setget set_round
var target_hole setget set_target
var max_holes: = 10
var number_of_balls: = 3 setget set_balls


func _ready():
	reset()


func reset(start_hole = 1, ball_count = 3) -> void:
	target_hole = start_hole
	number_of_balls = ball_count
	score = 0
	bonus = 100 * target_hole
	set = 1


func set_score(value: int) -> void:
	if value > -1:
		score = value
		emit_signal("score_updated")


func set_bonus(value: int) -> void:
	if value > -1:
		bonus = value
#		emit_signal("bonus_updated")


func set_round(value: int) -> void:
	if value > 0:
		set = value


func set_target(value: int) -> void:
	var small_value = value
	if small_value > max_holes:
		small_value = small_value % max_holes
		set += 1
	
	if small_value in range(1, max_holes + 1):
		emit_signal("target_updated", target_hole, small_value) # old_target, new_target
		target_hole = small_value
		bonus = 100 * target_hole


func set_balls(value: int) -> void:
	if value > -1:
		number_of_balls = value


func reset_game():
	emit_signal("reset_beam") # Once the beam is reset it checks whether a new ball needs to be added
	if number_of_balls == 0:
		print("Game ended")
		emit_signal("game_ended")


func game_started():
	emit_signal("start_game_timer")