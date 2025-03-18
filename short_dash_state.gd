extends State
@onready var player: Player = %Player

func enter():
	active()
	
	#增加自动回复功能
	player.current_dash_count -= 1
	
	if player.current_dash_count < 0:
		switch_state.emit(%BaseMoveState)
	
	player.move(player.fixed_dir(Vector3(0, 0, -1)), Settings.JUMP_VELOCITY * 2)
	
	await get_tree().create_timer(0.2).timeout
	
	switch_state.emit(%BaseMoveState)
	
	
	
func _physics_process(delta: float) -> void:
	player.move_and_slide()
	
