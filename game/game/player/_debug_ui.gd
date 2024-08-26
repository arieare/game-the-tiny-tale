extends Control

@onready var check_float: CheckBox = $vbox/check_float

func _ready() -> void:
	print(check_float.button_pressed)

func _process(delta: float) -> void:
	if check_float.button_pressed:
		print(check_float.button_pressed)
