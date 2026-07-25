class_name amoeba extends organism

var mate = null

enum amoeba_state {pairing, waiting}
var state : amoeba_state
const WAITING_TIME : float = 2
const BIRTH_TIME : float = 1
const PAIRING_DISTANCE : float = 30
const DIE_REWARD : int = 1

func die() -> void:
	var index = simulation.enemies.find($".")
	simulation.enemies.remove_at(index)
	SignalManager.enemy_count_changed.emit()
	var parent_scene = get_parent()
	if parent_scene != null:
		parent_scene.remove_child($".")
	queue_free()
	print("Index: ", index)
	AudioManager.play_bacteria_death_sound()
	SignalManager.add_money.emit(DIE_REWARD)
	
func _init() -> void:
	sprite_texture = preload("res://assets/game/organisms/bacteria.png")
	
	rotation = randf() * 2 * PI
	
	acceleration_factor = 1
	max_health = 1
	multiplication_rate = 1
	can_sleep = false
	sleeping = false
	state = amoeba_state.waiting

func _ready() -> void:
	do_after_time(WAITING_TIME, get_horny)

func do_after_time(time: float, fn) -> void:
	var timer = Timer.new()
	timer.wait_time = time
	timer.one_shot = true
	timer.autostart = true
	timer.timeout.connect(fn)
	add_child(timer)
	timer.start()

func get_horny() -> void:
	state = amoeba_state.pairing

func _process(_delta: float) -> void:
	pass

func get_closest_enemy():
	var min_dist = -1
	var min_dist_enemy = null
	for enemy in simulation.enemies:
		var dist = position.distance_to(enemy.position)
		if enemy != $"." and (min_dist == -1 or dist < min_dist):
			min_dist = dist
			min_dist_enemy = enemy
	return min_dist_enemy

func acceleration_towards_point(point : Vector2, delta : float) -> Vector2:
	return delta * acceleration_factor * (point - position).normalized()

func run_from_closest(delta: float) -> void:
	var closest_enemy = get_closest_enemy()
	if closest_enemy != null:
		linear_velocity += 2 * acceleration_towards_point(closest_enemy.position, delta).rotated(randf_range(PI-1, PI+1))

func pair_with_someone(delta: float) -> void:
	var closest_enemy = get_closest_enemy()
	if closest_enemy != null:
		linear_velocity += acceleration_towards_point(closest_enemy.position, delta)
		if (closest_enemy.position - position).length() <= PAIRING_DISTANCE:
			do_after_time(BIRTH_TIME, multiply)
			state = amoeba_state.waiting
			do_after_time(WAITING_TIME, get_horny)

func multiply() -> void:
	get_parent().create_amoeba(position)

func _physics_process(_delta: float) -> void:
	generic_move(_delta)
	if state == amoeba_state.pairing:
		pair_with_someone(_delta)
	elif state == amoeba_state.waiting:
		run_from_closest(_delta)
	move_and_collide(linear_velocity)
	rotation = linear_velocity.rotated(PI/2).angle()
