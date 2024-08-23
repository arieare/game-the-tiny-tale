extends Control

@onready var start_btn = $marginbox/vbox/vbox/start_btn
@onready var credit_btn = $marginbox/vbox/vbox/credit_btn
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
