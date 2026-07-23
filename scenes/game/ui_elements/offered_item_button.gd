class_name offered_item_button extends Control

@export var item_selected_color : Color
@export var item_not_selected_color : Color

@export var button_id : int

var button_item : killer_enums.names
var item_ready : bool

func _physics_process(delta: float) -> void:
	if item_ready:
		return
	var s : float = $CooldownTimer.time_left / $CooldownTimer.wait_time
	print("Left: ", $CooldownTimer.time_left, "Total: ", $CooldownTimer.wait_time)
	print("Current scale: ", s)
	$CooldownBar.scale.y = s

func set_item(new_item : killer_enums.names):
	button_item = new_item
	deselect_button()
	$CooldownBar.visible = false
	item_ready = true
	$Icon.texture = killer_enums.icon_dictionary[new_item]
	$CooldownTimer.wait_time = killer_enums.cooldown_dictionary[new_item]
	print("Set timeout to: ", $CooldownTimer.wait_time)

#func switch_theme(new_theme : StyleBox):
	#$Button.add_theme_stylebox_override("normal", new_theme)
	#$Button.add_theme_stylebox_override("hover", new_theme)
	#$Button.add_theme_stylebox_override("pressed", new_theme)
	#$Button.add_theme_stylebox_override("hover_pressed", new_theme)
#
func select_button():
	$ButtonSelectedTheme.color = item_selected_color

func deselect_button():
	$ButtonSelectedTheme.color = item_not_selected_color

func use_item():
	$CooldownTimer.start()
	item_ready = false
	$CooldownBar.visible = true
	$CooldownBar.scale.y = 1.0

func _on_button_button_down() -> void:
	var box : killer_selection_box = get_parent()
	box.select_button(button_id)

func _on_cooldown_timer_timeout() -> void:
	item_ready = true
	$CooldownBar.visible = false
