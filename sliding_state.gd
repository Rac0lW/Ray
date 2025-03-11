extends State
@onready var player: Player = %Player
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var state_manager: StateManager = $".."

func enter():
	active()
	animation_player.play("Slide")
	
	#进入滑行加速
	player.velocity.x *= 1.2
	player.velocity.z *= 1.2
	#自动停止
	await get_tree().create_timer(1.0).timeout
	
	if state_manager.current_state == self:
		switch_state.emit(%BaseMoveState)
	
func exit():
	inactive()
	animation_player.play_backwards("Slide")

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_accept"):
		player.velocity.y = Settings.JUMP_VELOCITY
		
		player.velocity.x *= 1.2
		player.velocity.z *= 1.2
		
		
		await get_tree().create_timer(0.5).timeout
		
		if state_manager.current_state == self:
			switch_state.emit(%BaseMoveState)

func _physics_process(delta: float) -> void:
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * 2
		
	var normal = Vector3.ZERO
	
	#下面的函数只会在斜坡触发
	if player.is_on_floor():
		normal = player.get_floor_normal()
		
	normal.y = -normal.y
	
	player.velocity += normal * Settings.SLIDING_SPEED * delta
	
	player.move_and_slide()
