extends Node3D
## List of node
@onready var root = get_tree().get_root().get_child(0)
var skill_manager: Node
#@export var hit_box : Area3D
@export var vfx_slash : GPUParticles3D

@export var hit_box_node: NodePath
@onready var hit_box:Area3D = get_node(hit_box_node)

func _ready():
	skill_manager = get_parent()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("attack") and skill_manager.current_weapon == skill_manager.WEAPON_OPTION.MELEE:
		slash()

func slash():
	root.cam.shake.add_trauma(0.06)
	print("slash")
	if vfx_slash:
		vfx_slash.emitting = true
	var hit_entities = hit_box.get_overlapping_bodies()
	for entity in hit_entities:
		if entity.is_in_group("enemy"):
			print(entity)
