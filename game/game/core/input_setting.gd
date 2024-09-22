extends Node

func input_setting():
	var event_w := InputEventKey.new()
	event_w.physical_keycode = KEY_W
	InputMap.add_action("move_forward")
	InputMap.action_add_event("move_forward", event_w)
	
	var event_s := InputEventKey.new()
	event_s.physical_keycode = KEY_S
	InputMap.add_action("move_backward")
	InputMap.action_add_event("move_backward", event_s)	
	
	var event_left := InputEventKey.new()
	event_left.physical_keycode = KEY_LEFT
	InputMap.add_action("steer_left")
	InputMap.action_add_event("steer_left", event_left)
	
	var event_a := InputEventKey.new()
	event_a.physical_keycode = KEY_A
	InputMap.add_action("move_left")
	InputMap.action_add_event("move_left", event_a)
	
	var event_right := InputEventKey.new()
	event_right.physical_keycode = KEY_RIGHT
	InputMap.add_action("steer_right")
	InputMap.action_add_event("steer_right", event_right)
	
	var event_d := InputEventKey.new()
	event_d.physical_keycode = KEY_D
	InputMap.add_action("move_right")
	InputMap.action_add_event("move_right", event_d)		
		
	var event_space := InputEventKey.new()
	event_space.physical_keycode = KEY_SPACE	
	InputMap.add_action("drift")
	InputMap.action_add_event("drift", event_space)	
	InputMap.add_action("jump")
	InputMap.action_add_event("jump", event_space)	

	var event_e := InputEventKey.new()
	event_e.physical_keycode = KEY_E	
	InputMap.add_action("interact")
	InputMap.action_add_event("interact", event_e)	
		
	#region combat input
	var event_shift := InputEventKey.new()
	event_shift.physical_keycode = KEY_SHIFT
	InputMap.add_action("switch_weapon")
	InputMap.action_add_event("switch_weapon", event_shift)		

	var event_left_click := InputEventMouseButton.new()
	event_left_click.button_index = MOUSE_BUTTON_LEFT
	InputMap.add_action("attack")
	InputMap.action_add_event("attack", event_left_click)
	#endregion
