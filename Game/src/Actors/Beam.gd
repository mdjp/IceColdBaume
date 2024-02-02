extends RigidBody2D

export (int) var engine_thrust
export (int) var spin_thrust


var beamSizeRatio


func _ready():
	beamSizeRatio = _get_beamSizeRatio($Sprite.scale, $Sprite/RightSide.position)
	$ResetStateMachine.reset_position_centre = get_parent().get_node("BeamStartPosition").global_position
	PlayerData.connect("reset_beam", self, "_reset")
	PlayerData.connect("pause_game", self, "_pause")


func _process(delta):
	if $BasicStateMachine.current_state != null:
		$State.text = $BasicStateMachine.states.keys()[$BasicStateMachine.current_state]


func _integrate_forces(state):
	linear_velocity.x = $MovementStateMachine.linear_velocity_X
	linear_velocity.y = $MovementStateMachine.linear_velocity_Y
	angular_velocity = $MovementStateMachine.angular_velocity


func get_user_movement():
	return [get_input("right"), get_input("left")]
	


func get_input(string_side: String):
	var dir = 0
	var rotation = round($Sprite/LeftSide.global_position.y - $Sprite/RightSide.global_position.y)
	var high = 0;
#	if(abs(rotation) > 80 && $Sprite/LeftSide.global_position.y < $Sprite/RightSide.global_position.y):
#		high = 1
#	elif(abs(rotation) > 80 && $Sprite/LeftSide.global_position.y > $Sprite/RightSide.global_position.y):
#		high = 2	
#	if(high == 0):
	if Input.is_action_pressed(string_side + "_side_up"):
		dir -= 1
	if Input.is_action_pressed(string_side +"_side_down"):
		dir += 1
	return dir

func get_input2(string_side: String):
	var dir = 0
	if Input.is_action_pressed(string_side + "_side_up"):
		dir -= 1
	if Input.is_action_pressed(string_side +"_side_down"):
		dir += 1
	return dir


func get_auto_movement():
	var right_rotation_dir = 0
	var left_rotation_dir = 0
	if $ResetStateMachine.current_state == $ResetStateMachine.states.MOVE_VERTICALLY:
		var direction = round($ResetStateMachine.reset_position_centre.y - self.global_position.y)
		if direction != 0:
			right_rotation_dir = sign(direction)
			left_rotation_dir = sign(direction)
	
	if $ResetStateMachine.current_state == $ResetStateMachine.states.ROTATE:
		
		var rotation = round($Sprite/LeftSide.global_position.y - $Sprite/RightSide.global_position.y)
		if sign(rotation) > 0: # Then we want to rotate the right side
			right_rotation_dir = sign(rotation)
		elif sign(rotation) < 0: # Then we want to rotate the left side
			left_rotation_dir = sign(rotation) * -1

	return [right_rotation_dir, left_rotation_dir]


func _can_rotate(direction):
	var tilt_limiter = 400
	# need to be position relative to screen
	var left = $Sprite/LeftSide.global_position
	var right = $Sprite/RightSide.global_position	
	var x = right.x - left.x
	var y = right.y - left.y
	if y == 0:
		return true
	elif abs(x) <= abs(y):
		if y < 0:
			
			return sign(x) == sign(direction)
		else:
			return sign(x) != sign(direction)
	else:
		return abs(x) > abs(y)


func _reset():
	$BasicStateMachine.current_state = $BasicStateMachine.states.RESETTING


func _get_beamSizeRatio(sprite_scale, side_position):
	return abs(side_position.x) * sprite_scale.x


func _pause():
	$BasicStateMachine.current_state = $BasicStateMachine.states.PAUSED
