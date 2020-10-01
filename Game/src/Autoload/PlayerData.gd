extends Node

signal score_updated
signal bonus_updated
signal round_updated
signal target_updated
signal ball_count_updated

signal reset_beam
signal add_ball
signal game_ended
signal start_game_timer
signal stop_game_timer
signal pause_game

var score: = 0 setget set_score
var bonus: = 100 setget set_bonus
var set: = 1 setget set_round
var target_hole setget set_target
var max_holes: = 10
var number_of_balls: = 3 setget set_balls


func _ready():
	pass


func reset(start_hole = 1, ball_count = 3) -> void:
	# The setter functions need to be used in order to trigger the signals
	set_target(start_hole)
	set_balls(ball_count)
	score = 0 # Note: we don't want to trigger the animation so the function is not used
	set_bonus(100 * target_hole)
	set = 1


func set_score(value: int) -> void:
	if value > -1:
		emit_signal("score_updated", score, value)
		score = value


func set_bonus(value: int) -> void:
	if value > -1:
		bonus = value
		emit_signal("bonus_updated")


func set_round(value: int) -> void:
	if value > 0:
		set = value
		emit_signal("round_updated")


func set_target(value: int) -> void:
	var small_value = value
	if small_value > max_holes:
		small_value = small_value % max_holes
		set_round(set + 1)
	
	if small_value in range(1, max_holes + 1):
		emit_signal("target_updated", target_hole, small_value) # old_target, new_target
		target_hole = small_value
		set_bonus(100 * target_hole)


func set_balls(value: int) -> void:
	if value > -1:
		number_of_balls = value
		emit_signal("ball_count_updated")


func reset_game():
	emit_signal("reset_beam") # Once the beam is reset it checks whether a new ball needs to be added
	if number_of_balls == 0:
		emit_signal("game_ended")


func game_started():
	reset()
	emit_signal("start_game_timer")