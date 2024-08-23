extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.rotation.z = deg_to_rad(25)
	self.position.x = 0.4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#self.rotation.y += deg_to_rad(20) * delta
	self.rotation.y += deg_to_rad(15) * delta * 2
	#self.rotation.z += deg_to_rad(5) * delta
	# TODO: Capture mouse drag and rotate towards the direction.
