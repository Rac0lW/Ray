extends Node

const MOUSE_SPEED := 1.0
const CONSTRAINS_DEGREE := 89.9
const WALL_RUNNING_SPEED = 12.0
const JUMP_VELOCITY = 9.0
const SPEED = 5.0
const CROUCHING_SPEED = 3.0
const SLIDING_SPEED = 15.0
const LOSING_SPEED = 20.0
const RUNNING_SPEED = 10.0

var LAST_STATE: State

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ESC"):
		get_tree().quit()
