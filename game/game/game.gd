extends Node

## List of game variable
@onready var player: RigidBody3D
@onready var cam: Node3D
@onready var cam_target = null
@onready var world: Node3D
@onready var light: DirectionalLight3D
@onready var car: RigidBody3D

## List of game node
@onready var root = get_tree().get_root().get_child(0)

## Singletons
@export var game_instance:Node
@export var app_instance:Node
@export var ui_instance: Node
@export var common: Node

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
signal car_drive_state(current_state, previous_state)
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

func _on_car_drive_state_change(new_state:DRIVE_STATE):
	current_drive_state = new_state
#endregion


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
	self.connect("car_drive_state", _on_car_drive_state_change)	


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

# Drive State
enum DRIVE_STATE {PARK, DRIVE}
var prev_drive_state = DRIVE_STATE.PARK
var current_drive_state:DRIVE_STATE = DRIVE_STATE.PARK :
	set(value):
		var prev_state = current_drive_state
		if current_drive_state != value:
			current_drive_state = value
			car_drive_state.emit(current_drive_state)			

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
