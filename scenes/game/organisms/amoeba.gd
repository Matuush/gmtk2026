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
	#position.x = randf_range(0, window_size.x)
	#position.y = randf_range(0, window_size.y)

func _process(_delta: float) -> void:
	window_size = DisplayServer.window_get_size()
	
func _physics_process(_delta: float) -> void:
	linear_velocity += Vector2(
		randf_range(-acceleration_factor, acceleration_factor),
		randf_range(-acceleration_factor, acceleration_factor)
	)
	move_and_collide(linear_velocity)
	if position.x > window_size.x:
		linear_velocity.x *= -BORDER_SUSPENSION
		position.x = window_size.x - BORDER_DELTA
	if position.x < 0:
		linear_velocity.x *= -BORDER_SUSPENSION
		position.x = BORDER_DELTA
	if position.y > window_size.y:
		linear_velocity.y *= -BORDER_SUSPENSION
		position.y = window_size.y - BORDER_DELTA
	if position.y < 0:
		linear_velocity.y *= -BORDER_SUSPENSION
		position.y = BORDER_DELTA
