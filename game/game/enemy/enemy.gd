extends StaticBody3D

@export var interaction:InteractionAreaModule

func _ready() -> void:
	interaction.interact = Callable(self, "_test_interact")
	
func _test_interact():
	print("hello")
