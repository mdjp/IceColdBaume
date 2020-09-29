extends RigidBody2D

var goal_achieved: = false


func _ready():
	# PlayerData.connect("ball_went_through_hole", self, "_ball_disappear")
	pass


func disappear_animation(achieved_goal : bool) -> void:
	goal_achieved = achieved_goal
	$HoleDetector/DisappearTimer.start()
	linear_velocity.x = 0
	linear_velocity.y = 0
	angular_velocity = 0
	gravity_scale = 0


func disappear(achieved_goal : bool) -> void:
	if achieved_goal:
		PlayerData.score += PlayerData.bonus
		PlayerData.target_hole += 1
	else:
		# Decrease the number of balls left and end the game
		PlayerData.number_of_balls -= 1
		pass
	
	PlayerData.reset_game()
	queue_free()


func _on_screen_exited():
	disappear(false)


func _on_Disappear_timeout():
	disappear(goal_achieved)
