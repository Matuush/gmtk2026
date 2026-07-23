class_name game extends Node2D

const killer_count : int = 4
static var level_killers : Array[killer_enums.names] = [killer_enums.names.sanitizer, killer_enums.names.wall, killer_enums.names.sanitizer, killer_enums.names.sanitizer]

static var selected_item_button : offered_item_button = null
static var selected_item_instance = null

static var hover_over_simulation : bool = false

func _ready():
	$KillerSelectionBox.make_items()
	SignalManager.item_selected.connect(_on_item_selected)

func _on_item_selected():
	print("Selected new item")
	$Simulation.add_child(selected_item_instance)

func _on_event_checker_mouse_entered() -> void:
	hover_over_simulation = true
	if selected_item_instance != null:
		selected_item_instance._on_hover()

func _on_event_checker_mouse_exited() -> void:
	hover_over_simulation = false
	if selected_item_instance != null:
		selected_item_instance._on_stop_hover()
