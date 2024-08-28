extends Node

## Global variable
enum GAME_STATE{PAUSE, OVER, PLAYING}
var current_game_state = GAME_STATE.PAUSE
var game_time:float = 0.0

## List of signal
signal change_scene
signal scene_ready

## List of game variable
var player : CharacterBody3D
var cam : Camera3D
var world : Node3D

var fragment_collected: int = 0

## List of game node
@onready var root = get_tree().get_root().get_child(0)

@export var game_instance_node:NodePath
@onready var game_instance = get_node(game_instance_node)

@export var app_instance_node:NodePath
@onready var app_instance = get_node(app_instance_node)

@export var ui_instance_node:NodePath
@onready var ui_instance = get_node(ui_instance_node)

var menu_main = preload("res://ui/main_menu/main_menu.tscn")

## List of ToDos
#TODO 1
#TODO 2

func _ready() -> void:
	print(root)
	game_init()

## Init functions
func game_init():
	connect_root_signals()
	ui_instance.add_child(menu_main.instantiate())

func connect_root_signals():
	self.connect("change_scene", _on_scene_change)
	self.connect("scene_ready", _on_scene_ready)

## Signals callback
func _on_scene_change(_from, _to):
	var running_instance = game_instance.get_child(0)
	if running_instance:
		running_instance.queue_free()

func _on_scene_ready():
	pass
