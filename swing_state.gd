extends State

@export var stiffness:float = 100.0
@export var rest_length:float = 8.0
@export var damping:float = 1.0

@export var player:Player
@export var indicator:RayCast3D
@export var onGrabingSpeed:float = 5.0

var force:Vector3 = Vector3.ZERO
var target:Vector3 = Vector3.ZERO


func enter():
	active()
	target = indicator.get_collision_point()

func exit():
	inactive()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("Grab"):
		switch_state.emit(%BaseMoveState)

func _process(delta: float) -> void:
	var target_dir = player.global_position.direction_to(target)
	var target_distance = player.global_position.distance_to(target)
	var displacement = target_distance - rest_length
	
	if displacement > 0:
		var spring_force = displacement * stiffness * target_dir
		
		var vel_dot = player.velocity.dot(target_dir)
		var damping = -damping * vel_dot * target_dir
		
		force = damping + spring_force
	
	player.velocity += force * delta
			
			
		
func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta * 2
	
	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction:Vector3 = player.fixed_dir(Vector3(input_dir.x, 0, input_dir.y))
	
	player.move_delta(direction, onGrabingSpeed, delta)
	player.move_and_slide()
	
	
