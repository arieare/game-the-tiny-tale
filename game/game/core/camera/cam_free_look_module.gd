extends Cam
class_name CamFreeLook

var free_look_speed_degree: float = 1.0

func rotate_cam():
	if Input.is_action_pressed("cam_rotate_left"):
		parent_cam.rotation_degrees.y += free_look_speed_degree 
	elif Input.is_action_pressed("cam_rotate_right"):
		parent_cam.rotation_degrees.y -= free_look_speed_degree
