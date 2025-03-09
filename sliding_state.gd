extends State
@onready var player: Player = %Player
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func enter():
	active()
	animation_player.play("Slide")
	
func exit():
	inactive()
	animation_player.play_backwards("Slide")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("Crouch") or event.is_action_released("Run"):
		switch_state.emit(%BaseMoveState)
	
	if event.is_action_pressed("ui_accept"):
		switch_state.emit(%BaseMoveState)
		player.velocity.y = Settings.JUMP_VELOCITY * 2

func _physics_process(delta: float) -> void:
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * 2
		
	var normal = Vector3.ZERO
	
	if player.is_on_floor():
		normal = player.get_floor_normal()
		
	normal.y = -normal.y
	
	player.velocity += normal * Settings.SLIDING_SPEED * delta
	
	player.move_and_slide()
