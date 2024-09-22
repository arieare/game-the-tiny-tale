extends Node

var parent: RigidBody3D

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

func maintain_upright(delta):
	var target_upright: float = 0.0
	
	parent.rotation.x = parent.root.common.pid_controller.update_angle(parent.rotation.x, target_upright, delta)
	parent.rotation.z = parent.root.common.pid_controller.update_angle(parent.rotation.z, target_upright, delta)
	
	parent.angular_velocity.y = parent.root.common.pid_controller.update(parent.angular_velocity.y, target_upright, delta)
	parent.angular_velocity.x = parent.root.common.pid_controller.update(parent.angular_velocity.x, target_upright, delta)
	parent.angular_velocity.z = parent.root.common.pid_controller.update(parent.angular_velocity.z, target_upright, delta)
