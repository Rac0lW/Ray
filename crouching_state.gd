extends State


@onready var player: Player = %Player
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
	var direction:Vector3 = player.fixed_dir(Vector3(input_dir.x, 0, input_dir.y))
	
	player.move(direction, Settings.CROUCHING_SPEED)

	player.move_and_slide()
