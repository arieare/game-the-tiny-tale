extends RigidBody3D
class_name PhysicsBasedPlayer

## List of node
@onready var root = get_tree().get_root().get_child(0)

@export var collider:CollisionShape3D
@export var ray:RayCast3D
@export var body:Node3D

## List of movement node
@export var move_look_at:Node3D
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

## TODO
# [ ] breathing idle

func _ready() -> void:
	movement_state_machine.init_state(self)
	position_state_machine.init_state(self)
	ray.actor = self
	
	register_self_to_root()
	move_look_at.assert_parent(self)
	move_upright.assert_parent(self)
	move_bobbing.assert_parent(self)

func register_self_to_root():
	root.player = self
	root.cam_target = self

func _physics_process(delta: float) -> void:
	ray.ray_module["levitate"].levitate_actor(delta,self)
	
	movement_state_machine.process_physics(delta)
	position_state_machine.process_physics(delta)
	
	if move_look_at: move_look_at.look_at_target()
	
	
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
