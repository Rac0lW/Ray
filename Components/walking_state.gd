extends State

@onready var player: CharacterBody3D = %Player
@onready var ray_cast_2_ground: RayCast3D = %RayCast2Ground

enum States{
	Walking,
	Running
}

var current_state := States.Walking

func enter():
	active()
	#解决WallRunning状态所中断的跑走切换状态
	current_state = States.Walking

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Run"):
		current_state = States.Running
	
	if event.is_action_released("Run"):
		current_state = States.Walking
		
	if event.is_action_pressed("Crouch"):
		switch_state.emit(%CrouchingState)
	
func _physics_process(delta: float) -> void:
	
	
	if not ray_cast_2_ground.is_colliding():
		if player.is_on_wall_only() and (%RayCast2Right.is_colliding() or %RayCast2Left.is_colliding()):
			switch_state.emit(%WallRunningState)
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * 2

	if Input.is_action_just_pressed("ui_accept"):
		player.velocity.y = Settings.JUMP_VELOCITY

	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction:Vector3 = (%CamPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var current_speed = Settings.SPEED
	
	if current_state == States.Running:
		current_speed = Settings.SPEED * 2
	else:
		current_speed = Settings.SPEED
	
	if direction:
		#TODO: 增加一些平滑度， 比如使用move_toward，使用双倍的current_speed作为加速参数
		player.velocity.x = direction.x * current_speed
		player.velocity.z = direction.z * current_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, current_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, current_speed)

	player.move_and_slide()
