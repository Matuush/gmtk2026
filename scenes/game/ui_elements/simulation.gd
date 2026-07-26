class_name simulation extends Node2D

static var border_width : float = 32.0
static var center : Vector2 = Vector2(470,250)
static var radius : float = 200

const AMOEBA_LIMIT : int = 200
const INITIAL_AMOEBA_COUNT : int = 20

static var amoebas_murdered : int  

var my_time : float = 0.0
static var enemies : Array = []
static var killers : Array = []
static var vabnicky : Array = []
@export var amoeba_scene : PackedScene

func _ready() -> void:
	SignalManager.enemy_leave_scene.connect(delete_amoeba)

func delete_old_game() -> void:
	for enemy in enemies:
		remove_child(enemy)
		enemy.queue_free()
	enemies.clear()
	
	for k in killers:
		print("Freeing: ", k)
		remove_child(k)
		k.queue_free()
	killers.clear()
	
	for v in vabnicky:
		remove_child(v)
		v.queue_free()
	vabnicky.clear()
	

func new_game() -> void:
	amoebas_murdered = 0
	delete_old_game()
	for i in range(INITIAL_AMOEBA_COUNT):
		create_amoeba(get_random_spawn_location())
	SignalManager.enemy_count_changed.emit()

func get_random_spawn_location() -> Vector2:
	return center + Vector2.ONE.rotated(randf_range(0,2*PI))*randf_range(0, radius)

func _process(_delta: float) -> void:
	#print("no instance")
	if game.selected_item_instance == null:
		return
	if game.hover_over_simulation:
		#print("Hovering")
		game.selected_item_instance.global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("tower_place"):
			if game.selected_offered_killer == null:
				return
			if not game.selected_offered_killer.item_ready:
				return
			if game.selected_item_instance.cost > game.money:
				SignalManager.error_message.emit("Error: Not enough money!")
				return
			print("Using item")
			SignalManager.add_money.emit(- game.selected_item_instance.cost)
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

func delete_amoeba(amoeba_to_delete : amoeba):
	remove_child(amoeba_to_delete)
	var idx : int = enemies.find(amoeba_to_delete)
	enemies.remove_at(idx)
	amoeba_to_delete.queue_free()
	print("Removed amoeba")
	SignalManager.enemy_count_changed.emit()
