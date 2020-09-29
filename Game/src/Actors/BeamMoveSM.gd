extends StateMachine

var linear_velocity_Y = 0
var linear_velocity_X = 0 # Beam should never move in this direction
var angular_velocity = 0

const angle = PI/45
onready var basicState = parent.get_node("BasicStateMachine")


func _ready() -> void:
	add_state("STATIONARY")
	add_state("MOVE_VERTICALLY")
	add_state("ROTATE")

	# To ensure the beam is stationary initially
	call_deferred("set_state", states.STATIONARY)


func _state_logic(delta):
	pass


func _get_transition(delta):
	if basicState.right_direction == basicState.left_direction and basicState.right_direction != 0:
		return states.MOVE_VERTICALLY
	else:
		if parent._can_rotate(basicState.right_direction - basicState.left_direction):
			return states.ROTATE
		else:
			return states.STATIONARY


func _enter_state(new_state, old_state):
	match new_state:
		states.STATIONARY:
			linear_velocity_Y = 0
			linear_velocity_X = 0
			angular_velocity = 0
		states.MOVE_VERTICALLY:
			linear_velocity_Y = basicState.right_direction * parent.engine_thrust
			linear_velocity_X = 0
			angular_velocity = 0
		states.ROTATE:
			var opp_pivot_dir = - 1 if basicState.left_direction != 0 else 1
			var final_direction = basicState.right_direction - basicState.left_direction
			linear_velocity_Y = final_direction * parent.spin_thrust * parent.beamSizeRatio * sin(opp_pivot_dir * angle)
			linear_velocity_X = 0
			angular_velocity = final_direction * parent.spin_thrust * sin(opp_pivot_dir * angle) * opp_pivot_dir


func _exit_state(old_state, new_state):
	match old_state:
		states.STATIONARY:
			pass
		states.MOVE_VERTICALLY:
			pass
		states.ROTATE:
			pass
