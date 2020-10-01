extends Area2D
class_name Hole

export (bool) var is_target := false
export (int) var hole_size_number
export (int) var hole_number
export (int) var wobble


func _ready():
	pass


func _on_ball_entered(area):
	# Check if the body is ball
	var object = area.get_parent()
	if not object.is_in_group("Ball"):
		return
	# If is_goal
	object.disappear_animation(is_target, self.global_position)
	PlayerData.emit_signal("pause_game")
