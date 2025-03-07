extends State
@onready var player: Player = %Player



func _physics_process(delta: float) -> void:
	
	if player.is_on_floor():
		switch_state.emit(%BaseMoveState)
		
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * 2

	#var input_dir := Input.get_vector("A", "D", "W", "S")
	#var direction:Vector3 = player.fixed_dir(Vector3(input_dir.x, 0, input_dir.y))
	#
	#if direction:
		#player.velocity.z = direction.z * Settings.CROUCHING_SPEED
		#player.velocity.x = direction.x * Settings.CROUCHING_SPEED
	#else:
		#player.velocity.z = move_toward(player.velocity.z, 0, Settings.LOSING_SPEED)
		#player.velocity.x = move_toward(player.velocity.x, 0, Settings.LOSING_SPEED)

	player.move_and_slide()
