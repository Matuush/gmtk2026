class_name killer_selection_box extends VBoxContainer

@export var Boxes : Array[offered_killer] 
const idle_string : String = "[b]Over here!! Buy some stuff!!![/b]" 

func _ready() -> void:
	SignalManager.box_selection.connect(select_button)
	SignalManager.purchase_text.connect(display_text)

func make_items():
	for i : int in range(game.killer_count):
		var new_item : killer_enums.names = game.level_killers[i]
		Boxes[i].set_item(new_item)

func select_button(selected_id : int):
	if not Boxes[selected_id].item_ready:
		return
	if game.selected_offered_killer != null:
		game.selected_offered_killer.deselect_button()
	if game.hover_over_simulation and game.selected_item_instance != null:
			game.selected_item_instance._on_stop_hover()
	for item_button in Boxes:
		if selected_id == item_button.button_id:
			game.selected_offered_killer = item_button
	game.selected_offered_killer.select_button()
	game.selected_item_instance = game.selected_offered_killer.killer_current_instance
	if game.hover_over_simulation and game.selected_item_instance != null:
		game.selected_item_instance._on_hover()
	SignalManager.item_selected.emit()

func display_text(new_text : String):
	if new_text == "":
		new_text = idle_string
	$InfoDisplay.text = new_text
