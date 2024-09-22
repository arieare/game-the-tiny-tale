extends Node3D

var parent: RigidBody3D
var LOOK_INTERPOLATION: float = 0.75
var mouse_ray_cast

@export var look_aim: MeshInstance3D

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

func look_at_target():
	mouse_ray_cast = parent.root.common.ray_cast_from_mouse()
	if mouse_ray_cast:
		if not mouse_ray_cast.is_empty() and mouse_ray_cast:
			look_aim.global_position.x = mouse_ray_cast.position.x
			look_aim.global_position.z = mouse_ray_cast.position.z
			var look_direction = Vector3(look_aim.global_position.x, parent.position.y, look_aim.global_position.z)
			#self.look_at(look_direction)
			look_at_target_interpolated(look_direction,0.1)

func look_at_target_interpolated(direction, weight:float) -> void:
	var xform := parent.transform # your transform
	xform = xform.looking_at(direction,Vector3.UP)
	parent.transform = parent.transform.interpolate_with(xform,weight)

	#face_direction(direction)

func face_direction(direction):
	if parent.transform.origin != parent.global_position + direction:
		parent.rotation.y = lerp_angle(parent.rotation.y, atan2(-parent.linear_velocity.x, -parent.linear_velocity.z), 0.75)	
		parent.rotation.x = lerp_angle(parent.rotation.x, 0, 0.9)
		parent.rotation.z = 0
		#parent.rotation.z = 0
