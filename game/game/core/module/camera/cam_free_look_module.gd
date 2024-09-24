extends Node
'''to be put as a child of Camera3D only'''

@onready var parent: Node3D = get_parent().get_parent()

func rotate_cam():
	if Input.is_action_pressed("cam_rotate_left"):
		parent.rotation_degrees.y += 1 
	elif Input.is_action_pressed("cam_rotate_right"):
		parent.rotation_degrees.y -= 1
