class_name upgrade_display extends HBoxContainer

static var empty_indicator_texture : Texture2D = preload("res://assets/game/ui/empty_orb.png")
static var full_indicator_texture : Texture2D = preload("res://assets/game/ui/full_orb.png")

@export var upgrade_icon : Texture2D
static var maxxed_icon : Texture2D = preload("res://assets/game/killers/bought_icon.png")

var indicators : Array[TextureRect]
signal upgrade_button_press
signal upgrade_button_hover
signal upgrade_button_stop_hover

var is_maxxed : bool = false

func new_game() -> void:
	for i in indicators:
		i.texture = empty_indicator_texture
	disindicate_looksmaxxing()

func _ready() -> void:
	indicators = [$BuyIndicator1, $BuyIndicator2, $BuyIndicator3]
	SignalManager.on_new_game.connect(new_game)
	disindicate_looksmaxxing()

func set_upgrade_icon(new_icon : Texture2D):
	upgrade_icon = new_icon
	$BuyButton/UpgradeIcon.texture = new_icon

func indicate_upgrade(indicator_id : int):
	indicators[indicator_id].texture = full_indicator_texture
	AudioManager.play_purchase_sound()

func disindicate_looksmaxxing():
	$BuyButton/UpgradeIcon.texture = upgrade_icon
	$BuyButton.disabled = false
	is_maxxed = true

func indicate_looksmaxxing():
	$BuyButton/UpgradeIcon.texture = maxxed_icon
	$BuyButton.disabled = true
	is_maxxed = true
	_on_buy_button_mouse_entered()

func _on_buy_button_button_down() -> void:
	upgrade_button_press.emit()
	_on_buy_button_mouse_entered()

func _on_buy_button_mouse_entered() -> void:
	upgrade_button_hover.emit()

func _on_buy_button_mouse_exited() -> void:
	upgrade_button_stop_hover.emit()
