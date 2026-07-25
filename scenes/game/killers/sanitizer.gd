class_name sanitizer extends killer

var placed : bool

static var sanitizer_size : float = 100.0
static var sanitizer_size_coeff : float = 1.2

static var time_placed : float = 1.0
static var time_placed_addition : float = 0.25

@export var effect_sprite : Sprite2D
@export var preview_sprite : Sprite2D

func _ready() -> void:
	update_sizes()
	update_timer()
	placed = false
	preview_sprite.visible = false
	effect_sprite.visible = false

func set_collision_shape():
	var circ_shape : CircleShape2D = CircleShape2D.new()
	circ_shape.radius = sanitizer_size
	$AreaEffect/CollisionShape2D.shape = circ_shape

func _on_place() -> void:
	placed = true
	$DurationTimer.wait_time = time_placed
	$DurationTimer.start()
	preview_sprite.visible = false
	effect_sprite.visible = true
	AudioManager.play_sanitizer_sound()
	set_collision_shape()
	
func _on_hover() -> void:
	preview_sprite.visible = true
	
func _on_stop_hover() -> void:
	preview_sprite.visible = false

func update_sizes() -> void:
	$AreaEffect/CollisionShape2D.shape.radius = sanitizer_size
	var effect_coeff : float = sanitizer_size / (effect_sprite.texture.get_width() / 2)
	var preview_coeff : float = sanitizer_size / (preview_sprite.texture.get_width() / 2)
	effect_sprite.scale = effect_coeff * Vector2.ONE
	preview_sprite.scale = preview_coeff * Vector2.ONE

func update_timer() -> void:
	$DurationTimer.wait_time = time_placed

func _on_duration_timer_timeout() -> void:
	queue_free()

func _on_area_effect_body_entered(body: Node2D) -> void:
	if not placed:
		return
	if is_instance_of(body, organism):
		body.die()
		

func on_upgrade_one() -> void:
	sanitizer_size *= sanitizer_size_coeff
	update_sizes()

func on_upgrade_two() -> void:
	time_placed += time_placed_addition
	update_timer()

func get_upgrade_one_description(phase : int) -> String:
	return "[b]Range upgrade![/b]\nIncreases the area of effect by 20%%!\nCost: %d" % upgrade_one_costs[phase]

func get_upgrade_two_description(phase : int) -> String:
	return "[b]Time upgrade![/b]\nThe effect lasts 0.25 seconds more\nCost: %d" % upgrade_two_costs[phase]
