extends Area3D
@onready var root = get_tree().get_root().get_child(0)

@export var interaction_node:NodePath
@onready var interaction:InteractionAreaModule = get_node(interaction_node)

func _ready() -> void:
	interaction.interact = Callable(self, "_test_interact")

func _test_interact():
	var move_toward_position = root.player.global_position
	var tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(
		self,
		"global_position",
		move_toward_position,
		0.2)
	await tween.finished
	self.queue_free()
	root.emit_signal("fragment_collected", 1)
