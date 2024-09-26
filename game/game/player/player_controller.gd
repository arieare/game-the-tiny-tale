extends RigidBody3D
class_name PhysicsBasedPlayer

## List of node
@onready var root = get_tree().get_root().get_child(0)

@export var collider:CollisionShape3D
@export var ray:RayCast3D
@export var skin:Node3D
@export var body:Node3D
@export var body_head:Node3D
@export var body_torso:MeshInstance3D
@export var look_aim: MeshInstance3D

## List of movement node
@export var move_bobbing:Node3D
@export var move_upright:Node

# Control
@export var player_input:Node
@export var movement_state_machine:StateMachine
@export var position_state_machine:StateMachine

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)
	position_state_machine.process_input(event)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
	position_state_machine.process_frame(delta)
	
	var rotation_diff = body_head.rotation_degrees.y - body.rotation_degrees.y 
	
	root.common["look_at_target"].look_at_target(look_aim, body_head, 0.1)
	root.common["look_at_target"].look_at_target(look_aim, body, 0.03)

	
	if rotation_diff > 10.0 or rotation_diff < -10.0:
		is_head_rotate_too_far = true
	elif rotation_diff < 10.0 or rotation_diff > -10.0:
		is_head_rotate_too_far = false

## TODO
# [ ] breathing idle

func _ready() -> void:
	#self.rotation_degrees.y = 90
	movement_state_machine.init_state(self)
	position_state_machine.init_state(self)
	ray.actor = self
	
	register_self_to_root()
	move_upright.assert_parent(self)
	move_bobbing.assert_parent(self)
	#body_head.top_level=true

func register_self_to_root():
	root.player = self
	root.cam_target = self

var is_head_rotate_too_far: bool = false
	
func _physics_process(delta: float) -> void:
	ray.ray_module["levitate"].levitate_actor(delta,self)
	
	movement_state_machine.process_physics(delta)
	position_state_machine.process_physics(delta)

	match root.current_drive_state:
		root.DRIVE_STATE.PARK:
			if player_input.get_direction() == Vector3.ZERO or self.angular_velocity.x > 15 or self.angular_velocity.x < -15 or self.angular_velocity.y > 5 or self.angular_velocity.y < -5 or self.angular_velocity.z > 15 or self.angular_velocity.z < -15:
				if move_upright :move_upright.maintain_upright(delta)
			else:
				#if move_upright :move_upright.maintain_upright(delta)
				if move_bobbing :move_bobbing.walk_bobbing(delta)


### FX
#@export var fx_transform_node: NodePath
#@onready var fx_transform:GPUParticles3D = get_node(fx_transform_node)
#@export var fx_splash_node: NodePath
#@onready var fx_splash:GPUParticles3D = get_node(fx_splash_node)
#
### SFX
#@export var sfx_transform_node: NodePath
#@onready var sfx_transform:AudioStreamPlayer = get_node(sfx_transform_node)
#@export var sfx_splash_node: NodePath
#@onready var sfx_splash:AudioStreamPlayer = get_node(sfx_splash_node)
#
