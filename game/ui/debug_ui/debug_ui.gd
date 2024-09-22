extends Control
@onready var root = get_tree().get_root().get_child(0)

@export var fragment_label: Label
@export var game_time_label: Label

func _process(delta: float) -> void:
	if root.game_var:
		fragment_label.text = "◉ × " + str(root.game_var.fragment_collected)
		game_time_label.text = str(root.game_var.game_time.hour) +" : "+ str(root.game_var.game_time.minute)
