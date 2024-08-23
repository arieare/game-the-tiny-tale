extends Node
var tween: Tween
var camOffset = Vector3(0, 20, 8)

func _process(delta):
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	var camMovingDirection = game.player.global_transform.origin + camOffset
	tween.tween_property(
		game.mainCam,
		"global_transform:origin",
		camMovingDirection,
		0.2
	)
