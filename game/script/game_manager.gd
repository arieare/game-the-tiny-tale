extends Node

## Global variables
enum game_state{PAUSE, OVER, PLAYING}
var current_game_state = game_state.PAUSE
var game_time:float = 0.0

## List of signals
signal change_scene

## List of game variables
var fragment_collected: int = 0
var player : CharacterBody3D
var cam : Camera3D
var world : Node3D

## List of game nodes
@onready var root = get_tree().get_root().get_child(0)
@onready var game_instance_node = $game_instance
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

## Signals callback
func _on_scene_change(_from, _to):
	pass
