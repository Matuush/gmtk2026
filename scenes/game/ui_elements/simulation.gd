class_name simulation extends Node2D

static var area_size : Vector2 = Vector2(800.0, 480.0)
static var border_width : float = 32.0
static var center : Vector2 = Vector2(border_width + area_size.x/2, border_width + area_size.y/2)

const AMOEBA_LIMIT : int = 150
const INITIAL_AMOEBA_COUNT : int = 20

var my_time : float = 0.0
static var enemies : Array = []
static var killers : Array = []
static var vabnicky : Array = []
@export var amoeba_scene : PackedScene

func _ready() -> void:
	for i in range(INITIAL_AMOEBA_COUNT):
		create_amoeba(get_random_spawn_location())

func get_random_spawn_location() -> Vector2:
	return Vector2(
		randf_range(border_width, area_size.x - border_width),
		randf_range(border_width, area_size.y - border_width)
	)

func _process(delta: float) -> void:
	if game.selected_item_instance == null:
		return
	if game.hover_over_simulation:
		game.selected_item_instance.position = get_local_mouse_position()
		if Input.is_action_just_pressed("tower_place"):
			if game.selected_offered_killer == null:
				return
			if not game.selected_offered_killer.item_ready:
				return
			killers.push_back(game.selected_item_instance)
			game.selected_item_instance._on_place()
			SignalManager.item_used.emit()
			game.selected_item_instance = null

func _physics_process(delta: float) -> void:
	for vab in vabnicky:
		vab.sladke_vabeni(delta)

func create_amoeba(pos: Vector2) -> void:
	if enemies.size() < AMOEBA_LIMIT:
		var new_amoeba = amoeba_scene.instantiate()
		new_amoeba.position = pos
		
		enemies.push_back(new_amoeba)
		add_child(new_amoeba)
		SignalManager.enemy_count_changed.emit()
