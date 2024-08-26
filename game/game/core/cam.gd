extends Camera3D

@export var follow_target: Node

var tween: Tween
var cam_offset = Vector3(0, 3, 8)

func _process(delta):
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	var cam_direction = follow_target.global_transform.origin + cam_offset
	tween.tween_property(
		self,
		"global_transform:origin",
		cam_direction,
		0.1
	)
