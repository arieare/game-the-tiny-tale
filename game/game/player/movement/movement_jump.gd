extends Node

var parent: RigidBody3D
var jump_velocity:float = 0.0
var forward_velocity: float = 0.0
var jump_dampen:float = 0.025
var is_jumping:bool = false
var JUMP_SPEED:float = 0.2
var FALL_SPEED: float = 0.5

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

func jump(should_jump:bool, delta)->void:
	if should_jump and parent.move_levitate.is_on_floor:
		#parent.apply_central_force(Vector3.DOWN * 800 * parent.mass)	
		#await get_tree().create_timer(0.05).timeout
		#parent.apply_central_force(Vector3.UP * 1000 * parent.mass)	
		# ============
		is_jumping = true
		
		jump_velocity = JUMP_SPEED
		
		
		forward_velocity = parent.linear_velocity.x
		parent.freeze = true
		#parent.apply_central_impulse(Vector3.DOWN * 2 * parent.mass)	
		
		## cartoon squash and stretch effect
		#parent.body.scale.y = 0.75
		#parent.body.scale.z = 1.5
		#await get_tree().create_timer(0.075).timeout
		#var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
		#tween.tween_property(parent.body,"scale:y",1.2,0.1)
		#tween.tween_property(parent.body,"scale:z",1,0.1)
	
	if is_jumping:
		var body_position: Vector3 = parent.global_position
		if jump_velocity != 0:
			body_position.y += jump_velocity
			body_position.x += forward_velocity / 50
			jump_velocity -= jump_dampen
			if jump_velocity <= 0.01:
				parent.freeze = false
			if jump_velocity <= 0:
				fall(delta)
				jump_velocity = 0		
		parent.global_position = body_position
		pass
		

#func fall(delta):
	#if !Input.is_action_just_pressed("jump") or parent.linear_velocity.y <= 0.0:
		#parent.apply_central_force(Vector3.DOWN * 50 * parent.mass)	


func fall(delta):
	if !parent.move_levitate.is_on_floor:
	#if parent.linear_velocity.y <= 0.02 and !parent.move_levitate.is_on_floor:
		is_jumping = false
		parent.freeze = false
		var vertical_velocity = parent.linear_velocity * Vector3.UP
		var target_velocity: Vector3 = (Vector3.DOWN * FALL_SPEED)
		var acceleration_goal = target_velocity - vertical_velocity	
		var target_acceleration = acceleration_goal / delta
			
		# clamp ForceToGoalAcceleration to our maximum allowed acceleration.
		if target_acceleration.length() > FALL_SPEED: 
			target_acceleration = (target_acceleration.normalized() * FALL_SPEED)
		
		#var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
		#tween.tween_property(parent.body,"scale:y",1,0.03)	
		
		parent.apply_central_impulse(Vector3.DOWN * FALL_SPEED * parent.mass)
		if parent.move_levitate.is_on_floor:
			parent.linear_velocity.y = 0
