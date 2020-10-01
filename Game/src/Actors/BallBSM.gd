extends StateMachine

onready var tween = parent.get_node("HoleDetector/Tween")


func _ready() -> void:
	add_state("IDLE") # Refers to the state where the ball is moving due to gravity
	add_state("ENTERED_HOLE")
	add_state("DISAPPEAR")

	# To ensure the beam is idle initially
	call_deferred("set_state", states.IDLE)


func _state_logic(delta):
	match current_state:
		states.IDLE:
			pass
		states.ENTERED_HOLE:
			if not tween.is_active():
				# These settings also work but are less affective Tween.TRANS_BOUNCE, Tween.EASE_OUT
				tween.interpolate_property(parent, "global_position:x", parent.global_position.x, parent.position_to_tween_to.x, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT) 
				tween.start()
		states.DISAPPEAR:
			pass


func _get_transition(delta):
	match current_state:
		states.IDLE:
			pass
		states.ENTERED_HOLE:
			pass
		states.DISAPPEAR:
			pass


func _enter_state(new_state, old_state):
	match new_state:
		states.IDLE:
			pass
		states.ENTERED_HOLE:
			parent.set_mode(3) # This makes the body not apply forces
			parent.gravity_scale = 0 # Otherwise gravity is still in affect
		states.DISAPPEAR:
			parent.remove_ball()


func _exit_state(old_state, new_state):
	match old_state:
		states.IDLE:
			pass
		states.ENTERED_HOLE:
			pass
		states.DISAPPEAR:
			pass