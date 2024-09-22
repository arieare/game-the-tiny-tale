extends Node3D


# Game State
enum WEAPON_OPTION {MELEE, RANGE}
var current_weapon = WEAPON_OPTION.MELEE

func _process(delta):
	if Input.is_action_just_pressed("switch_weapon"):
		current_weapon = wrapi(current_weapon + 1, 0, WEAPON_OPTION.size())
