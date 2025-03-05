extends Node

class_name StateManager

@export var current_state:State

func _ready() -> void:
	current_state.enter()
	
	for c:State in get_children():
		c.switch_state.connect(switch_state)
		

func switch_state(to: State):
	if to == current_state:
		return
	else:
		current_state.exit()
		current_state = to
		current_state.enter()
		#print("State Changed to ", current_state.name)

	
