extends Camera3D

@export var follow_target: Node

var tween: Tween
var cam_offset_z = 8.5
var cam_offset = Vector3(0, 3.5, cam_offset_z)

func _ready() -> void:
	self.global_position = cam_offset

func _process(delta):
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	var cam_direction = Vector3(follow_target.global_transform.origin.x + cam_offset.x,cam_offset.y, follow_target.global_transform.origin.z + cam_offset.z)
	tween.tween_property(
		self,
		"global_transform:origin",
		cam_direction,
		0.075
	)
