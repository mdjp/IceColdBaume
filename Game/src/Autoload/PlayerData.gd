extends Node

signal score_updated
signal target_updated
signal reset_beam
signal add_ball
signal end_game

var score: = 0
var target_hole: = 1 setget set_target
var max_holes: = 10
var number_of_balls: = 3 setget set_balls


func _ready():
	target_hole = 1
	number_of_balls = 3


func reset(start_hole = 1, ball_count = 3) -> void:
	target_hole = start_hole
	number_of_balls = ball_count


func set_target(value: int) -> void:
	if value in range(1, max_holes):
		emit_signal("target_updated", target_hole, value) # old_target, new_target
		target_hole = value


func set_balls(value: int) -> void:
	if value > -1:
		number_of_balls = value


func reset_game():
	emit_signal("reset_beam") # Once the beam is reset it checks whether a new ball needs to be added
	if number_of_balls == 0:
		print("Game ended")
		emit_signal("end_game")