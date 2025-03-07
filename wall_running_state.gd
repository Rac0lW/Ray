extends State
@onready var player: Player = %Player
@onready var ray_cast_2_left: RayCast3D = %RayCast2Left
@onready var ray_cast_2_right: RayCast3D = %RayCast2Right

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		switch_state.emit(%WallJumpingState)
		if ray_cast_2_left.is_colliding():
			player.velocity.x = player.fixed_dir(Vector3(1, 0, 0)).x * Settings.JUMP_VELOCITY
			player.velocity.z = player.fixed_dir(Vector3(1, 0, 0)).z * Settings.JUMP_VELOCITY
		
		if ray_cast_2_right.is_colliding():
			player.velocity.x = player.fixed_dir(Vector3(-1, 0, 0)).x * Settings.JUMP_VELOCITY
			player.velocity.z = player.fixed_dir(Vector3(-1, 0, 0)).z * Settings.JUMP_VELOCITY
			
		

func _physics_process(_delta: float) -> void:
	
	if player.is_on_floor():
		switch_state.emit(%BaseMoveState)
		
	if not %RayCast2Right.is_colliding() and not %RayCast2Left.is_colliding():
		switch_state.emit(%BaseMoveState)
	
	
	var input_dir := Input.get_vector("A", "D", "W", "S")
	#TODO: 在转向其他方向时后依然能全速运行
	var direction:Vector3 = player.fixed_dir(Vector3(input_dir.x, 0, input_dir.y))
	if direction:
		player.velocity.z = direction.z * Settings.WALL_RUNNING_SPEED
		#我就不知到为什么没了这两个整个WallRunning就完全不能动了
		player.velocity.x = direction.x * Settings.WALL_RUNNING_SPEED
		player.velocity.y = 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Settings.LOSING_SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, Settings.LOSING_SPEED)
		player.velocity.y = 0


	player.move_and_slide()
