extends Node

@export var weaponRangeController : Node
var skillManager: Node
var warpFX : GPUParticles3D
func _ready():
	skillManager = get_parent()
	warpFX = get_parent().get_parent().get_node("FXPoof")
func _physics_process(delta):
	if skillManager.currentWeapon == skillManager.weaponOptions.WEAPON_RANGE:
		if Input.is_action_just_released("attack"):
			weaponRangeController.shoot()
		if Input.is_action_just_pressed("warp"):
			
			if weaponRangeController.projectileLatest:
				fx.screenShake(0.05,0.25)
				get_parent().get_parent().get_node("Mesh/Body").visible = false
				get_parent().get_parent().get_node("Mesh/Soul").visible = true
				var warpToward = weaponRangeController.projectileLatest.global_position
				var tween = create_tween().set_trans(Tween.TRANS_CIRC)
				tween.tween_property(
					game.player,
					"global_position",
					warpToward,
					0.1
				)
				
				tween.connect("finished", _onWarpDone)
					

func hit_stop(timeScale, duration):
	Engine.time_scale = timeScale
	var timer = get_tree().create_timer(timeScale * duration)
	await timer.timeout
	Engine.time_scale = 1

func _onWarpDone():
	var fxSpawn = weaponRangeController.projectileLatest.global_position
	weaponRangeController.projectileLatest.queue_free()
	warpFX.restart()
	warpFX.emitting = true
	hit_stop(0.05, 0.075)
	get_parent().get_parent().get_node("Mesh/Body").visible = true
	get_parent().get_parent().get_node("Mesh/Soul").visible = false
	#var warpFX = get_parent().get_parent().get_node("GPUParticles2D")
	#warpFX.position = game.mainCam.unproject_position(game.player.global_position)
	#warpFX.emitting = true

	
