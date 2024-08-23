extends Node

func screenShake(time, amount):
	if game.mainCam:
		var shaker = get_node(game.mainCam.get_node("CamShake").get_path())
		if shaker:
			shaker.shake(time, amount)
