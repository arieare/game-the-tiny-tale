# Fall State
extends State

@export var FALL_SPEED: float = 2000.0

func enter_state() -> void:
	super()
	print(state_machine_parent.current_state.name)
	

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	actor.apply_central_force(Vector3.DOWN * FALL_SPEED * actor.mass * delta)
	if actor.position_state_machine.current_state.name == "on_ground":
		return state_machine_parent.state_dictionary["idle"]
	return null

func exit_state() -> void:
	super()
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(actor.body,"scale:y",0.75,0.05)
	tween.tween_property(actor.body,"scale:z",1.3,0.01)
	tween.tween_property(actor.body,"scale:x",1.3,0.01)
	await tween.finished
	var tween_recover = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween_recover.tween_property(actor.body,"scale:y",1.0,0.05)
	tween_recover.tween_property(actor.body,"scale:z",1,0.05)
	tween_recover.tween_property(actor.body,"scale:x",1,0.05)
