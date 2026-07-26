extends Node2D

func _on_new_game_button_button_down() -> void:
	SignalManager.change_game_state.emit(main.game_state.game)


func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	print("Changing to : ", $VolumeSlider.value)
	SignalManager.volume_change.emit($VolumeSlider.value)
