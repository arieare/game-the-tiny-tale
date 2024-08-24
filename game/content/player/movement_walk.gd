extends Node

var parent: RigidBody3D
var WALK_SPEED:float = 20
var ACCELERATION:float = 100

#Bobbing movement
var walk_frequence:float = 30
var walk_amplitude:float = PI * 10
var walk_decay:float = 0.9
var walk_time:float = 0.0
var walk_amount:float = 0.0	

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
	
	var leaning_point: Vector3 = Vector3(0, 0.0025, 0)
	parent.apply_force(target_acceleration * parent.mass, leaning_point)
	#parent.apply_central_force(target_acceleration * parent.mass)
	rotate_toward_direction(direction)
	if direction != Vector3.ZERO:
		walk_bobbing(delta)

func rotate_toward_direction(direction):
	if parent.transform.origin != parent.global_position + direction:
		parent.rotation.y = lerp_angle(parent.rotation.y, atan2(-parent.linear_velocity.x, -parent.linear_velocity.z), 0.8)	
		parent.rotation.x = lerp_angle(parent.rotation.x, 0, 0.1)
		parent.rotation.z = lerp_angle(parent.rotation.z, 0, 0.1)

func walk_bobbing(delta):
	walk_amount = 1.0
	walk_time += delta
	walk_amount *= walk_decay
	var push_down_force = sin(walk_time*walk_frequence)*walk_amplitude*walk_amount
	parent.apply_central_force(Vector3.UP * push_down_force * parent.mass)
