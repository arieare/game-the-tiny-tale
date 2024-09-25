extends Node

var parent: RigidBody3D
var jump_velocity:float = 0.0
var forward_velocity: float = 0.0
var jump_dampen:float = 0.005
var is_jumping:bool = false
var JUMP_SPEED:float = 3.0
var FALL_SPEED: float = 0.2

func assert_parent(parent_node: RigidBody3D):
	parent = parent_node

func jump(should_jump:bool, delta)->void:
	if should_jump and parent.move_levitate.is_on_floor:
		#parent.apply_central_force(Vector3.DOWN * 800 * parent.mass)	
		#await get_tree().create_timer(0.05).timeout
		#parent.apply_central_force(Vector3.UP * 1000 * parent.mass)	
		# ============
		parent.body.scale.y = 0.75
		parent.body.scale.z = 1.5
		await get_tree().create_timer(0.075).timeout
		is_jumping = true
		
		jump_velocity = JUMP_SPEED
		
		
		forward_velocity = parent.linear_velocity.x
		parent.freeze = true
		#parent.apply_central_impulse(Vector3.DOWN * 2 * parent.mass)	
		
		## cartoon squash and stretch effect

		#await get_tree().create_timer(0.075).timeout
		var tween = create_tween().set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(parent.body,"scale:y",1.2,0.1)
		tween.tween_property(parent.body,"scale:z",1,0.1)
	
	if is_jumping:
		
		var body_position: Vector3 = parent.global_position
		if jump_velocity != 0:
			body_position.y += jump_velocity /2
			body_position.x += forward_velocity / 50
			jump_velocity -= jump_dampen
			if jump_velocity <= 0.01:
				parent.freeze = false	
		parent.global_position = body_position
		pass
		
