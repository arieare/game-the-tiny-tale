# Idle State
extends State

func enter_state() -> void:
	super()	
	print(state_machine_parent.current_state.name)
	actor.linear_velocity.x = 0
	actor.linear_velocity.z = 0
	

func process_input(event: InputEvent) -> State:
	if actor.player_input.want_to_jump() and actor.position_state_machine.current_state.name == "on_ground":
		return state_machine_parent.state_dictionary["jump"]
	if actor.player_input.get_direction() != Vector3.ZERO and actor.position_state_machine.current_state.name == "on_ground":
		return state_machine_parent.state_dictionary["walk"]		
	return null

func process_physics(delta: float) -> State:
	actor.body.rotation_degrees.x = lerpf(actor.body.rotation_degrees.x,0,0.1)
	return null
