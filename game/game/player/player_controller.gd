extends RigidBody3D
class_name PhysicsBasedPlayer

## List of node
@onready var root = get_tree().get_root().get_child(0)

@export var player_input_node: NodePath
@onready var player_input:Node = get_node(player_input_node)

@export var collider_node: NodePath
@onready var collider:CollisionShape3D = get_node(collider_node)

@export var ray_node: NodePath
@onready var ray:RayCast3D = get_node(ray_node)

@export var body_node: NodePath
@onready var body:Node3D = get_node(body_node)

## List of movement node
@export var move_look_at_node:NodePath
@onready var move_look_at = get_node(move_look_at_node)
@export var move_walk_node:NodePath
@onready var move_walk = get_node(move_walk_node)
@export var move_bobbing_node:NodePath
@onready var move_bobbing = get_node(move_bobbing_node)
@export var move_levitate_node: NodePath
@onready var move_levitate = get_node(move_levitate_node)
@export var move_upright_node: NodePath
@onready var move_upright = get_node(move_upright_node)
@export var move_jump_node: NodePath
@onready var move_jump = get_node(move_jump_node)
@export var move_dive_node: NodePath
@onready var move_dive = get_node(move_dive_node)



## TODO
# [ ] add character look at mouse or camera forward
# [ ] breathing idle

func _ready() -> void:
	register_self_to_root()
	move_look_at.assert_parent(self)
	move_walk.assert_parent(self)
	move_levitate.assert_parent(self)
	move_upright.assert_parent(self)
	move_jump.assert_parent(self)
	move_bobbing.assert_parent(self)
	move_dive.assert_parent(self)

func register_self_to_root():
	root.player = self

func _physics_process(delta: float) -> void:
	if move_look_at: move_look_at.look_at_target()
	
	if move_dive: move_dive.dive(delta)
	
	if move_levitate: move_levitate.levitate(delta)
	
	
	var direction
	
	#if root.cam:
	direction = (root.cam.global_basis * player_input.get_direction()).normalized()
	#direction = -direction	
	#else:
		#direction = player_input.get_direction()
	
	if move_walk: move_walk.walk(direction, delta)
	
		
	if move_jump: move_jump.jump(player_input.get_jump_button(), delta)	
	move_jump.fall(delta)	
	
	if player_input.get_direction() == Vector3.ZERO or self.angular_velocity.x > 15 or self.angular_velocity.x < -15 or self.angular_velocity.y > 5 or self.angular_velocity.y < -5 or self.angular_velocity.z > 15 or self.angular_velocity.z < -15:
		if move_upright :move_upright.maintain_upright(delta)
	else:
		#if move_upright :move_upright.maintain_upright(delta)
		if move_bobbing :move_bobbing.walk_bobbing(delta)


## With top down camera facing direction
#
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	#var direction
	#
	#if game.mainCam:
		#direction = (Vector3(-1,-1,-1) * game.mainCam.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		#direction = -direction
	#else:
		#direction = (game.player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#game.player.velocity.x = direction.x * SPEED
		#game.player.velocity.z = direction.z * SPEED
		##game.player.rotation.y = atan2(-game.player.velocity.x, -game.player.velocity.z)
	#else:
		#game.player.velocity.x = move_toward(game.player.velocity.x, 0, SPEED)
		#game.player.velocity.z = move_toward(game.player.velocity.z, 0, SPEED)
#


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
### List of player style
#enum ABILITY{MAN, SALMON, DEER, BOAR, HARE}
#var current_ability: ABILITY = ABILITY.MAN :
	#set(value):
		#if current_ability != value:
			#current_ability = value
			#ability_state.emit(current_ability)
#signal ability_state(state)
#
#var previous_ability: ABILITY
#var ability_enum_int: int = 0

#func _on_ability_change(ability):
	#fx_transform.restart()
	#fx_transform.emitting = true
	#sfx_transform.play()
	#root.cam.shake.add_trauma(0.15)
	#shape_shift(ability)
	#pass
	#
#func shape_shift(ability):
	#previous_ability = ability
	#match ability:
		#ABILITY.MAN:
			#print("man ability")
			#body.visible = true
			#salmon_body.visible = false
			#hare_body.visible = false
			#pass
		#ABILITY.SALMON:
			#print("salmon ability")
			#body.visible = true
			#salmon_body.visible = true
			#hare_body.visible = false				
			#pass
