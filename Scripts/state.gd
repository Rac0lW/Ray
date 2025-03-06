extends Node
class_name State

signal switch_state


#将Ready中得分exit实现到init中
func _init() -> void:
	pass

func enter():
	active()
	
func exit():
	inactive()

func inactive():
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)

func active():
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)
