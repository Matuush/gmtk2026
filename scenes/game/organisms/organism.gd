@abstract class_name organism extends RigidBody2D

var window_size : Vector2 = DisplayServer.window_get_size()
var social_factor : float
var acceleration_factor : float = 1
var max_health : float
var multiplication_rate : float
var BORDER_DELTA : float = 10
var BORDER_SUSPENSION : float = 0.9

var sprite_texture : Texture2D

var color : float
var health : float

@abstract func die() -> void
	
@abstract func _init() -> void

func _ready() -> void:
	$Sprite2D.set_texture(sprite_texture)

@abstract func _process(delta: float) -> void
