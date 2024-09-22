extends Node3D

## List of node
@onready var root = get_tree().get_root().get_child(0)

@export var light_node: NodePath
@onready var light:Node = get_node(light_node)

func register_light_to_root():
	root.light = light

func _ready() -> void:
	register_light_to_root()
