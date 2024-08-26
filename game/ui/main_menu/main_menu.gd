extends Control

@export var start_btn_node: NodePath
@onready var start_btn = get_node(start_btn_node)
@export var credit_btn_node: NodePath
@onready var credit_btn = get_node(credit_btn_node)
@onready var quit_btn = $marginbox/vbox/vbox/quit_btn

func _ready() -> void:
	start_btn.grab_focus()

func _input(event: InputEvent) -> void:
	if !event.is_echo() and start_btn.button_pressed:
		print("start the game")
	if !event.is_echo() and credit_btn.button_pressed:
		print("show credit")
	if !event.is_echo() and quit_btn.button_pressed:
		get_tree().quit()
