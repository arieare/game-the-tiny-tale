extends Node3D

## List of game node
@onready var root = get_tree().get_root().get_child(0)
@export var interaction_label: Label3D

const BASE_INSTRUCTION_TEXT: String = "[E] to "

var active_interactive_area: Array = []
var can_interact: bool = true

func register_interaction_area(area: InteractionAreaModule):
	active_interactive_area.push_back(area)

func unregister_interaction_area(area: InteractionAreaModule):
	var index = active_interactive_area.find(area)
	if index != -1:
		active_interactive_area.remove_at(index)

func _process(delta: float) -> void:
	if active_interactive_area.size() > 0 and can_interact:
		active_interactive_area.sort_custom(_sort_by_distance_to_player)
		interaction_label.text = BASE_INSTRUCTION_TEXT + active_interactive_area[0].interaction_name
		interaction_label.global_position = active_interactive_area[0].global_position
		interaction_label.global_position.y = active_interactive_area[0].global_position.y + active_interactive_area[0].collision.shape.radius
		interaction_label.show()
	else:
		interaction_label.hide()
		
func _sort_by_distance_to_player(area_1, area_2):
	var area_1_to_player = root.player.global_position.distance_to(area_1.global_position)
	var area_2_to_player = root.player.global_position.distance_to(area_2.global_position)
	return area_1_to_player < area_2_to_player

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if active_interactive_area.size() > 0:
			can_interact = false	
			interaction_label.hide()
			await active_interactive_area[0].interact.call()
			can_interact = true
