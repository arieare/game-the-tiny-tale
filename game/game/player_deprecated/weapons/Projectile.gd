extends Node
@export var projectile : Node3D

var speed = 10 #NOTE Default speed
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var forwardDirection = -projectile.global_transform.basis.z.normalized()
	projectile.global_translate(forwardDirection * speed * delta)
	
	#TODO auto kill bullet after x seconds
	
	pass
