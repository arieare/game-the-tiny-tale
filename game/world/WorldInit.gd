extends Node

func _ready():
	game.worldNode = get_parent()
	game.player = game.worldNode.get_node("Player")	
	game.mainCam = game.worldNode.get_viewport().get_camera_3d()
