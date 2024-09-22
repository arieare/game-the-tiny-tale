extends Node

# TODO check this cool reference https://github.com/age-of-asparagus/godot3-3dgame/blob/main/3DGame/Weapons/Gun.gd#L13

var canShoot:bool
@export var projectile : PackedScene
@export var nock : Marker3D
#var projectileSpawns = []
var projectilesInQuiver = 100
var projectileSpeed = 20
var projectileLatest
@export var fxSlash : GPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready():
	canShoot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	pass
	#if canShoot and projectilesInQuiver:
		##for spawn in projectileSpawns:
		#var newProjectile = projectile.instantiate()
		#projectileLatest = newProjectile
		#newProjectile.global_transform = nock.global_transform
		#newProjectile.get_children()[0].speed = projectileSpeed #must target the scripts
		##var sceneRoot = get_tree().get_root().get_children()[0]
		#game.worldNode.add_child(newProjectile)
		#fxSlash.emitting = true
		#print("dor!")
		##canShoot = false
		##TODO start timer in between shots
		#projectilesInQuiver -= 1
		##TODO emit signal to display projectile count
		##TODO play effect or recoil
		#
		#return true
	#elif not projectilesInQuiver:
		#pass
		##TODO reload
	#return false
