extends Node
@export var weaponMeleeController : Node
var skillManager: Node

func _ready():
	skillManager = get_parent()
	
func _physics_process(delta):
	if skillManager.currentWeapon == skillManager.weaponOptions.WEAPON_MELEE:
		if Input.is_action_just_pressed("attack"):
			weaponMeleeController.slash()
