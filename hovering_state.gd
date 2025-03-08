extends State
@onready var ray_cast_2_right: RayCast3D = %RayCast2Right
@onready var ray_cast_2_left: RayCast3D = %RayCast2Left
@onready var player: Player = %Player

var direction:Vector3

@export var POWER_SCALE:float = 1.0

func enter():
	active()
	player.velocity.y = Settings.JUMP_VELOCITY
	
	if ray_cast_2_left.is_colliding():
		direction = player.fixed_dir(Vector3(1, 0, -1))
		player.move(direction, Settings.JUMP_VELOCITY * POWER_SCALE)
		
	if ray_cast_2_right.is_colliding():
		direction = player.fixed_dir(Vector3(-1, 0, -1))
		player.move(direction, Settings.JUMP_VELOCITY * POWER_SCALE)


func _unhandled_input(event: InputEvent) -> void:
	#跳跃打断进入基本状态
	if event.is_action_pressed("ui_accept"):
		player.velocity.y = Settings.JUMP_VELOCITY
		switch_state.emit(%BaseMoveState)

func _physics_process(delta: float) -> void:
	#降落的时候进入基本状态, 这个方法巧妙地解决了流畅性的问题
	if player.velocity.y < 0 and abs(player.velocity.x) < 0:
		switch_state.emit(%BaseMoveState)
	
	player.velocity += player.get_gravity() * delta * 2
		
	player.move_and_slide()
	
	
