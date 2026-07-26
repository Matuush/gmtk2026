extends Node

signal item_selected
signal item_used

signal on_new_game()

signal change_game_state (new_state : main.game_state)
signal volume_change (new_value : float)
signal music_volume_change (new_value : float)

signal enemy_leave_scene(enemy : amoeba)
signal enemy_count_changed

signal box_selection(button_id : int)

signal purchase_text(text : String)

signal add_money(value : int)

signal error_message(text : String)
