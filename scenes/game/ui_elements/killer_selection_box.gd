class_name killer_selection_box extends VBoxContainer

@onready var Boxes : Array[offered_item_button] = [$OfferedItem1, $OfferedItem2, $OfferedItem3, $OfferedItem4]

func make_items():
	for i : int in range(game.killer_count):
		var new_item : killer_enums.names = game.level_killers[i]
		Boxes[i].set_item(new_item)

func select_button(selected_id : int):
	if game.selected_item_button != null:
		game.selected_item_button.deselect_button()
	for item_button in Boxes:
		if selected_id == item_button.button_id:
			game.selected_item_button = item_button
	game.selected_item_button.select_button()
	game.selected_item_instance = game.selected_item_button.killer_current_instance
	SignalManager.item_selected.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select_item_1"):
		select_button(1)
	if event.is_action_pressed("select_item_2"):
		select_button(2)
	if event.is_action_pressed("select_item_3"):
		select_button(3)
	if event.is_action_pressed("select_item_4"):
		select_button(4)
	#if event.is_action_pressed("increase_sanitizer_radius"):
		#sanitizer.sanitizer_size += 1
