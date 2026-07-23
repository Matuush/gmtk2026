class_name amoeba extends organism

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
	pass
	
func _init() -> void:
	sprite_texture = preload("res://assets/game/organisms/bacteria.png")
	
	rotation = randf() * 2 * PI
	
	acceleration_factor = 1
	social_factor = 1
	max_health = 1
	multiplication_rate = 1
	can_sleep = false
	sleeping = false

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	generic_move(_delta)
	var min_dist = -1
	var min_dist_enemy = null
	for enemy in simulation.enemies:
		var dist = position.distance_to(enemy.position)
		if enemy != $"." and (min_dist == -1 or dist < min_dist):
			min_dist = dist
			min_dist_enemy = enemy
	if min_dist != -1:
		var vec = _delta * social_factor * acceleration_factor * (min_dist_enemy.position - position).normalized().rotated(PI/3)
		linear_velocity += vec
	move_and_collide(linear_velocity)
