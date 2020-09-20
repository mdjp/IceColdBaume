extends RigidBody2D

export (int) var engine_thrust
export (int) var spin_thrust

var thrust = Vector2()
var right_rotation_dir = 0
var left_rotation_dir = 0
var screensize
var beamsize
const angle = PI/100


func _ready():
	screensize = get_viewport().get_visible_rect().size
	beamsize = $Sprite.texture.get_size().x * $Sprite.scale.x * 5.6
	$ResetStateMachine.reset_position_centre = get_parent().get_node("BeamStartPosition").global_position
	PlayerData.connect("reset_beam", self, "_reset")


func _process(delta):
	if $BasicStateMachine.current_state != null:
		$State.text = $BasicStateMachine.states.keys()[$BasicStateMachine.current_state]


func _integrate_forces(state):
	if $BasicStateMachine.current_state == $BasicStateMachine.states.PAUSED:
		return
	
	move_beam()


func move_beam():
	linear_velocity.x = 0
	
	if right_rotation_dir == left_rotation_dir:
		linear_velocity.y = right_rotation_dir * engine_thrust
		angular_velocity = 0
	else:
		var dir = right_rotation_dir - left_rotation_dir
		if _can_rotate(dir):
			var temp = - 1 if left_rotation_dir != 0 else 1
			linear_velocity.y = dir * beamsize * sin(temp * angle)
			angular_velocity = dir * spin_thrust * cos(angle)
		else:
			linear_velocity.y = 0
			angular_velocity = 0


func get_input():
	right_rotation_dir = 0
	if Input.is_action_pressed("right_side_up"):
		right_rotation_dir -= 1
	if Input.is_action_pressed("right_side_down"):
		right_rotation_dir += 1
	
	left_rotation_dir = 0
	if Input.is_action_pressed("left_side_up"):
		left_rotation_dir -= 1
	if Input.is_action_pressed("left_side_down"):
		left_rotation_dir += 1


func get_movement():
	if $ResetStateMachine.current_state == $ResetStateMachine.states.MOVE_VERTICALLY:
		var direction = round($ResetStateMachine.reset_position_centre.y - self.global_position.y)
		if direction != 0:
			right_rotation_dir = sign(direction)
			left_rotation_dir = sign(direction)
		
#		print("direction:" + str(direction))
	
	if $ResetStateMachine.current_state == $ResetStateMachine.states.ROTATE and $ResetStateMachine.continue_rotating():
		var rotation = round($Sprite/LeftSide.global_position.y - $Sprite/RightSide.global_position.y)
		
		right_rotation_dir = 0 if rotation == 0 else sign(rotation)
		left_rotation_dir = 0
		
#		print("rotation:" + str(rotation))


func _can_rotate(direction):
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