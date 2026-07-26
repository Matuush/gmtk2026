class_name main extends Node2D

enum game_state {menu, game}
static var current_game_state : game_state

func _ready():
	SignalManager.change_game_state.connect(_on_game_state_change)

func _on_game_state_change(new_state : game_state):
	current_game_state = new_state
	if current_game_state == game_state.game:
		$MainMenu.visible = false
		$Game.visible = true
		$Game.start_game()
	if current_game_state == game_state.menu:
		$MainMenu.visible = true
		$Game.visible = false
