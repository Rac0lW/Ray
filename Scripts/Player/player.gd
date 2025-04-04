extends CharacterBody3D
class_name Player

var current_dash_count:int

func _ready() -> void:
	current_dash_count = Settings.MAX_DASH_COUNT

func fixed_dir(on: Vector3) -> Vector3:
	return (transform.basis * on).normalized()

func move(dir: Vector3, speed: float) -> void:
	if dir:
		velocity.x = dir.x * speed
		velocity.z = dir.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, Settings.LOSING_SPEED)
		velocity.z = move_toward(velocity.z, 0, Settings.LOSING_SPEED)


func move_delta(dir: Vector3, speed: float, delta) -> void:
	if dir:
		if velocity.x < 20.0:
			velocity.x += dir.x * speed * delta
		if velocity.z < 20.0:
			velocity.z += dir.z * speed * delta
	else:
		if velocity.x > 0:
			velocity.x -= Settings.LOSING_SPEED * delta
		if velocity.z > 0:
			velocity.z -= Settings.LOSING_SPEED * delta
