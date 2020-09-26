tool
extends Node2D

const BALL = preload("res://src/Actors/Ball.tscn")
const BEAM = preload("res://src/Actors/Beam.tscn")

const TARGET_HOLE = preload("res://src/Actors/Holes/HoleTypeTarget.tscn")

var beam = null
var ball = null

export var next_scene: PackedScene


func _ready():
	PlayerData.connect("add_ball", self, "_reset")
	PlayerData.connect("target_updated", self, "_change_target")
	$ScoreScreen.connect("end_game", self, "_end_game")
	
	_add_target_holes()
	_set_hole_target_status(PlayerData.target_hole, true)
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


func _change_target(old_target, new_target):
	_set_hole_target_status(old_target, false)
	_set_hole_target_status(new_target, true)


func _add_target_holes():
	var parent_node = get_node("Holes/Targets")
	if parent_node != null:
		for child in parent_node.get_children():
			var hole = TARGET_HOLE.instance()
			hole.hole_number = int(child.name)
			child.add_child(hole)


func _set_hole_target_status(number, target_status):
	var hole = get_node("Holes/Targets/" + str(number) + "/Hole")
	if hole != null:
		hole.update_status(target_status)


func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""


func _end_game():
	get_tree().change_scene_to(next_scene)