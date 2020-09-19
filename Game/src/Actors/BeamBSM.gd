extends StateMachine

var reset_position_centre = Vector2()
var reset_position_right = Vector2()


func _ready() -> void:
	add_state("IDLE") # Refers to the state where the player can move the beam using inputs
	add_state("RESETTING")
	add_state("PAUSED")

	# To ensure the beam is idle initially
	call_deferred("set_state", states.IDLE)


func _state_logic(delta):
	pass


func _get_transition(delta):
	match current_state:
		states.IDLE:
			pass
		states.RESETTING:
			if round(parent.global_position.y) == reset_position_centre.y and round(parent.get_node("Sprite/RightSide").global_position.y) == reset_position_right.y:
				return states.IDLE
		states.PAUSED:
			pass


func _enter_state(new_state, old_state):
	match new_state:
		states.IDLE:
			pass
		states.RESETTING:
			pass
		states.PAUSED:
			pass


func _exit_state(old_state, new_state):
	match old_state:
		states.IDLE:
			pass
		states.RESETTING:
			PlayerData.emit_signal("add_ball")
		states.PAUSED:
			pass