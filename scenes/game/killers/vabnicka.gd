class_name vabnicka extends killer

var placed : bool

@export var vabnicka_strength : float = PI / 200
static var vabnicka_strength_coeff : float = 1.2

static var time_placed : float = 4.0
static var time_placed_coeff : float = 1.2

func _ready() -> void:
	update_timer()
	placed = false
	$PreviewSprite.visible = false
	$EffectSprite.visible = false

func _on_place() -> void:
	placed = true
	$DurationTimer.wait_time = time_placed
	$DurationTimer.start()
	$PreviewSprite.visible = false
	$EffectSprite.visible = true
	AudioManager.play_vabnicka_sound() # TODO
	get_parent().vabnicky.push_back($".")

func sladke_vabeni(delta : float) -> void:
	for enemy in simulation.enemies:
		var dif_vect = global_position - enemy.global_position
		var angle1 = dif_vect.angle()
		var angle2 = enemy.linear_velocity.angle()
		var sgn = 1
		if (angle2 >= angle1 and angle2 < angle1 + PI) or (angle2 < angle1 - PI && angle2 >= angle1 - 2*PI):
			sgn *= -1
		enemy.linear_velocity = enemy.linear_velocity.rotated(vabnicka_strength * sgn)

func _on_hover() -> void:
	$PreviewSprite.visible = true
	
func _on_stop_hover() -> void:
	$PreviewSprite.visible = false

func update_timer() -> void:
	$DurationTimer.wait_time = time_placed

func _on_duration_timer_timeout() -> void:
	var index = simulation.vabnicky.find($".")
	simulation.vabnicky.remove_at(index)
	queue_free()

func on_upgrade_one() -> void:
	vabnicka_strength *= vabnicka_strength_coeff

func on_upgrade_two() -> void:
	time_placed *= time_placed_coeff
	update_timer()

func get_upgrade_one_description(_phase : int) -> String:
	return "Increases the area of effect by 20%"

func get_upgrade_two_description(phase : int) -> String:
	return "Increases the length of the effect by 20%\nCost: " + str(get_item_cost(0))

func get_item_cost(phase : int) -> int:
	return 10
