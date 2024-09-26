extends Node3D
@onready var root = get_tree().get_root().get_child(0)
var mouse_ray_cast
@export var look_aim_cursor: MeshInstance3D

func aim_follow_cursor(cursor:Variant):
	mouse_ray_cast = root.common["mouse_ray_cast"].cast(root.cam.cam_child)
	if mouse_ray_cast:
		if not mouse_ray_cast.is_empty() and mouse_ray_cast:
			cursor.global_position.x = mouse_ray_cast.position.x
			cursor.global_position.z = mouse_ray_cast.position.z	

func _process(delta: float) -> void:
	aim_follow_cursor(look_aim_cursor)
