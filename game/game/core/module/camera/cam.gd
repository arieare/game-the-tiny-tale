extends Camera3D

## List of node
@onready var root = get_tree().get_root().get_child(0)
@export var follow_target: Node

@export var shake_node: NodePath
@onready var shake:Node = get_node(shake_node)

@export var pixel_outline_node: NodePath
@onready var pixel_outline:Node = get_node(pixel_outline_node)

var offset_y: float = 10.0
var offset_z: float = 13.0
var tween: Tween
var cam_offset = Vector3(0, offset_y, offset_z)
var cam_rotation = -20

func _ready() -> void:
	shake.assert_parent(self)
	pixel_outline.assert_parent(self)
	register_self_to_root()
	self.global_position = cam_offset
	self.rotation.x = deg_to_rad(cam_rotation)

func _process(delta):
	shake.trauma_shake(delta)
	follow_cam(follow_target)

func register_self_to_root():
	root.cam = self

func follow_cam(target):
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	var cam_direction = Vector3(target.global_transform.origin.x + cam_offset.x,follow_target.global_transform.origin.y + cam_offset.y, follow_target.global_transform.origin.z + cam_offset.z)
	tween.tween_property(
		self,
		"global_transform:origin",
		cam_direction,
		0.075
	)	
