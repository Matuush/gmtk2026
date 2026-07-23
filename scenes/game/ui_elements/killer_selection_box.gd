class_name killer_selection_box extends VBoxContainer

@onready var Boxes : Array[offered_item_button] = [$OfferedItem1, $OfferedItem2, $OfferedItem3, $OfferedItem4]

func make_items():
	for i : int in range(game.killer_count):
		var new_item : killer_enums.names = game.level_killers[i]
		Boxes[i].set_item(new_item)

func select_button(selected_id : int):
	if game.selected_item_button != null:
		game.selected_item_button.deselect_button()
	if game.hover_over_simulation and game.selected_item_instance != null:
			game.selected_item_instance._on_stop_hover()
	for item_button in Boxes:
		if selected_id == item_button.button_id:
			game.selected_item_button = item_button
	game.selected_item_button.select_button()
	game.selected_item_instance = game.selected_item_button.killer_current_instance
	if game.hover_over_simulation and game.selected_item_instance != null:
		game.selected_item_instance._on_hover()
	SignalManager.item_selected.emit()
