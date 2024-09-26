# Fall State
extends State

@export var FALL_SPEED: float = 2000.0
@export var arm_right : MeshInstance3D
@export var arm_left : MeshInstance3D
@export var arm_target_fall_right : Marker3D
@export var arm_target_fall_left : Marker3D
@export var arm_target_fall_mid_right : Marker3D
@export var arm_target_fall_mid_left : Marker3D
@export var arm_target_default_right : Marker3D
@export var arm_target_default_left : Marker3D

var is_animating: bool = false



func enter_state() -> void:
	super()
	print(state_machine_parent.current_state.name)
	

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	var tween_arm_right = create_tween().set_trans(Tween.TRANS_BOUNCE)
	var tween_arm_left = create_tween().set_trans(Tween.TRANS_BOUNCE)
	actor.apply_central_force(Vector3.DOWN * FALL_SPEED * actor.mass * delta)
	
	if !is_animating:
		tween_arm_right.tween_property(arm_right,"position",arm_target_fall_mid_right.position,0.02)
		tween_arm_right.tween_property(arm_right,"position",arm_target_fall_right.position,0.02)
		tween_arm_left.tween_property(arm_left,"position",arm_target_fall_mid_left.position,0.02)
		tween_arm_left.tween_property(arm_left,"position",arm_target_fall_left.position,0.02)
		is_animating = true
	
	if actor.player_input.get_direction() != Vector3.ZERO and actor.position_state_machine.current_state.name == "on_ground":
		return state_machine_parent.state_dictionary["walk"]		
	if actor.position_state_machine.current_state.name == "on_ground":
		return state_machine_parent.state_dictionary["idle"]		
	return null

func exit_state() -> void:
	
	is_animating = false
	actor.root.cam.cam_feature["cam_shake"].shake(0.075)
	
	var tween_arm_right = create_tween().set_trans(Tween.TRANS_BOUNCE)
	var tween_arm_left = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween_arm_right.tween_property(arm_right,"position",arm_target_default_right.position,0.05)
	tween_arm_left.tween_property(arm_left,"position",arm_target_default_left.position,0.05)
	
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(actor.skin,"scale:y",0.75,0.05)
	tween.tween_property(actor.skin,"scale:z",1.3,0.01)
	tween.tween_property(actor.skin,"scale:x",1.3,0.01)
	await tween.finished
	var tween_recover = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween_recover.tween_property(actor.skin,"scale:y",1.0,0.05)
	tween_recover.tween_property(actor.skin,"scale:z",1,0.05)
	tween_recover.tween_property(actor.skin,"scale:x",1,0.05)
	super()
