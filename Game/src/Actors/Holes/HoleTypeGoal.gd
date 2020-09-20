extends Hole


func _ready():
	PlayerData.connect("goal_updated", self, "_update_status")
	$Number.text = str(hole_number)


func update_status(goal: int):
	# This is where we want to update is_goal and change the state of the hole if it is the new goal
	# Need to look at the groups to determine if it is the group of "goal holes"
	if self.is_in_group("Goal"):
		is_goal = goal == hole_number