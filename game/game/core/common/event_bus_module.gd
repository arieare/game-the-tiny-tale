extends Node
class_name CommonEventBus

#region app signals
signal change_scene
signal scene_ready
#endregion

#region state signals
signal game_state(current_state, previous_state)
signal car_drive_state(current_state, previous_state)
signal play_state(current_state, previous_state)
#endregion

#region game signals
signal fragment_collected(new_value)
#endregion
