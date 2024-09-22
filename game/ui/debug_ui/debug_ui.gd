extends Control
@onready var root = get_tree().get_root().get_child(0)

@export var fragment_label_node: NodePath
@onready var fragment_label: Label = get_node(fragment_label_node)

@export var game_time_label_node: NodePath
@onready var game_time_label: Label = get_node(game_time_label_node)

func _process(delta: float) -> void:
	if root.game_var:
		fragment_label.text = "◉ × " + str(root.game_var.fragment_collected)
		game_time_label.text = str(root.game_var.game_time.hour) +" : "+ str(root.game_var.game_time.minute)
