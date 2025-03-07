extends CharacterBody3D
class_name Player

func fixed_dir(on: Vector3) -> Vector3:
	return (transform.basis * on).normalized()
