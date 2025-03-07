extends Node

func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%Player.rotate_y(deg_to_rad(event.relative.x * Settings.MOUSE_SPEED * -1))
		%Camera3D.rotate_x(deg_to_rad(event.relative.y * Settings.MOUSE_SPEED * -1))
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -Settings.CONSTRAINS_DEGREE, Settings.CONSTRAINS_DEGREE)

		
		
