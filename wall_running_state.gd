extends State
@onready var player: CharacterBody3D = %Player

const WALL_RUNNING_SPEED = 10.0
const JUMP_VELOCITY = 5.0

@onready var ray_cast_2_left: RayCast3D = %RayCast2Left
@onready var ray_cast_2_right: RayCast3D = %RayCast2Right

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		pass
		

func _physics_process(_delta: float) -> void:
	
	if player.is_on_floor():
		switch_state.emit(%BaseMoveState)
		
	if not %RayCast2Right.is_colliding() and not %RayCast2Left.is_colliding():
		#TODO：需要RayCast在更加合理的长度
		switch_state.emit(%BaseMoveState)
	
	
	var input_dir := Input.get_vector("A", "D", "W", "S")
	#TODO: 在转向其他方向时后依然能全速运行
	var direction:Vector3 = (%CamPivot.transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	var current_speed = WALL_RUNNING_SPEED
	if direction:
		player.velocity.z = direction.z * current_speed
		player.velocity.y = 0
	else:
		player.velocity.z = move_toward(player.velocity.z, 0, current_speed)
		player.velocity.y = 0

	player.move_and_slide()
