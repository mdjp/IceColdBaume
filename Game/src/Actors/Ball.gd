extends RigidBody2D

var goal_achieved: = false
var position_to_tween_to


func _ready():
	# PlayerData.connect("ball_went_through_hole", self, "_ball_disappear")
	pass


func disappear_animation(achieved_goal : bool, hole_centre) -> void:
	goal_achieved = achieved_goal
	position_to_tween_to = hole_centre
	$BasicStateMachine.current_state = $BasicStateMachine.states.ENTERED_HOLE


func remove_ball() -> void:
	if goal_achieved:
		var playsound = get_parent().get_node("ScoreScreen/Scored")
		playsound.play()
		PlayerData.score += PlayerData.bonus
		PlayerData.target_hole += 1
	else:
		var playsound = get_parent().get_node("ScoreScreen/Missed")
		playsound.play()
		# Decrease the number of balls left and end the game
		PlayerData.number_of_balls -= 1
		pass
	
	PlayerData.reset_game_components()
	queue_free()


func _on_screen_exited():
	if $BasicStateMachine.current_state != $BasicStateMachine.states.DISAPPEAR:
		goal_achieved = false
		$BasicStateMachine.current_state = $BasicStateMachine.states.DISAPPEAR


func _on_Tween_completed(object, key):
	$Tween.interpolate_property(self, "global_position:y", self.global_position.y, self.global_position.y + 4, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT) 
	$Tween.start()
	$AnimationPlayer.play("disappear")


func _on_second_Tween_completed(object, key):
	pass


func _on_AnimationPlayer_finished(anim_name):
	if anim_name == "disappear":
		$BasicStateMachine.current_state = $BasicStateMachine.states.DISAPPEAR
