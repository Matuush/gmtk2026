class_name wall extends killer

var placed : bool
var hovering : bool

const rotation_velocity : float = 10.0
#static var time_placed : float = 10.0

func set_collision_shape():
	var rect_shape : RectangleShape2D = RectangleShape2D.new()
	rect_shape.size = $EffectSprite.size
	$CollisionShape2D.shape = rect_shape

func _process(delta: float) -> void:
	if not hovering:
		return
	print("In process")
	if Input.is_action_just_released("tower_rotate_left"):
		print("Left")
		rotation -= delta * rotation_velocity
	if Input.is_action_just_released("tower_rotate_right"):
		print("right")
		rotation += delta * rotation_velocity

func _on_place() -> void:
	print("I am placing")
	placed = true
	$PreviewSprite.visible = false
	$EffectSprite.visible = true
	AudioManager.play_wall_sound()
	hovering = false
	set_collision_shape()
	
func _on_hover() -> void:
	$PreviewSprite.visible = true
	hovering = true
	
func _on_stop_hover() -> void:
	$PreviewSprite.visible = false
	hovering = false

func _ready() -> void:
	print("Ready")
	placed = false
	$PreviewSprite.visible = false
	$EffectSprite.visible = false
