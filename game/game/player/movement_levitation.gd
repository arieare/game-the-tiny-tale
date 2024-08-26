extends Node

var parent: RigidBody3D
var LEV_DISTANCE: float = 1.0
var LEV_STIFFNESS: float = 400
var LEV_DAMP: float = 10

#Snapping value
var snap_distance: float = 1
var snap_distance_multiplier: float = 0.1

#Ground variable
var is_on_floor: bool = false
var floor_normal: Vector3 = Vector3.UP
var floor_slope: float = 0.0
var max_floor_angle: float = 46

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

func levitate(delta):
	parent.ray_node.force_raycast_update()
	floor_check()
	
	if !ray_collision_check().is_colliding:
		parent.ray_node.target_position.y = -LEV_DISTANCE
		return
	
	var relative_y_velocity: float = parent.linear_velocity.y - ray_collision_check().col_body_velocity.y
	var snap_distance_multiplier_b: float = parent.linear_velocity.y * snap_distance_multiplier
	snap_distance_multiplier_b = clamp(snap_distance_multiplier_b, 0, 1)
	var final_snap_distance: float = snap_distance - snap_distance * snap_distance_multiplier_b
	
	parent.ray_node.target_position.y = -LEV_DISTANCE - final_snap_distance
	
	#Levitation spring
	var offset: float = ray_collision_check().col_distance - LEV_DISTANCE
	var stiffness: float = -offset * LEV_STIFFNESS
	var dampness: float = relative_y_velocity * LEV_DAMP
	var spring_force: float = stiffness - dampness

	#If we are under the levitation distance, push up.
	if offset < 0:
		parent.apply_central_force(Vector3.UP * spring_force * parent.mass)
		
		#Apply force to the object we are standing on.
		if ray_collision_check().col_body is RigidBody3D:
			var static_force: float =  parent.mass * 5
			var dynamic_force: float  = clamp(-relative_y_velocity, 0 , INF) * parent.mass * 5
			var final_force: Vector3 = Vector3.DOWN * (static_force + dynamic_force)
			ray_collision_check().col_body.apply_force(final_force, ray_collision_check().col_position -  ray_collision_check().col_body.position)
		
		return 	
	
	#Check if there is a free path to snap.
	var parent_half_size: float = parent.collider_node.shape.height / 2
	var cast_distance: float = (ray_collision_check().col_distance - parent_half_size) * 0.9
	var is_can_snap: bool = not parent.test_move(parent.global_transform, Vector3.DOWN * cast_distance)
	
	#If we are above the levitation distance but the ray hits floor, push down.
	if is_on_floor and is_can_snap:
		parent.apply_central_force(Vector3.UP * spring_force * parent.mass)

func floor_check()->void:
	var max_floor_dot: float = cos(deg_to_rad(max_floor_angle))
	
	is_on_floor = false
	floor_normal = Vector3.ZERO
	floor_slope = 0.0
	
	if !ray_collision_check().is_colliding: return
		
	if !ray_collision_check().col_normal.dot(Vector3.UP) > max_floor_dot: return
		
	is_on_floor = true
	floor_normal = ray_collision_check().col_normal
	floor_slope = rad_to_deg(acos(floor_normal.dot(Vector3.UP)))
	
	if ray_collision_check().col_body is RigidBody3D:
		var body: CollisionObject3D = ray_collision_check().col_body
		var contact_position: Vector3 = ray_collision_check().col_position
	
	return

func ray_collision_check()->Dictionary:
# returns a dictionary with information about the raycast
	var is_colliding: bool = false
	var col_position: Vector3  = Vector3.ZERO
	var col_distance: float = 0.0
	var col_normal: Vector3  = Vector3.ZERO
	var col_slope: float = 0.0
	var col_body = null
	var col_body_velocity: Vector3 = Vector3.ZERO

	if parent.ray_node.is_colliding():
		is_colliding = true
		col_position = parent.ray_node.get_collision_point()
		col_distance = parent.global_position.distance_to(col_position)
		col_normal = parent.ray_node.get_collision_normal()
		col_slope =  rad_to_deg(acos(col_normal.dot(Vector3.UP)))
		col_body = parent.ray_node.get_collider()

		if col_body is RigidBody3D:
			col_body_velocity = parent.get_velocity_at_position(col_body, col_position)

	var results : Dictionary = {
		"is_colliding": is_colliding,
		"col_position": col_position,
		"col_distance": col_distance,
		"col_normal": col_normal,
		"col_slope": col_slope,
		"col_body" : col_body,
		"col_body_velocity" : col_body_velocity}

	return results
