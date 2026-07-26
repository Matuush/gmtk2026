class_name shooter extends killer

@export var bullet_scene : PackedScene

var placed : bool

static var shoot_interval : float = 0.8
const shoot_interval_coeff : float = 0.8

static var number_of_bullets : int = 1
const number_of_bullets_addtition : int = 1

const bullet_speed : float = 1000.0

var bullets_left_in_chamber : int

signal shoot_interval_update

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
	AudioManager.play_industrial_build_sound()
	
func _on_hover() -> void:
	$PreviewSprite.visible = true
	
func _on_stop_hover() -> void:
	$PreviewSprite.visible = false

func select_direction_to_closest_organism() -> Vector2:
	print("Current coords: ", position)
	var direction : Vector2 = Vector2.ZERO
	var cur_least_dist : float = 1000000.0
	for enemy in simulation.enemies:
		var vect_dist : Vector2 = enemy.global_position - global_position
		if vect_dist.length() < cur_least_dist:
			cur_least_dist = vect_dist.length()
			direction = vect_dist
	return direction.normalized()

func shoot_bullet() -> void:
	if not placed:
		return
	if simulation.enemies.size() == 0:
		return
	print("Placing bullet")
	var new_bullet = bullet_scene.instantiate()
	var direction : Vector2 = select_direction_to_closest_organism()
	new_bullet.linear_velocity = bullet_speed * direction
	new_bullet.rotation = direction.angle()
	add_child(new_bullet)
	AudioManager.play_shoot_sound()

func _on_shoot_timer_timeout() -> void:
	shoot_bullet()
	bullets_left_in_chamber = number_of_bullets - 1
	print("Bullets: ", (number_of_bullets - 1))
	if bullets_left_in_chamber > 0:
		$RoundShootTimer.start()

func on_upgrade_one() -> void:
	shoot_interval *= shoot_interval_coeff
	shoot_interval_update.emit()

func _on_shoot_interval_update() -> void:
	$ShootTimer.wait_time = shoot_interval

func on_upgrade_two() -> void:
	number_of_bullets += number_of_bullets_addtition

func get_upgrade_one_description(phase : int) -> String:
	return "[b]Hasty as hell![/b]\nThe thingamajig shoots faster now!\ncost: %d" % upgrade_one_costs[phase]

func get_upgrade_two_description(phase : int) -> String:
	return "[b]I will be so famas![/b]\nShoots more bullets now\ncost: %d" % upgrade_two_costs[phase]


func _on_round_shoot_timer_timeout() -> void:
	shoot_bullet()
	bullets_left_in_chamber -= 1
	if bullets_left_in_chamber > 0:
		$RoundShootTimer.start()
