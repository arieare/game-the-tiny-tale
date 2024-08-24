extends Node

## Global variable
enum game_state{PAUSE, OVER, PLAYING}
var current_game_state = game_state.PAUSE
var game_time:float = 0.0

## List of signal
signal change_scene
signal scene_ready

## List of game variable
var fragment_collected: int = 0
var player : CharacterBody3D
var cam : Camera3D
var world : Node3D

## List of game node
@onready var root = get_tree().get_root().get_child(0)
@onready var game_instance_node = $game_instance # node for running game instance
var menu_start_scene = preload("res://scene/menu_start.tscn")

## List of ToDos
#TODO 1
#TODO 2

func _ready() -> void:
	print(root)
	game_init()

## Init functions
func game_init():
	connect_root_signals()
	game_instance_node.add_child(menu_start_scene.instantiate())

func connect_root_signals():
	self.connect("change_scene", _on_scene_change)
	self.connect("scene_ready", _on_scene_ready)

## Signals callback
func _on_scene_change(_from, _to):
	var running_instance = game_instance_node.get_child(0)
	if running_instance:
		running_instance.queue_free()

func _on_scene_ready():
	pass
