extends Node3D

@onready var root = get_tree().get_root().get_child(0)
@export var scene_root: Node3D
@export var shake:Node
@export var dither_filter:Node
@export var free_look:Node
@export var follow_cam:Node
@export var follow_target: Node

@export var cam_offset_y: float = 8.0
@export var cam_offset_z: float = 12.0
@export var cam_fov = 80
@export var cam_rotation = -10
var cam_offset = Vector3(0, cam_offset_y, cam_offset_z)

@onready var cam_child:Camera3D = self.get_child(0)

func _ready() -> void:	
	register_self_to_root()
	cam_child.fov = cam_fov
	cam_child.position = cam_offset
	cam_child.rotation_degrees.x = cam_rotation

func _process(delta):
	if shake: shake.trauma_shake(delta)
	if follow_cam: follow_cam.follow_cam(follow_target, cam_offset)
	if free_look: free_look.rotate_cam()

func register_self_to_root():
	root.cam = cam_child
