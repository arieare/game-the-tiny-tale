extends Node3D
## List of node
@onready var root = get_tree().get_root().get_child(0)
var skill_manager: Node
#@export var hit_box : Area3D
@export var vfx_slash : GPUParticles3D
@export var arm_slash : MeshInstance3D
@export var arm_left : MeshInstance3D
@export var arm_target_slash_start : Marker3D
@export var arm_target_slash_mid : Marker3D
@export var arm_target_slash_end : Marker3D
@export var arm_target_slash_left : Marker3D
@export var arm_target_default_right : Marker3D
@export var arm_target_default_left : Marker3D
@export var hit_box:Area3D

func _ready():
	skill_manager = get_parent()
	hit_box.monitorable = false
	hit_box.monitoring = false
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and skill_manager.current_weapon == skill_manager.WEAPON_OPTION.MELEE:
		slash()

func slash():
	hit_box.monitorable = true
	hit_box.monitoring = true
	hit_box.position.z += 0.2
	root.cam.cam_feature["cam_shake"].shake(0.075)
	print("slash")
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
	var tween_left = create_tween().set_trans(Tween.TRANS_BOUNCE)
	if vfx_slash:
		vfx_slash.emitting = true
		tween.tween_property(arm_slash,"position",arm_target_slash_start.position,0.02)
		tween.tween_property(arm_slash,"position",arm_target_slash_mid.position,0.05)
		tween.tween_property(arm_slash,"position",arm_target_slash_end.position,0.05)
		tween.tween_property(arm_slash,"position",arm_target_default_right.position,0.2)
		tween_left.tween_property(arm_left,"position",arm_target_slash_left.position,0.1)
		tween_left.tween_property(arm_left,"position",arm_target_default_left.position,0.3)
	await get_tree().create_timer(0.02).timeout
	

	hit_box.monitorable = false
	hit_box.monitoring = false
	hit_box.position.z -= 0.2
