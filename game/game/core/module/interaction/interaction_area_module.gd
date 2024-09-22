extends Area3D
class_name InteractionAreaModule

## List of node
@onready var root = get_tree().get_root().get_child(0)
@export var interaction_name: String = "interact"

@export var collision:CollisionShape3D

var interact: Callable = func():
	pass

func _on_body_entered(body: Node3D) -> void:
	root.common.interaction_manager.register_interaction_area(self)

func _on_body_exited(body: Node3D) -> void:
	root.common.interaction_manager.unregister_interaction_area(self)
