extends Area3D
class_name HurtBoxModule

## List of node
@onready var root = get_tree().get_root().get_child(0)

@export var collision:CollisionShape3D
@export var collision_radius: float = 2.0

var attack: Callable = func():
	pass

#func _physics_process(delta: float) -> void:
	#var area = self.get_overlapping_areas()
	#if area.size() > 0:
		#await self.attack.call()
		#area = []
	
func _on_area_entered(area: Area3D) -> void:
	await self.attack.call()
