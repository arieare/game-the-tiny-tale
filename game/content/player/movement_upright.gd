extends Node

var parent: RigidBody3D

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

func maintain_upright(delta):
	var target_rotation: float = 0.0
	parent.rotation.x = lerp_angle(parent.rotation.x, target_rotation, 0.75)
	parent.rotation.z = lerp_angle(parent.rotation.z, target_rotation, 0.75)
