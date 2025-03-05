extends State
@onready var player: CharacterBody3D = %Player

const WALL_RUNNING_SPEED = 10.0

	

func _physics_process(delta: float) -> void:
	
	if player.is_on_floor():
		switch_state.emit(%BaseMoveState)
		
	if not %RayCast2Right.is_colliding() and not %RayCast2Left.is_colliding():
		switch_state.emit(%BaseMoveState)
	
	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction:Vector3 = (%CamPivot.transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	var current_speed = WALL_RUNNING_SPEED
	if direction:
		player.velocity.x = direction.x * current_speed
		player.velocity.y = 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, current_speed)
		player.velocity.y = 0

	player.move_and_slide()
