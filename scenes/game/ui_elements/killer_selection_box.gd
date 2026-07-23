class_name killer_selection_box extends VBoxContainer

var Boxes : Array[offered_item_button]

func _ready():
	Boxes = [$OfferedItem1, $OfferedItem2, $OfferedItem3, $OfferedItem4]

func make_items():
	for i : int in range(game.killer_count):
		var new_item : killer_enums.names = game.level_killers[i]
		Boxes[i].set_item(new_item)
		

func select_button(selected_id : int):
	for item_button in Boxes:
		if selected_id == item_button.button_id:
			item_button.select_button()
			game.selected_item_button = item_button
		else:
			item_button.deselect_button()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select_item_1"):
		select_button(1)
	if event.is_action_pressed("select_item_2"):
		select_button(2)
	if event.is_action_pressed("select_item_3"):
		select_button(3)
	if event.is_action_pressed("select_item_4"):
		select_button(4)
