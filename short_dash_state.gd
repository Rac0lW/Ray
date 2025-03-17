extends State
@onready var player: Player = %Player

func enter():
	active()
	
	player.move(player.fixed_dir(Vector3(0, 0, -1)), Settings.JUMP_VELOCITY * 2)
	
	await get_tree().create_timer(0.2).timeout
	
	switch_state.emit(%BaseMoveState)
	
	
	
func _physics_process(delta: float) -> void:
	player.move_and_slide()
	
