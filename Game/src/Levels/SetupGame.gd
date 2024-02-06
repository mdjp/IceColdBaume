tool
extends Node2D

const BALL = preload("res://src/Actors/Ball.tscn")
const BEAM = preload("res://src/Actors/Beam.tscn")

const TARGET_HOLE = preload("res://src/Actors/Holes/HoleTypeTarget.tscn")

var beam = null
var ball = null
var timer = null
var ballmoving = false
var balloldpos

export var next_scene: PackedScene


func _ready():
	PlayerData.connect("add_ball", self, "_reset")
	$ScoreScreen.connect("end_game", self, "_end_game")
	beam = BEAM.instance()
	self.add_child(beam)
	beam.global_position = $BeamStartPosition.global_position
	PlayerData.game_started()
	
func _on_StartGameSound_finished():
	$GameMusic.play(0.0)
	



func _reset():
	if !is_instance_valid(ball):
		_add_ball()


func _add_ball():
	$BallDrop.play()
	ball = BALL.instance()
	self.add_child(ball)
	ball.global_position = $BallStartPosition.global_position


func _process(delta):
	
	if !is_instance_valid(ball):
		return
	
	if Input.is_action_just_released("reset_game"):
		_end_game()


func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""


func _end_game():
	$EndGameSound.play()
	get_tree().change_scene_to(next_scene)
