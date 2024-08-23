extends Node

const SPEED = 6.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var rayCast
var castGrid = 1
@export var aimPointer:Marker3D

func _physics_process(delta):
	rayCast = game.RayCastFromMouse()

	if rayCast:
		MoveSurfacePointer(rayCast)
	var lookAtAim = Vector3(aimPointer.global_position.x, game.player.position.y, aimPointer.global_position.z)
	game.player.look_at(lookAtAim)

	# Add the gravity.
	if not game.player.is_on_floor():
		game.player.velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and game.player.is_on_floor():
		game.player.velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var direction
	
	if game.mainCam:
		direction = (Vector3(-1,-1,-1) * game.mainCam.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		direction = -direction
	else:
		direction = (game.player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var dustFX = get_parent().get_node("FXRunningDust")
	if direction:
		game.player.velocity.x = direction.x * SPEED
		game.player.velocity.z = direction.z * SPEED
		#game.player.rotation.y = atan2(-game.player.velocity.x, -game.player.velocity.z)
		dustFX.emitting = true
	else:
		dustFX.emitting = false
		game.player.velocity.x = move_toward(game.player.velocity.x, 0, SPEED)
		game.player.velocity.z = move_toward(game.player.velocity.z, 0, SPEED)

	game.player.move_and_slide()

func MoveSurfacePointer(source):
	if not source.is_empty() and source:
		aimPointer.global_position.x = source.position.x
		aimPointer.global_position.z = source.position.z
