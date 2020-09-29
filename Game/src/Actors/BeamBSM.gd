extends StateMachine

var right_direction = 0
var left_direction = 0

func _ready() -> void:
	add_state("WAITING") # Refers to the state where the player can move the beam using inputs
	add_state("RESETTING")
	add_state("PAUSED")

	# To ensure the beam is idle initially
	call_deferred("set_state", states.WAITING)


func _state_logic(delta):
	match current_state:
		states.WAITING:
			var movement = parent.get_user_movement()
			right_direction = movement[0]
			left_direction = movement[1]
		states.RESETTING:
			var movement = parent.get_auto_movement()
			right_direction = movement[0]
			left_direction = movement[1]
		states.PAUSED:
			right_direction = 0
			left_direction = 0


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
			PlayerData.emit_signal("stop_game_timer")
		states.PAUSED:
			PlayerData.emit_signal("stop_game_timer")


func _exit_state(old_state, new_state):
	match old_state:
		states.WAITING:
			pass
		states.RESETTING:
			if PlayerData.number_of_balls > 0:
				PlayerData.emit_signal("add_ball")
				PlayerData.emit_signal("start_game_timer")
		states.PAUSED:
			PlayerData.emit_signal("start_game_timer")