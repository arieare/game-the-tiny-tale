extends Node3D

## List of node
@onready var root = get_tree().get_root().get_child(0)
@export var light:DirectionalLight3D

func register_light_to_root():
	root.light = light

func _ready() -> void:
	register_light_to_root()
