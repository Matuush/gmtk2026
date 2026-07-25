class_name game extends Node2D

const killer_count : int = 4
static var level_killers : Array[killer_enums.names] = [killer_enums.names.sanitizer, killer_enums.names.wall, killer_enums.names.sanitizer, killer_enums.names.shooter]

static var selected_offered_killer : offered_killer = null
static var selected_item_instance = null

static var hover_over_simulation : bool = false

const STARTING_CASH = 20
static var money : int = 0

@export var killer_box : killer_selection_box

func _ready():
	$KillerSelectionBox.make_items()
	SignalManager.item_selected.connect(_on_item_selected)
	SignalManager.enemy_count_changed.connect(_on_enemy_count_change)
	SignalManager.enemy_count_changed.emit()
	SignalManager.add_money.connect(_on_add_money)
	SignalManager.add_money.emit(STARTING_CASH)
	SignalManager.error_message.connect(_on_error_message)

func _process(_delta : float) -> void:
	if Input.is_action_just_pressed("select_item_1"):
		$KillerSelectionBox.select_button(0)
	if Input.is_action_just_pressed("select_item_2"):
		$KillerSelectionBox.select_button(1)
	if Input.is_action_just_pressed("select_item_3"):
		$KillerSelectionBox.select_button(2)
	if Input.is_action_just_pressed("select_item_4"):
		$KillerSelectionBox.select_button(3)

func _on_item_selected():
	print("Selected new item")
	add_child(selected_item_instance)

func _on_event_checker_mouse_entered() -> void:
	hover_over_simulation = true
	if selected_item_instance != null:
		selected_item_instance._on_hover()

func _on_event_checker_mouse_exited() -> void:
	hover_over_simulation = false
	if selected_item_instance != null:
		selected_item_instance._on_stop_hover()

func _on_enemy_count_change() -> void:
	$HUDBox/EnemyCountLabel.text = " %d" % simulation.enemies.size()

func _on_add_money(added_money : int) -> void:
	game.money += added_money
	$HUDBox/MoneyLabel.text = "%d " % money

func _on_error_message(message : String):
	$HUDBox/ErrorMessageLabel.visible = true
	$HUDBox/ErrorMessageLabel.text = message
	$ErrorMessageTimer.start()


func _on_error_message_timer_timeout() -> void:
	$HUDBox/ErrorMessageLabel.visible = false
