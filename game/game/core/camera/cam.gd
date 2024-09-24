@icon("res://content/icon/node_icon_camera.svg")
extends Node3D

@onready var root = get_tree().get_root().get_child(0)
@export var scene_root: Node3D
@onready var cam_child:Camera3D = self.get_child(0)

## Modules
@onready var cam_shake:Cam = CamShake.new()
@onready var cam_follow:Cam = CamFollowTarget.new()
@onready var cam_filter:Cam = CamFilterDither.new()
@onready var cam_free_look:Cam = CamFreeLook.new()
@export var follow_target: Node

func init_modules():
	cam_shake.assert_cam_parent(self)
	cam_follow.assert_cam_parent(self)
	cam_free_look.assert_cam_parent(self)
	cam_filter.assert_cam_parent(self)

## Camera Setting
@export var cam_offset_y: float = 8.0
@export var cam_offset_z: float = 12.0
@export var cam_fov = 80
@export var cam_rotation = -10
var cam_offset = Vector3(0, cam_offset_y, cam_offset_z)

func cam_setting():
	cam_child.fov = cam_fov
	cam_child.position = cam_offset
	cam_child.rotation_degrees.x = cam_rotation	

func register_self_to_root():
	root.cam = self

func _ready() -> void:	
	register_self_to_root()
	cam_setting()
	init_modules()
	if cam_filter: 
		cam_filter.init_pixelart_outline(cam_filter.pixel_outline_filter)
		cam_filter.init_pixelart_style(scene_root, cam_filter.dither_filter)	

func _process(delta):
	if cam_shake: cam_shake.trauma_shake(delta)
	if cam_follow: cam_follow.follow_cam(follow_target, cam_offset)
	if cam_free_look: cam_free_look.rotate_cam()
