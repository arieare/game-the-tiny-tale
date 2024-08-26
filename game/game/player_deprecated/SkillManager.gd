extends Node


# Game State
enum weaponOptions {WEAPON_MELEE, WEAPON_RANGE}
var currentWeapon = weaponOptions.WEAPON_MELEE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("switchWeapon"):
		currentWeapon = wrapi(currentWeapon + 1, 0, weaponOptions.size())
		print(weaponOptions.keys()[currentWeapon])
