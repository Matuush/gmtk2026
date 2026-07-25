class_name offered_killer extends Control

@export var item_selected_color : Color
@export var item_not_selected_color : Color

@export var button_id : int

@export var item_selected_indicator : ColorRect
@export var cooldown_bar : ColorRect
@export var offered_item_icon : TextureRect


var killer_enum_name : killer_enums.names
var killer_scene
var killer_current_instance : killer = null
var item_ready : bool

const max_upgrades : int = 3
var upgrade_progresses : Array[int] = [0,0]

@export var upgrade_displays : Array[upgrade_display]

func _ready() -> void:
	SignalManager.item_used.connect(_on_use_item)

func _physics_process(delta: float) -> void:
	if item_ready:
		return
	var s : float = $CooldownTimer.time_left / $CooldownTimer.wait_time
	cooldown_bar.scale.y = s

func set_item(new_item : killer_enums.names):
	killer_enum_name = new_item
	killer_scene = killer_enums.scene_dictionary[new_item]
	killer_current_instance = killer_scene.instantiate()
	
	upgrade_displays[0].set_upgrade_icon(killer_current_instance.upgrade_texture_one)
	upgrade_displays[1].set_upgrade_icon(killer_current_instance.upgrade_texture_two)
	offered_item_icon.texture = killer_current_instance.icon
	
	deselect_button()
	cooldown_bar.visible = false
	item_ready = true
	$CooldownTimer.wait_time = killer_enums.cooldown_dictionary[new_item]
	var _s = "" % []

func select_button():
	item_selected_indicator.color = item_selected_color

func deselect_button():
	item_selected_indicator.color = item_not_selected_color

func _on_use_item():
	if game.selected_item_instance == killer_current_instance:
		use_item()

func use_item():
	$CooldownTimer.start()
	item_ready = false
	cooldown_bar.visible = true
	cooldown_bar.scale.y = 1.0
	killer_current_instance = killer_scene.instantiate()
	game.selected_item_instance = killer_current_instance
	deselect_button()


func _on_cooldown_timer_timeout() -> void:
	item_ready = true
	cooldown_bar.visible = false

func _on_item_use_button_button_down() -> void:
	SignalManager.box_selection.emit(button_id)

func _on_upgrade_display_1_upgrade_button_press() -> void:
	try_buy_upgrade(0)

func _on_upgrade_display_2_upgrade_button_press() -> void:
	try_buy_upgrade(1)

func try_buy_upgrade(upgrade_id : int) -> void:
	var upgrade_index = upgrade_progresses[upgrade_id]
	if upgrade_index >= max_upgrades:
		return
	if false:
		return
	upgrade_progresses[upgrade_id] += 1
	#TODO cost
	if upgrade_id == 0:
		killer_current_instance.on_upgrade_one()
	elif upgrade_id == 1:
		killer_current_instance.on_upgrade_two()
	if upgrade_progresses[upgrade_id] == max_upgrades:
		upgrade_displays[upgrade_id].indicate_looksmaxxing()
	upgrade_displays[upgrade_id].indicate_upgrade(upgrade_index)
	print("Bought")


func _on_item_use_button_mouse_entered() -> void:
	var desc : String = killer_enums.description_dictionary[killer_enum_name]
	SignalManager.purchase_text.emit(desc)

func _on_upgrade_display_1_upgrade_button_hover() -> void:
	print("Hovering")
	var to_display : String
	if upgrade_progresses[0] == max_upgrades:
		to_display = "Already max level"
	else:
		to_display = killer_current_instance.get_upgrade_one_description(upgrade_progresses[0])
	SignalManager.purchase_text.emit(to_display)


func _on_upgrade_display_2_upgrade_button_hover() -> void:
	var to_display : String
	if upgrade_progresses[1] == max_upgrades:
		to_display = "Already max level"
	else:
		to_display = killer_current_instance.get_upgrade_two_description(upgrade_progresses[1])
	SignalManager.purchase_text.emit(to_display)


func _on_anything_stop_hover() -> void:
	SignalManager.purchase_text.emit("epic support text")
	
func is_item_ready() -> bool:
	print($ItemUseButton/CooldownBar.scale.y)
	return ($ItemUseButton/CooldownBar.scale.y == 0.0)
