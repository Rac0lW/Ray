extends State
@onready var player: Player = %Player
@onready var ray_cast_2_left: RayCast3D = %RayCast2Left
@onready var ray_cast_2_right: RayCast3D = %RayCast2Right
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func enter():
	active()
	if ray_cast_2_left.is_colliding():
		animation_player.play("OnLeftWallRunning")
	else:
		animation_player.play("OnRightWallRunning")
		
func exit():
	inactive()
	animation_player.play("RESET")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		switch_state.emit(%HoveringState)
		

func _physics_process(delta: float) -> void:
	if player.is_on_floor():
		switch_state.emit(%BaseMoveState)
		
	if not %RayCast2Right.is_colliding() and not %RayCast2Left.is_colliding():
		switch_state.emit(%BaseMoveState)

	player.velocity.y = 0
	var input_dir := Input.get_vector("A", "D", "W", "S")
	#TODO: 在转向其他方向时后依然能全速运行
	var direction:Vector3 = player.fixed_dir(Vector3(input_dir.x, 0, input_dir.y))
	player.move(direction, Settings.WALL_RUNNING_SPEED)
	player.move_and_slide()
