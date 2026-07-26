class_name game extends Node2D

const killer_count : int = 4
static var level_killers : Array[killer_enums.names] = [killer_enums.names.sanitizer, killer_enums.names.wall, killer_enums.names.vabnicka, killer_enums.names.shooter]

static var selected_offered_killer : offered_killer = null
static var selected_item_instance = null

static var hover_over_simulation : bool = false

const STARTING_CASH = 20
static var money : int = 5000

static var game_over_reason : String

@export var killer_box : killer_selection_box

func _ready():
	SignalManager.item_selected.connect(_on_item_selected)
	SignalManager.add_money.connect(_on_add_money)
	SignalManager.error_message.connect(_on_error_message)
	SignalManager.enemy_count_changed.connect(_on_enemy_count_change)
	hide_game_over_screen()
	
func start_game() -> void:
	SignalManager.add_money.emit(STARTING_CASH - money)
	$Simulation.new_game()
	_on_enemy_count_change()
	hide_game_over_screen()
	$KillerSelectionBox.make_items()
	SignalManager.on_new_game.emit()

func game_over() -> void:
	show_game_over_screen()
	$EndScreen/GUI/GameOverReasonLabel.text = game_over_reason
	var murder_count : int = simulation.amoebas_murdered
	$EndScreen/GUI/StatsLabel.text = "You murdered %d amoebas" % murder_count
	
func hide_game_over_screen() -> void:
	$EndScreen.visible = false
	
func show_game_over_screen() -> void:
	$EndScreen.visible = true

func check_hover() -> void:
	var cur_hover_over_simulation : bool
	var center : Vector2 = $Simulation/Sprite2D.global_position
	var radius : float = ($Simulation/Sprite2D.texture.get_width() / 2) * $Simulation/Sprite2D.scale.x
	var vect_from_center : Vector2 = center - get_global_mouse_position()
	var dist : float = vect_from_center.length()
	cur_hover_over_simulation = (dist <= radius)
	#print(str(cur_hover_over_simulation) + str(vect_from_center) + str(dist))
	var diff : bool = hover_over_simulation != cur_hover_over_simulation
	hover_over_simulation = cur_hover_over_simulation
	
	if diff:
		if cur_hover_over_simulation:
			if selected_item_instance != null:
				selected_item_instance._on_hover()
		else:
			if selected_item_instance != null:
				selected_item_instance._on_stop_hover()

func _process(_delta : float) -> void:
	check_hover()
	
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

func _on_enemy_count_change() -> void:
	var new_enemy_count : int = simulation.enemies.size()
	$HUDBox/EnemyCountLabel.text = " %d" % new_enemy_count
	if new_enemy_count == 0:
		game_over_reason = "All your shit dried"
		game_over()
	elif new_enemy_count == simulation.AMOEBA_LIMIT:
		game_over_reason = "They bred too much"
		game_over()

func _on_add_money(added_money : int) -> void:
	game.money += added_money
	$HUDBox/MoneyLabel.text = "%d " % money

func _on_error_message(message : String):
	$HUDBox/ErrorMessageLabel.visible = true
	$HUDBox/ErrorMessageLabel.text = message
	$ErrorMessageTimer.start()

const error_no_money : String = "Not enough money!"

func _on_error_message_timer_timeout() -> void:
	$HUDBox/ErrorMessageLabel.visible = false

func _on_retry_button_button_down() -> void:
	start_game()
	SignalManager.on_new_game.emit()

func _on_menu_button_button_down() -> void:
	$Simulation.delete_old_game()
	SignalManager.change_game_state.emit(main.game_state.menu)
