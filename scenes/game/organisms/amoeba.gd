class_name amoeba extends RigidBody2D

var window_size : Vector2 = DisplayServer.window_get_size()
var social_factor : float
var acceleration_factor : float = 1
var max_health : float
var multiplication_rate : float
var BORDER_DELTA : float = 10
var BORDER_SUSPENSION : float = 0.9

var color : float
var health : float

func die() -> void:
	var index = game.enemies.find($".")
	game.enemies.remove_at(index)
	var parent_scene = get_parent()
	parent_scene.remove_child($".")
	queue_free()
	print("Index: ", index)
	pass
	
func _init() -> void:
	position.x = randf_range(0, window_size.x)
	position.y = randf_range(0, window_size.y)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	window_size = DisplayServer.window_get_size()
	
func _physics_process(delta: float) -> void:
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
