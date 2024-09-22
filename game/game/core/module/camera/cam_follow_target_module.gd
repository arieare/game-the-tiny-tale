extends Node

var tween: Tween
var follow_dampen: float = 0.1

var parent: Camera3D

func assert_parent(parent_node: Camera3D):
	parent = parent_node

func follow_cam(target, offset:Vector3):
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	#var cam_direction = Vector3(target.global_transform.origin + offset)
	var cam_pos = Vector3(target.global_transform.origin)
	tween.tween_property(parent.get_parent(), "global_transform:origin", cam_pos, follow_dampen)	
