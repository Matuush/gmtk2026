class_name wall extends killer

var placed : bool
var hovering : bool

const rotation_velocity : float = 10.0
static var thickness : float = 20
static var length : float = 100

func on_new_game() -> void:
	pass

static var thickness_upgrade_factor : float = 1.2
static var length_upgrade_factor : float = 1.2


func set_shape():
	$DisplayRect.size = Vector2(length, thickness)   # width, height	
	var rect_shape : RectangleShape2D = RectangleShape2D.new()
	rect_shape.size = $DisplayRect.size
	$CollisionShape2D.shape = rect_shape

func _process(delta: float) -> void:
	if not hovering:
		return
	if Input.is_action_just_released("tower_rotate_left"):
		rotation -= delta * rotation_velocity
	if Input.is_action_just_released("tower_rotate_right"):
		rotation += delta * rotation_velocity

func _on_place() -> void:
	print("I am placing")
	placed = true
	$DisplayRect.visible = true
	$DisplayRect.color = Color(0,0,0)
	AudioManager.play_industrial_build_sound()
	hovering = false
	set_shape()
	
func _on_hover() -> void:
	$DisplayRect.visible = true
	$DisplayRect.color = Color(1,0,0)
	hovering = true
	
func _on_stop_hover() -> void:
	$DisplayRect.visible = false
	hovering = false

func _ready() -> void:
	$DisplayRect.global_position = global_position - Vector2(length/2, thickness/2)
	set_shape()
	placed = false
	$DisplayRect.visible = false

func on_upgrade_one() -> void:
	length *= length_upgrade_factor
	set_shape()

func on_upgrade_two() -> void:
	thickness *= thickness_upgrade_factor
	set_shape()

func get_upgrade_one_description(phase : int) -> String:
	return "[b]So much wider![/b]\nIncreases the width of the wall by 20%%\nCost: %d" % upgrade_one_costs[phase]

func get_upgrade_two_description(phase : int) -> String:
	return "[b]So much thicker![/b]\nIncreases the thickness of the wall by 20%%\nCost: %d" % upgrade_two_costs[phase]
