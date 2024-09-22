extends Node

@onready var root = get_tree().get_root().get_child(0)

var mouse: Vector2
var ray_query = PhysicsRayQueryParameters3D.new()
var ray_length = 100.0

@export var pid_controller_node:NodePath
@onready var pid_controller = get_node(pid_controller_node)

@export var day_time_node:NodePath
@onready var day_time = get_node(day_time_node)

@export var input_setting_node:NodePath
@onready var input_setting = get_node(input_setting_node)

@export var interaction_manager_node:NodePath
@onready var interaction_manager = get_node(interaction_manager_node)

func ray_cast_from_mouse():
	mouse = get_tree().get_root().get_viewport().get_mouse_position()
	ray_query.from = root.cam.project_ray_origin(mouse)
	ray_query.to = ray_query.from + root.cam.project_ray_normal(mouse) * ray_length
	ray_query.collide_with_areas = false
	return root.cam.get_world_3d().direct_space_state.intersect_ray(ray_query)

#func GetChildNodeWithType(parentNode:Node, nodeType) -> Array:
	#var type
	#var nodes:Array
	#for node in parentNode.get_children():
		#type = node.get_class()
		#if type == nodeType:
			#nodes.append(node) 
	#return nodes

func hit_stop(time_scale, duration):
	print("hit_stop")
	Engine.time_scale = time_scale
	await get_tree().create_timer(time_scale * duration).timeout
	Engine.time_scale = 1
