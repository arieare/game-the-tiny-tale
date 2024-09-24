extends Node

@export var parent: RigidBody3D

var is_jumping_pressed: bool = false

func get_direction():
	var input: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
		)
	var vector_direction: Vector3 = Vector3(input.x, 0, input.y)
	return vector_direction

func get_jump_button() -> bool:
	return Input.is_action_just_pressed("jump")

func get_attack_button() -> bool:
	return Input.is_action_just_pressed("attack")
