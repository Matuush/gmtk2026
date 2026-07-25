class_name shooter extends killer

@export var bullet_scene : PackedScene

var placed : bool
static var shoot_interval : float = 0.8

func _ready() -> void:
	placed = false
	$ShootTimer.wait_time = shoot_interval
	$PreviewSprite.visible = false
	$EffectSprite.visible = false

func _on_place() -> void:
	print("I am placing")
	placed = true
	$PreviewSprite.visible = false
	$EffectSprite.visible = true
	$ShootTimer.start()
	
func _on_hover() -> void:
	$PreviewSprite.visible = true
	
func _on_stop_hover() -> void:
	$PreviewSprite.visible = false

func select_direction_to_closest_organism() -> Vector2:
	print("Current coords: ", position)
	var direction : Vector2 = Vector2.ZERO
	var cur_least_dist : float = -1
	for enemy in simulation.enemies:
		var vect_dist : Vector2 = enemy.global_position - global_position
		if cur_least_dist == -1 or vect_dist.length() < cur_least_dist:
			direction = vect_dist
	return direction.normalized()
		

func _on_shoot_timer_timeout() -> void:
	print("Placing bullet")
	if not placed:
		return
	var new_bullet = bullet_scene.instantiate()
	var direction : Vector2 = select_direction_to_closest_organism()
	new_bullet.linear_velocity = 1000.0 * direction
	new_bullet.rotation = direction.angle()
	add_child(new_bullet)
	AudioManager.play_shoot_sound()
	


func on_upgrade_one() -> void:
	return 

func on_upgrade_two() -> void:
	return 

func get_upgrade_one_description(phase : int) -> String:
	return "Upgrade one description\ncost: 10"

func get_upgrade_two_description(phase : int) -> String:
	return "Upgrade two description\ncost: 10"

func get_item_cost(phase : int) -> int:
	return 10
