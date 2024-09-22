extends Node3D

var parent: RigidBody3D
var WALK_SPEED:float = 17
var ACCELERATION:float = 54

@export var vfx_running_dust_node: NodePath
@onready var vfx_running_dust:GPUParticles3D = get_node(vfx_running_dust_node)

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

func walk(direction, delta):
	
	var horizontal_velocity = parent.linear_velocity * Vector3(1, 0, 1)
	var target_velocity: Vector3 = (direction * WALK_SPEED)
	var acceleration_goal = target_velocity - horizontal_velocity	
	var target_acceleration = acceleration_goal / delta
	
	# clamp ForceToGoalAcceleration to our maximum allowed acceleration.
	if target_acceleration.length() > ACCELERATION: 
		target_acceleration = (target_acceleration.normalized() * ACCELERATION)
	
	var leaning_point: Vector3 = Vector3(0, -0.75, 0)
	parent.apply_force(target_acceleration * parent.mass, leaning_point)
	
	if direction:
		vfx_running_dust.emitting = true
	else:
		vfx_running_dust.emitting = false
