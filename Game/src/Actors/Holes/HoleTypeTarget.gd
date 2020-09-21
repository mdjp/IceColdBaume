extends Hole


func _ready():
#	PlayerData.connect("target_updated", self, "_update_status")
	$Number.text = str(hole_number)


func update_status(is_target: bool):
	# This is where we want to update is_target and change the state of the hole if it is the new target
	# Need to look at the groups to determine if it is the group of "target holes"
	if self.is_in_group("Goal"):
		self.is_target = is_target
		
		_update_animation()


func _update_animation():
	if is_target:
		$AnimatedSprite.play("target")
	else:
		$AnimatedSprite.play("idle")