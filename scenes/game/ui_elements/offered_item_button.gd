class_name offered_item_button extends Control

@export var item_selected_color : Color
@export var item_not_selected_color : Color

@export var button_id : int

var killer_enum_name : killer_enums.names
var killer_scene
var killer_current_instance = null
var item_ready : bool

func _ready() -> void:
	SignalManager.item_used.connect(_on_use_item)

func _physics_process(delta: float) -> void:
	if item_ready:
		return
	var s : float = $CooldownTimer.time_left / $CooldownTimer.wait_time
	#print("Left: ", $CooldownTimer.time_left, "Total: ", $CooldownTimer.wait_time)
	#print("Current scale: ", s)
	$CooldownBar.scale.y = s

func set_item(new_item : killer_enums.names):
	killer_enum_name = new_item
	killer_scene = killer_enums.scene_dictionary[new_item]
	killer_current_instance = killer_scene.instantiate()
	
	deselect_button()
	$CooldownBar.visible = false
	item_ready = true
	$Icon.texture = killer_enums.icon_dictionary[new_item]
	$CooldownTimer.wait_time = killer_enums.cooldown_dictionary[new_item]
	print("Set timeout to: ", $CooldownTimer.wait_time)

func select_button():
	$ButtonSelectedTheme.color = item_selected_color

func deselect_button():
	$ButtonSelectedTheme.color = item_not_selected_color

func _on_use_item():
	if game.selected_item_instance == killer_current_instance:
		use_item()

func use_item():
	$CooldownTimer.start()
	item_ready = false
	$CooldownBar.visible = true
	$CooldownBar.scale.y = 1.0
	killer_current_instance = killer_scene.instantiate()
	game.selected_item_instance = killer_current_instance
	deselect_button()

func _on_button_button_down() -> void:
	var box : killer_selection_box = get_parent()
	box.select_button(button_id)

func _on_cooldown_timer_timeout() -> void:
	item_ready = true
	$CooldownBar.visible = false
