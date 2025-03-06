extends Node

class_name StateManager

@export var current_state:State

var state_change_allowed:bool = true

func _ready() -> void:
	#直接全部静默， 之后手动打开
	for c:State in get_children():
		c.exit()
	
	current_state.enter()
	%Label.text = "State: " + current_state.name
	
	
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
		%Label.text = "State: " + current_state.name

	
