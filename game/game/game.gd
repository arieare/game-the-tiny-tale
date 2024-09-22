extends Node

## List of game node
@onready var root = get_tree().get_root().get_child(0)

@export var game_instance_node:NodePath
@onready var game_instance = get_node(game_instance_node)

@export var app_instance_node:NodePath
@onready var app_instance = get_node(app_instance_node)

@export var ui_instance_node:NodePath
@onready var ui_instance = get_node(ui_instance_node)

@export var common_node:NodePath
@onready var common = get_node(common_node)

## UI Nodes
@onready var ui_node: Dictionary = {
	"main_menu": preload("res://ui/main_menu/main_menu.tscn"),
	"debug_ui": preload("res://ui/debug_ui/debug_ui.tscn")}

## Game Nodes
@onready var game_node: Dictionary = {
	"prototype": preload("res://game/prototype/test_player_movement.tscn")}

#region list of signal
signal change_scene
signal scene_ready
signal game_state(current_state, previous_state)
signal play_state(current_state, previous_state)
signal fragment_collected(new_value)
#endregion
#region signal callback
func _on_scene_change(_parent, _from, _to):
	var children_size = _parent.get_child_count()
	var running_instance = _parent.get_child(children_size-1)
	if running_instance:
		running_instance.queue_free()
	if _to:
		var node_instance = _to.instantiate()
		_parent.add_child(node_instance)			

func _on_scene_ready():
	pass

func _on_game_state_change(new_state:GAME_STATE):
	current_game_state = new_state

func _on_fragment_collected(value):
	game_var.fragment_collected += value
#endregion

## List of game variable
var cam: Camera3D
var world: Node3D
var light: DirectionalLight3D
var player: RigidBody3D
#var cursor

var game_var: Dictionary = {
	"player_position": Vector3.ZERO,
	"power_up_collected": [],
	"fragment_collected": 0,
	"game_time": {
		"second" = 0,
		"minute" = 0,
		"hour" = 0,
		"day" = 0}
	}

func _ready() -> void:
	common.input_setting.input_setting()
	connect_root_signals()
	game_setup()

## Init functions
func game_setup():
	ui_instance.add_child(ui_node.main_menu.instantiate())
	game_instance.call_deferred("add_child",game_node.prototype.instantiate())

func connect_root_signals():
	self.connect("change_scene", _on_scene_change)
	self.connect("scene_ready", _on_scene_ready)
	self.connect("fragment_collected", _on_fragment_collected)
	self.connect("game_state", _on_game_state_change)	


## Global variable
# Game State
enum GAME_STATE {START, RUNNING, PAUSE, OVER}
var prev_game_state = GAME_STATE.START
var current_game_state:GAME_STATE = GAME_STATE.START :
	set(value):
		var prev_state = current_game_state
		if current_game_state != value:
			current_game_state = value
			game_state.emit(current_game_state)

# Play State
enum PLAY_STATE {OVERWORLD, DISMANTLE}
var prev_play_state = PLAY_STATE.OVERWORLD
var current_play_state:PLAY_STATE = PLAY_STATE.OVERWORLD :
	set(value):
		var prev_state = current_play_state
		if current_play_state != value:
			current_play_state = value
			play_state.emit(current_play_state, prev_state)

## List of SFX
#@export var sfx_click_node:NodePath
#@onready var sfx_click:AudioStreamPlayer = get_node(sfx_click_node)

func _process(delta: float) -> void:
	match current_game_state:
		GAME_STATE.RUNNING:
			common.day_time.run_game_time(delta)
			game_var.game_time = common.day_time.get_current_game_time()
