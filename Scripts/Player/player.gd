extends CharacterBody3D
class_name Player

func fixed_dir(on: Vector3) -> Vector3:
	return (transform.basis * on).normalized()


func move(dir: Vector3, speed: float) -> void:
	if dir:
		velocity.x = dir.x * speed
		velocity.z = dir.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, Settings.LOSING_SPEED)
		velocity.z = move_toward(velocity.z, 0, Settings.LOSING_SPEED)

#TODO: Add the slide state(slope and ground)

#TODO: Make a Gun
