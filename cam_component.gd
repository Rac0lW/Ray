extends Node


const MOUSE_SPEED := 1.0
const CONSTRAINS_DEGREE := 89.9

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%CamPivot.rotate_y(deg_to_rad(event.relative.x * MOUSE_SPEED * -1))
		
		%Camera3D.rotate_x(deg_to_rad(event.relative.y * MOUSE_SPEED * -1))
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -CONSTRAINS_DEGREE, CONSTRAINS_DEGREE)

		
		
