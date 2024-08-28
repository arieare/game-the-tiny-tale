extends Node3D

## TODO
# [ ] ADD FEET PLACEMENT RAY

var parent: RigidBody3D
var WALK_SPEED:float = 8
var ACCELERATION:float = 40

#Bobbing movement
var step_magnitude:float = 45 # the bigger, the smaller step it is
var walk_frequence:float = WALK_SPEED * (step_magnitude/WALK_SPEED)
var walk_amplitude:float = PI * walk_frequence
var walk_decay:float = 0.5
var walk_time:float = 0.0
var walk_amount:float = 0.0	

#IK target
@export var left_target_node: NodePath
@export var right_target_node: NodePath
@onready var left_target = get_node(left_target_node)
@onready var right_target = get_node(right_target_node)
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
	
	var leaning_point: Vector3 = Vector3(0, -0.6, 0)
	
	parent.apply_force(target_acceleration * parent.mass, leaning_point)
	
	face_direction(direction)
	if direction != Vector3.ZERO and parent.move_levitate.is_on_floor:
		walk_bobbing(delta)

func face_direction(direction):
	if parent.transform.origin != parent.global_position + direction:
		parent.rotation.y = lerp_angle(parent.rotation.y, atan2(-parent.linear_velocity.x, -parent.linear_velocity.z), 0.75)	
		parent.rotation.x = lerp_angle(parent.rotation.x, 0, 0.9)
		parent.rotation.z = 0
		#parent.rotation.z = 0

func walk_bobbing(delta):
	#skeleton_ik_left.start()
	#skeleton_ik_right.start()
	
	walk_amount = 1.0
	walk_time += delta
	walk_amount *= walk_decay
	var push_down_force = sin(walk_time*walk_frequence)*walk_amplitude*walk_amount * 0
	
	
	## Bob left and right
	var push_down_cycle = sin(walk_time*walk_frequence/2)*walk_amplitude*walk_amount
	var ik_foot_to_update = right_target
	var bobbing_point: Vector3 = Vector3(-0.15, 0, 0)
	if push_down_cycle < 0:
		bobbing_point = bobbing_point * -1
		ik_foot_to_update = left_target
	parent.apply_force(Vector3.UP * push_down_force * parent.mass, bobbing_point)
	
	
	
	var ik_position_from_hip: Vector3 = to_global(bobbing_point + Vector3(0,0,-0.3))
	var new_ik_position = to_local(parent.move_levitate.ray_collision_check().col_position) + ik_position_from_hip
	
	var height_ik_position:Vector3 = Vector3(0,0.2,0)
	var half_ik_position = ik_foot_to_update.global_position.lerp(new_ik_position, 0.5) + height_ik_position
	#ik_foot_to_update.global_position = new_ik_position
	
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(ik_foot_to_update,"global_position",half_ik_position,0.02)
	await tween
	tween.tween_property(ik_foot_to_update,"global_position",new_ik_position,0.015)
