extends Node3D
## List of node
@onready var root = get_tree().get_root().get_child(0)
var skill_manager: Node
#@export var hit_box : Area3D
@export var vfx_slash : GPUParticles3D
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
	if vfx_slash:
		vfx_slash.emitting = true
	await get_tree().create_timer(0.02).timeout
	hit_box.monitorable = false
	hit_box.monitoring = false
	hit_box.position.z -= 0.2
