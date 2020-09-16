extends Node

signal score_updated
signal ball_went_through_hole
signal goal_updated

var goal_hole: = 1 setget set_goal
var max_holes: = 10
var number_of_balls: = 3 setget set_balls

func _ready():
	goal_hole = 1
	number_of_balls = 3
	connect("ball_went_through_hole", self, "reset_game")

func reset(start_hole = 1, ball_count = 3) -> void:
	goal_hole = start_hole
	number_of_balls = ball_count

func set_goal(value: int) -> void:
	if value in range(1, max_holes):
		goal_hole = value
		emit_signal("goal_updated", goal_hole)

func set_balls(value: int) -> void:
	if value > -1:
		number_of_balls = value

func reset_game():
	if number_of_balls > 0:
		# Add a new ball to the scene
		# Move the beam down again
		pass
	else:
		reset()