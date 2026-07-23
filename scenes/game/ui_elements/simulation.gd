class_name simulation extends Node2D

static var area_size : Vector2 = Vector2(800.0, 480.0)
static var border_width : float = 32.0

const AMOEBA_LIMIT : int = 6

var my_time : float = 0.0
static var enemies : Array = []
static var killers : Array = []
@export var amoeba_scene : PackedScene

var cursor_on_simulation : bool = false 

func get_random_spawn_location() -> Vector2:
	return Vector2(
		randf_range(border_width, area_size.x - border_width),
		randf_range(border_width, area_size.y - border_width)
	)

func _physics_process(delta: float) -> void:
	my_time += delta
	pass
				   
func _on_spawn_timer_timeout() -> void:
	if enemies.size() < AMOEBA_LIMIT:
		var new_amoeba = amoeba_scene.instantiate()
		new_amoeba.position = get_random_spawn_location()
		
		enemies.push_back(new_amoeba)
		add_child(new_amoeba)

func _on_background_gui_input(event: InputEvent) -> void:	#print("Got gui input")
	if event.is_action_pressed("tower_place"):
		if game.selected_item_button == null:
			return
		print("Trying to Make item")
		if not game.selected_item_button.item_ready:
			return
		print("Making item")
		game.selected_item_button.use_item()
		var killer_scene : PackedScene = killer_enums.scene_dictionary[game.selected_item_button.button_item]
		var new_killer = killer_scene.instantiate()
		
		new_killer.position = get_local_mouse_position()
		killers.push_back(new_killer)
		add_child(new_killer)
