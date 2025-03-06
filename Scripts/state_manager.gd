extends Node

class_name StateManager

@export var current_state:State

var state_change_allowed:bool = true

func _ready() -> void:
	for c:State in get_children():
		c.inactive()
	
	current_state.enter()
	%StateLabel.text = "State: " + current_state.name
	
	
	for c:State in get_children():
		c.switch_state.connect(switch_state)
		

func switch_state(to: State):
	if not state_change_allowed:
		return
	
	if to == current_state:
		return
	else:
		current_state.exit()
		current_state = to
		current_state.enter()
		#print("State Changed to ", current_state.name)
		%StateLabel.text = "State: " + current_state.name

	
