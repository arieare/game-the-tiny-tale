extends Node3D

## List of node
@onready var root = get_tree().get_root().get_child(0)
@export var scene_root: Node3D
@export var shake:Node
@export var pixel_outline:Node
@export var follow_cam:Node
@export var follow_target: Node

var offset_y: float = 10.0
var offset_z: float = 12.0

var cam_offset = Vector3(0, offset_y, offset_z)
var cam_rotation = -10

@onready var cam_child:Camera3D = self.get_child(0)

func _ready() -> void:
	shake.assert_parent(cam_child)
	pixel_outline.assert_parent(cam_child)
	follow_cam.assert_parent(cam_child)
	register_self_to_root()
	cam_child.fov = 80
	cam_child.position = cam_offset
	cam_child.rotation.x = deg_to_rad(cam_rotation)

func _process(delta):
	shake.trauma_shake(delta)
	follow_cam.follow_cam(follow_target, cam_offset)
	rotate_cam()


func register_self_to_root():
	root.cam = self

func rotate_cam():
	if Input.is_action_pressed("cam_rotate_left"):
		self.rotation_degrees.y += 1.0 
	elif Input.is_action_pressed("cam_rotate_right"):
		self.rotation_degrees.y -= 1.0 
