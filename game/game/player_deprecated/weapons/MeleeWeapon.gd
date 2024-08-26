extends Node
@export var hitBox : Area3D
@export var fxSlash : GPUParticles3D

func slash():
	fxSlash.emitting = true
	var hitEntities = hitBox.get_overlapping_bodies()
	for entities in hitEntities:
		if entities.is_in_group("enemy"):
			print(entities)
