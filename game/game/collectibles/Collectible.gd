extends Node
var interactArea : Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	interactArea = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		var hitEntities = interactArea.get_overlapping_bodies()
		if hitEntities:
			var moveToward = game.player.global_position
			var tween = create_tween().set_trans(Tween.TRANS_CIRC)
			tween.tween_property(
				interactArea,
				"global_position",
				moveToward,
				0.2
			)
			await tween.finished
			interactArea.queue_free()
			print("hey")
			game.soul_collected.emit(1)
