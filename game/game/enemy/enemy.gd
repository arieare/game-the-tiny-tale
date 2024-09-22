extends StaticBody3D

@export var interaction_node:NodePath
@onready var interaction:InteractionAreaModule = get_node(interaction_node)

func _ready() -> void:
	interaction.interact = Callable(self, "_test_interact")
	
func _test_interact():
	print("hello")
