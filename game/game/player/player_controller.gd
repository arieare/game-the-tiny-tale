extends RigidBody3D

## List of node
@onready var root = get_tree().get_root().get_child(0)
@onready var input_node = $controller/input
@onready var collider_node = $collider
@onready var ray_node = $ray

## List of movement node
@export var move_walk_node:NodePath
@onready var move_walk = get_node(move_walk_node)
@export var move_levitate_node: NodePath
@onready var move_levitate = get_node(move_levitate_node)
@onready var move_upright_node = $movement/upright

## TODO
# [ ] add character look at mouse or camera forward

func _ready() -> void:
	move_walk.assert_parent(self)
	move_levitate.assert_parent(self)
	move_upright_node.assert_parent(self)

func _physics_process(delta: float) -> void:
	move_levitate.levitate(delta)
	
	if move_walk: move_walk.walk(input_node.get_input(), delta)
	
	if input_node.get_input() == Vector3.ZERO: ## Idle
		move_upright_node.maintain_upright(delta)
	
	if Input.is_action_just_pressed("ui_accept") and move_levitate.is_on_floor:
		apply_central_force(Vector3.DOWN * 150 * mass)	
		await get_tree().create_timer(0.05).timeout
		apply_central_force(Vector3.UP * 600 * mass)	
