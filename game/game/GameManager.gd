extends Node

#var player : CharacterBody3D
#
#var mainCam : Camera3D
#var worldNode : Node3D

var mouse : Vector2
var rayQuery = PhysicsRayQueryParameters3D.new()
var rayLength = 100.0

var currentSoul = 0

signal soul_collected(new_value)

# Game State
enum gameStates {GAME_START, GAME_RUNNING, GAME_OVER}
var prevGameState = gameStates.GAME_START
var currentGameState = gameStates.GAME_START

# Play State
enum playStates {PLAY_OVERWORLD, PLAY_DISMANTLE}
var prevPlayState = playStates.PLAY_OVERWORLD
var currentPlayState = playStates.PLAY_OVERWORLD

signal game_state_changed(currentState, previousState)

func _ready():
	soul_collected.connect(_onSoulCollected)
	
func _onSoulCollected(value):
	currentSoul += value

func UpdateGameState(newState):
	prevGameState = currentGameState
	currentGameState = newState
	emit_signal("game_state_changed", currentGameState, prevGameState)

#func RayCastFromMouse():
	#mouse = worldNode.get_viewport().get_mouse_position()
	#rayQuery.from = mainCam.project_ray_origin(mouse)
	#rayQuery.to = rayQuery.from + mainCam.project_ray_normal(mouse) * rayLength
	#rayQuery.collide_with_areas = false
	#return mainCam.get_world_3d().direct_space_state.intersect_ray(rayQuery)
#
#func GetChildNodeWithType(parentNode:Node, nodeType) -> Array:
	#var type
	#var nodes:Array
	#for node in parentNode.get_children():
		#type = node.get_class()
		#if type == nodeType:
			#nodes.append(node) 
	#return nodes
