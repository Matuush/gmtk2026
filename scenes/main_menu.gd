extends Node2D

@export var volume_slider : Slider 

func _ready() -> void:
	_on_volume_slider_drag_ended(true)
	hide_settings()

func _on_new_game_button_button_down() -> void:
	SignalManager.change_game_state.emit(main.game_state.game)

func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	print("Changing to : ", volume_slider.value)
	SignalManager.volume_change.emit(volume_slider.value)

func hide_settings() -> void:
	$MenuButtons.visible = true
	$Dimrect.visible = false
	$BackButton.visible = false
	$Settings.visible = false

func show_settings() -> void:
	$MenuButtons.visible = false
	$Dimrect.visible = true
	$BackButton.visible = true
	$Settings.visible = true

func _on_settings_buton_button_down() -> void:
	show_settings()

func _on_back_button_button_down() -> void:
	hide_settings()


func _on_volume_try_button_down() -> void:
	AudioManager.play_purchase_sound()
