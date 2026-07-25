class_name sanitizer extends killer

static var sanitizer_size : float = 100.0
static var sanitizer_size_coeff : float = 1.2

static var cooldown : float = 1.0
var placed : bool
static var time_placed : float = 1.0
static var time_placed_coeff : float = 1.2

func _ready() -> void:
	print("Ready")
	update_sizes()
	placed = false
	$AreaEffect/PreviewSprite.visible = false
	$AreaEffect/EffectSprite.visible = false
	$DurationTimer.wait_time = time_placed

func set_collision_shape():
	var circ_shape : CircleShape2D = CircleShape2D.new()
	circ_shape.radius = sanitizer_size
	$AreaEffect/CollisionShape2D.shape = circ_shape

func _process(delta: float) -> void:
	pass

func _on_place() -> void:
	print("I am placing")
	placed = true
	$DurationTimer.wait_time = time_placed
	$DurationTimer.start()
	$AreaEffect/PreviewSprite.visible = false
	$AreaEffect/EffectSprite.visible = true
	AudioManager.play_sanitizer_sound()
	set_collision_shape()
	
func _on_hover() -> void:
	$AreaEffect/PreviewSprite.visible = true
	
func _on_stop_hover() -> void:
	$AreaEffect/PreviewSprite.visible = false

func update_sizes() -> void:
	#$AreaEffect/CollisionShape2D.shape.radius = sanitizer_size
	var effect_coeff : float = sanitizer_size / ($AreaEffect/EffectSprite.texture.get_width() / 2)
	var preview_coeff : float = sanitizer_size / ($AreaEffect/PreviewSprite.texture.get_width() / 2)
	$AreaEffect/EffectSprite.scale = effect_coeff * Vector2.ONE
	$AreaEffect/PreviewSprite.scale = preview_coeff * Vector2.ONE


func _on_duration_timer_timeout() -> void:
	print("Timeout\n")
	queue_free()

func _on_area_effect_body_entered(body: Node2D) -> void:
	print("Detecting col")
	if not placed:
		return
	print("Body: ", body.position, "entered the sanitizer arr")
	if is_instance_of(body, organism):
		body.die()
		

func on_upgrade_one() -> void:
	sanitizer_size *= sanitizer_size_coeff

func on_upgrade_two() -> void:
	time_placed *= time_placed_coeff

func get_upgrade_one_description(_phase : int) -> String:
	return "Increases the area of effect by 20%"

func get_upgrade_two_description(phase : int) -> String:
	return "Increases the length of the effect by 20%\nCost: " + str(get_item_cost(0))

func get_item_cost(phase : int) -> int:
	return 10
