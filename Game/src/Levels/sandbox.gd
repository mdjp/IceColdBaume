tool
extends Node2D

const BALL = preload("res://src/Actors/Ball.tscn")
const BEAM = preload("res://src/Actors/Beam.tscn")


var beam = null
var ball = null


func _ready():
	PlayerData.connect("add_ball", self, "_reset")
	$ScoreScreen.connect("end_game", self, "_end_game")
	
	_add_ball()
	
	beam = BEAM.instance()
	self.add_child(beam)
	beam.global_position = $BeamStartPosition.global_position
	
	PlayerData.game_started()


func _reset():
	_add_ball()


func _add_ball():
	ball = BALL.instance()
	self.add_child(ball)
	ball.global_position = $BallStartPosition.global_position


func _process(delta):
	if ball == null:
		return
	
	if Input.is_action_just_released("reset_game"):
		ball.disappear(false)


func _end_game():
	pass
