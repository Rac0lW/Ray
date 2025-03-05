extends Node
class_name State

signal switch_state

func _ready() -> void:
	exit()
func _init() -> void:
	pass
func enter():
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)
	
func exit():
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
