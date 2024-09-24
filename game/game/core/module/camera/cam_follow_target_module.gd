extends Node
'''
to be put as a child of Camera3D only
'''
@onready var parent: Node3D = get_parent().get_parent()

var tween: Tween
var follow_dampen: float = 0.1

func follow_cam(target, offset:Vector3):	
	var cam_pos = Vector3(target.global_transform.origin)
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(parent, "global_transform:origin", cam_pos, follow_dampen)	
