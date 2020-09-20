extends StateMachine


func _ready() -> void:
	add_state("WAITING") # Refers to the state where the player can move the beam using inputs
	add_state("RESETTING")
	add_state("PAUSED")

	# To ensure the beam is idle initially
	call_deferred("set_state", states.WAITING)


func _state_logic(delta):
	match current_state:
		states.WAITING:
			parent.get_input()
		states.RESETTING:
			parent.get_movement()
		states.PAUSED:
			pass


func _get_transition(delta):
	match current_state:
		states.WAITING:
			pass
		states.RESETTING:
			pass
		states.PAUSED:
			pass


func _enter_state(new_state, old_state):
	match new_state:
		states.WAITING:
			pass
		states.RESETTING:
			pass
		states.PAUSED:
			pass


func _exit_state(old_state, new_state):
	match old_state:
		states.WAITING:
			pass
		states.RESETTING:
			PlayerData.emit_signal("add_ball")
		states.PAUSED:
			pass