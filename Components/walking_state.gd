extends State

@onready var player: Player = %Player
@onready var ray_cast_2_ground: RayCast3D = %RayCast2Ground

enum States{
	Walking,
	Running
}

var current_state := States.Walking
var current_speed:float = 5.0
var last_walk_or_run_state:States = States.Walking
var current_jump_count:int

func _ready() -> void:
	current_jump_count = Settings.MAX_JUMP_COUNT

func enter():
	active()
	current_jump_count = Settings.MAX_JUMP_COUNT
	#解决WallRunning状态所中断的跑走切换状态
	current_state = last_walk_or_run_state
	
	if Settings.LAST_STATE == %CrouchingState:
		current_speed = States.Walking

func exit():
	inactive()
	last_walk_or_run_state = current_state

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Run"):
		current_state = States.Running
	
	if event.is_action_released("Run"):
		current_state = States.Walking
		
	if event.is_action_pressed("Crouch"):
		match current_state:
			States.Walking:
				if player.is_on_floor():
					switch_state.emit(%CrouchingState)
			States.Running:
				switch_state.emit(%SlidingState)
	
	if event.is_action_pressed("ui_accept"):
		if current_jump_count > 1:
			player.velocity.y += Settings.JUMP_VELOCITY
			current_jump_count -= 1
			
	if event.is_action_pressed("ShortDash"):
		switch_state.emit(%ShortDashState)
	
	if event.is_action_pressed("Grab") and %GrabIndicator.is_colliding():
		switch_state.emit(%SwingState)
	
func _physics_process(delta: float) -> void:
	
	if not ray_cast_2_ground.is_colliding():
		if player.is_on_wall_only() and (%RayCast2Right.is_colliding() or %RayCast2Left.is_colliding()):
			switch_state.emit(%WallRunningState)
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * 2
		
	if player.is_on_floor():
		current_jump_count = Settings.MAX_JUMP_COUNT
		player.current_dash_count = 2

	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction:Vector3 = player.fixed_dir(Vector3(input_dir.x, 0, input_dir.y))
	
	if current_state == States.Running:
		current_speed = Settings.RUNNING_SPEED
	else:
		current_speed = Settings.SPEED
	
	player.move(direction, current_speed)

	player.move_and_slide()
