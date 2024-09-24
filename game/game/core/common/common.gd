extends Node

@onready var root = get_tree().get_root().get_child(0)

## Modules
@onready var pid_controller:CommonPIDController = CommonPIDController.new()
@onready var mouse_ray_cast:CommonMouseRayCast = CommonMouseRayCast.new()
@export var day_time: Node
@export var input_setting: Node
@export var interaction_manager: Node3D

func _ready() -> void:
	if mouse_ray_cast: mouse_ray_cast.init_viewport(self)

func hit_stop(time_scale, duration):
	print("hit_stop")
	Engine.time_scale = time_scale
	await get_tree().create_timer(time_scale * duration).timeout
	Engine.time_scale = 1
