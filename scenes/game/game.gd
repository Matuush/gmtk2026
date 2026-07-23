class_name game extends Node2D

var AMOEBA_LIMIT : int = 6

var my_time : float = 0.0
static var enemies : Array = []
static var killers : Array = []
var window_size : Vector2 = DisplayServer.window_get_size()
@export var amoeba_scene : PackedScene

static var selected_item_button : offered_item_button = null

var cursor_on_simulation : bool = false 

const killer_count : int = 4
static var level_killers : Array[killer_enums.names] = [killer_enums.names.sanitizer, killer_enums.names.wall, killer_enums.names.sanitizer, killer_enums.names.sanitizer]

func _ready():
	$KillerSelectionBox.make_items()

func _process(delta: float) -> void:
	pass

func get_random_spawn_location() -> Vector2:
	return Vector2(
		randf_range(0, $SpawnArea.size.x),
		randf_range(0, $SpawnArea.size.y)
	)

func _physics_process(delta: float) -> void:
	my_time += delta
	#print(my_time)
	#
	
	#if my_time > 2.0:
		#remove_child($Game)
	#position.x += 100 * delta
	pass
				   
func _on_spawn_timer_timeout() -> void:
	if enemies.size() < AMOEBA_LIMIT:
		var new_amoeba = amoeba_scene.instantiate()
		new_amoeba.position = get_random_spawn_location()
		
		enemies.push_back(new_amoeba)
		$SpawnArea.add_child(new_amoeba)

func _on_spawn_area_gui_input(event: InputEvent) -> void:
	#print("Got gui input")
	if event.is_action_pressed("tower_place"):
		if selected_item_button == null:
			return
		print("Trying to Make item")
		if not selected_item_button.item_ready:
			return
		print("Making item")
		selected_item_button.use_item()
		var killer_scene : PackedScene = killer_enums.scene_dictionary[selected_item_button.button_item]
		var new_killer = killer_scene.instantiate()
		new_killer.position = get_viewport().get_mouse_position()
		killers.push_back(new_killer)
		add_child(new_killer)
	pass # Replace with function body.
