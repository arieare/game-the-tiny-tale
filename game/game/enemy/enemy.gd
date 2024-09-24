extends RigidBody3D

@export var interaction:InteractionAreaModule
@export var hurt_box:HurtBoxModule
var is_hurt_box: bool = false

func _ready() -> void:
	interaction.interact = Callable(self, "_test_interact")
	hurt_box.attack = Callable(self, "_test_attack")
	
#func _physics_process(delta: float) -> void:
	#if is_hurt_box:
		#self.apply_central_impulse(Vector3(0,8,0) * self.mass)

func _test_interact():
	print("hello")

func _test_attack():
	#self.linear_velocity += -Vector3.FORWARD * 10
	# Figure out knock back here
	#self.apply_central_impulse(Vector3(0,10,0) * self.mass)
	#is_hurt_box = true
	#await get_tree().create_timer(0.01).timeout
	#is_hurt_box = false
	print("ack!")
