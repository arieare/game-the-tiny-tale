extends Node

var parent: RigidBody3D

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

@export var pid_controller_node: NodePath
@onready var pid_controller = get_node(pid_controller_node)

func maintain_upright(delta):
	var target_upright: float = 0.0
	
	parent.rotation.x = pid_controller.update_angle(parent.rotation.x, target_upright, delta)
	parent.rotation.z = pid_controller.update_angle(parent.rotation.z, target_upright, delta)
	
	parent.angular_velocity.y = pid_controller.update(parent.angular_velocity.y, target_upright, delta)
	parent.angular_velocity.x = pid_controller.update(parent.angular_velocity.x, target_upright, delta)
	parent.angular_velocity.z = pid_controller.update(parent.angular_velocity.z, target_upright, delta)
