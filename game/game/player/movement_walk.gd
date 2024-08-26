extends Node3D

var parent: RigidBody3D
var WALK_SPEED:float = 8
var ACCELERATION:float = 70

#Bobbing movement
var walk_frequence:float = WALK_SPEED * 4
var walk_amplitude:float = PI * walk_frequence / 2
var walk_decay:float = 0.9
var walk_time:float = 0.0
var walk_amount:float = 0.0	

#IK target
@onready var left_target = $"../../ik_target/left_target"
@onready var right_target = $"../../ik_target/right_target"
#@onready var skeleton_ik_left = $"../../body/hip/Leg Rigging Finished/Skeleton3D/left_leg"
#@onready var skeleton_ik_right = $"../../body/hip/Leg Rigging Finished2/Skeleton3D/right_leg"

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
	
	var leaning_point: Vector3 = Vector3(0, 0.00025, 0)
	
	#parent.apply_central_force(target_acceleration * parent.mass)
	parent.apply_force(target_acceleration * parent.mass, leaning_point)
	
	rotate_toward_direction(direction)
	if direction != Vector3.ZERO:
		walk_bobbing(delta)

func rotate_toward_direction(direction):
	if parent.transform.origin != parent.global_position + direction:
		parent.rotation.y = lerp_angle(parent.rotation.y, atan2(-parent.linear_velocity.x, -parent.linear_velocity.z), 0.8)	
		parent.rotation.x = lerp_angle(parent.rotation.x, 0, 0.1)
		parent.rotation.z = lerp_angle(parent.rotation.z, 0, 0.1)

func walk_bobbing(delta):
	#skeleton_ik_left.start()
	#skeleton_ik_right.start()
	walk_amount = 1.0
	walk_time += delta
	walk_amount *= walk_decay
	var push_down_force = sin(walk_time*walk_frequence)*walk_amplitude*walk_amount
	var push_down_cycle = sin(walk_time*walk_frequence/2)*walk_amplitude*walk_amount
	
	#parent.apply_central_force(Vector3.UP * push_down_force * parent.mass)
	
	## Bob left and right
	var ik_foot_to_update = right_target
	var bobbing_point: Vector3 = Vector3(-0.025, 0, 0)
	
	if push_down_cycle < 0:
		bobbing_point = Vector3(0.025, 0, 0)
		ik_foot_to_update = left_target
	
	var ik_position_from_hip: Vector3 = to_global(bobbing_point * 5.5 * Vector3(1,1,1) + Vector3(0,0,-0.25))
	
	parent.apply_force(Vector3.UP * push_down_force * parent.mass, bobbing_point)
	ik_foot_to_update.global_position = to_local(parent.move_levitate.ray_collision_check().col_position) + ik_position_from_hip
