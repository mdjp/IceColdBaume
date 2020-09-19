extends StateMachine

var old_rotation

func _ready() -> void:
	add_state("IDLE") # Refers to the state where the player can move the beam using inputs
	add_state("MOVE_VERTICALLY")
	add_state("ROTATE")

	# To ensure the beam is idle initially
	call_deferred("set_state", states.IDLE)


func _state_logic(delta):
	pass


func _get_transition(delta):
	match current_state:
		states.IDLE:
			if is_in_reset():
				return states.MOVE_VERTICALLY
		states.MOVE_VERTICALLY:
			if not is_in_reset():
				return states.IDLE
			
			if not continue_vertically():
				return states.ROTATE
		states.ROTATE:
			if not is_in_reset():
				return states.IDLE
			
			if not continue_rotating():
				leave_reset_state()
				return states.IDLE


func _enter_state(new_state, old_state):
	match new_state:
		states.IDLE:
			pass
		states.MOVE_VERTICALLY:
			pass
		states.ROTATE:
			pass


func _exit_state(old_state, new_state):
	match old_state:
		states.IDLE:
			pass
		states.MOVE_VERTICALLY:
			pass
		states.ROTATE:
			pass


func is_in_reset():
	var basicState = parent.get_node("BasicStateMachine")
	return basicState.current_state == basicState.states.RESETTING


func leave_reset_state():
	var basicState = parent.get_node("BasicStateMachine")
	basicState.current_state = basicState.states.IDLE


func continue_vertically():
	var direction = round(parent.get_node("BasicStateMachine").reset_position_centre.y - parent.global_position.y)
	return direction != 0


func continue_rotating():
	var rotation = round(parent.get_node("BasicStateMachine").reset_position_right.y - parent.get_node("Sprite/RightSide").global_position.y)
	if old_rotation == null or sign(old_rotation) == sign(rotation):
		old_rotation = rotation
		return rotation != 0
	else:
		return false