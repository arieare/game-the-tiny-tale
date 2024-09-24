extends RigidBody3D

@export var interaction:InteractionAreaModule
@export var hurt_box:HurtBoxModule
var is_hurt_box: bool = false
var knockback_vector: float = 0.0
var knockback_decay: float = 15.0
var knockback_timer: float = 0.0

func _ready() -> void:
	interaction.interact = Callable(self, "_test_interact")
	hurt_box.attack = Callable(self, "_test_attack")
	
func _process(delta: float) -> void:
	if knockback_timer > 0:
		self.linear_velocity = Vector3(0,knockback_vector,0)
		#self.apply_central_impulse(Vector3(0,knockback_vector,0) * self.mass)
		knockback_timer -= knockback_decay * delta

func _test_interact():
	print("hello")

func _test_attack():
	if knockback_vector <= 0:
		knockback_vector = 20.0
		knockback_timer = knockback_vector
	print("ack!")
