extends Node

var parent: RigidBody3D

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

func jump(delta)->void:
	if Input.is_action_just_pressed("jump") and parent.move_levitate.is_on_floor:
		parent.apply_central_force(Vector3.DOWN * 800 * parent.mass)	
		await get_tree().create_timer(0.05).timeout
		parent.apply_central_force(Vector3.UP * 1000 * parent.mass)	

func fall(delta):
	if !Input.is_action_just_pressed("jump") or parent.linear_velocity.y <= 0.0:
		parent.apply_central_force(Vector3.DOWN * 50 * parent.mass)	
