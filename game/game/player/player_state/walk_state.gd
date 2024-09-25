# Walk State
extends State

var WALK_SPEED:float = 15
var ACCELERATION:float = 54

@export var vfx_running_dust:GPUParticles3D

func enter_state() -> void:
	super()
	print(state_machine_parent.current_state.name)

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	var direction
			
	direction = (actor.root.cam.global_basis * actor.player_input.get_direction()).normalized()	
	walk(direction, delta, actor)
	if actor.player_input.get_direction() == Vector3.ZERO and actor.position_state_machine.current_state.name == "on_ground" and actor.linear_velocity.x == 0 and actor.linear_velocity.z == 0:
		return state_machine_parent.state_dictionary["idle"]
	if actor.player_input.want_to_jump() and actor.position_state_machine.current_state.name == "on_ground":
		return state_machine_parent.state_dictionary["jump"]		
	return null

func walk(direction, delta, actor):
	var horizontal_velocity = actor.linear_velocity * Vector3(1, 0, 1)
	var target_velocity: Vector3 = (direction * WALK_SPEED)
	var acceleration_goal = target_velocity - horizontal_velocity	
	var target_acceleration = acceleration_goal / delta
	
	# clamp ForceToGoalAcceleration to our maximum allowed acceleration.
	if target_acceleration.length() > ACCELERATION: 
		target_acceleration = (target_acceleration.normalized() * ACCELERATION)
	
	var leaning_point: Vector3 = Vector3(0, -0.75, 0)
	actor.apply_force(target_acceleration * actor.mass, leaning_point)
	
	if vfx_running_dust:
		if direction:
			vfx_running_dust.emitting = true
		else:
			vfx_running_dust.emitting = false
