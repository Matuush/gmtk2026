class_name game extends Node2D

const killer_count : int = 4
static var level_killers : Array[killer_enums.names] = [killer_enums.names.sanitizer, killer_enums.names.wall, killer_enums.names.sanitizer, killer_enums.names.shooter]

static var selected_item_button : offered_item_button = null
static var selected_item_instance = null

static var hover_over_simulation : bool = false

func _ready():
	$KillerSelectionBox.make_items()
	SignalManager.item_selected.connect(_on_item_selected)
	SignalManager.enemy_count_changed.connect(_on_enemy_count_change)

func _process(_delta : float) -> void:
	if Input.is_action_just_pressed("select_item_1"):
		$KillerSelectionBox.select_button(1)
	if Input.is_action_just_pressed("select_item_2"):
		$KillerSelectionBox.select_button(2)
	if Input.is_action_just_pressed("select_item_3"):
		$KillerSelectionBox.select_button(3)
	if Input.is_action_just_pressed("select_item_4"):
		$KillerSelectionBox.select_button(4)

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

func _on_enemy_count_change() -> void:
	$EnemyCountLabel.text = "Enemy count: %d" % simulation.enemies.size()
