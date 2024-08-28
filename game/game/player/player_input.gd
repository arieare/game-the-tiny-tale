extends Node

@export var parent: RigidBody3D

var is_jumping_pressed: bool = false

func get_direction():
	var input: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_down",
		"move_up"
		)
	var vector_direction: Vector3 = Vector3(input.x, 0, -input.y)
	return vector_direction
