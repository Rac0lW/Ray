extends State
@onready var player: CharacterBody3D = %Player
@onready var ray_cast_2_left: RayCast3D = %RayCast2Left
@onready var ray_cast_2_right: RayCast3D = %RayCast2Right

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#pass
		#
	#if event.is_action_pressed("Crouch"):
		#switch_state.emit(%BaseMoveState)
		

func _physics_process(_delta: float) -> void:
	
	if player.is_on_floor():
		switch_state.emit(%BaseMoveState)
		
	if not %RayCast2Right.is_colliding() and not %RayCast2Left.is_colliding():
		#TODO：需要RayCast在更加合理的长度
		switch_state.emit(%BaseMoveState)
	
	
	var input_dir := Input.get_vector("A", "D", "W", "S")
	#TODO: 在转向其他方向时后依然能全速运行
	var direction:Vector3 = (%Player.transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	if direction:
		#TODO: 增加一些平滑度， 比如使用move_toward，使用双倍的current_speed作为加速参数
		player.velocity.x = direction.x * Settings.WALL_RUNNING_SPEED
		player.velocity.z = direction.z * Settings.WALL_RUNNING_SPEED
		player.velocity.y = 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Settings.WALL_RUNNING_SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, Settings.WALL_RUNNING_SPEED)
		player.velocity.y = 0


	player.move_and_slide()
