extends Node2D

const BALL = preload("res://src/Actors/Ball.tscn")
const BEAM = preload("res://src/Actors/Beam.tscn")

var beam = null


func _ready():
	PlayerData.connect("reset_game", self, "_reset")
	get_node("Holes/Hole " + str(PlayerData.goal_hole)).update_status(PlayerData.goal_hole)
	
	_add_ball()
	
	beam = BEAM.instance()
	self.add_child(beam)
	beam.position = $BeamStartPosition.global_position


func _reset():
	beam.reset_state = true
	beam.reset_position = $BeamStartPosition.global_position
	_add_ball()


func _add_ball():
	var ball = BALL.instance()
	self.add_child(ball)
	ball.position = $BallStartPosition.global_position