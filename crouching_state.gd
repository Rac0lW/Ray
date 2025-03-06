extends State


@onready var player: CharacterBody3D = %Player
@onready var animation_player: AnimationPlayer = %AnimationPlayer
const SPEED = 3.0

func enter():
	active()
	animation_player.play("Crouch")
	
func exit():
	inactive()
	animation_player.play_backwards("Crouch")
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("Crouch"):
		switch_state.emit(%BaseMoveState)

func _physics_process(delta: float) -> void:
	
	if player.is_on_wall_only() and (%RayCast2Right.is_colliding() or %RayCast2Left.is_colliding()):
		switch_state.emit(%WallRunningState)
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * 2

	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction:Vector3 = (%CamPivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var current_speed = SPEED
	
	if direction:
		#TODO: 增加一些平滑度， 比如使用move_toward，使用双倍的current_speed作为加速参数
		player.velocity.x = direction.x * current_speed
		player.velocity.z = direction.z * current_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, current_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, current_speed)

	player.move_and_slide()
