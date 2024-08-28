extends RigidBody3D

## List of node
@onready var root = get_tree().get_root().get_child(0)
@onready var input_node = $controller/input
@onready var collider_node = $collider
@export var ray_node: NodePath
@onready var ray:RayCast3D = get_node(ray_node)

## List of movement node
@export var move_walk_node:NodePath
@onready var move_walk = get_node(move_walk_node)
@export var move_levitate_node: NodePath
@onready var move_levitate = get_node(move_levitate_node)
@export var move_upright_node: NodePath
@onready var move_upright = get_node(move_upright_node)
@export var move_jump_node: NodePath
@onready var move_jump = get_node(move_jump_node)


## TODO
# [ ] add character look at mouse or camera forward
# [ ] breathing idle

func _ready() -> void:
	move_walk.assert_parent(self)
	move_levitate.assert_parent(self)
	move_upright.assert_parent(self)
	move_jump.assert_parent(self)

func _physics_process(delta: float) -> void:
	if move_levitate: move_levitate.levitate(delta)
	
	if move_walk: move_walk.walk(input_node.get_direction(), delta)
	
	if move_jump: move_jump.jump(delta)	
	move_jump.fall(delta)	
	
	if input_node.get_direction() == Vector3.ZERO or self.angular_velocity.x > 50 or self.angular_velocity.x < -50 or self.angular_velocity.y > 50 or self.angular_velocity.y < -50 or self.angular_velocity.z > 50 or self.angular_velocity.z < -50:
		move_upright.maintain_upright(delta)
	#if input_node.get_input() == Vector3.ZERO:
		#move_upright_node.maintain_upright(delta)		
		
	
	
