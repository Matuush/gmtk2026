@abstract class_name organism extends RigidBody2D

var acceleration_factor : float
var scare_factor : float
var max_health : float
var multiplication_rate : float

var sprite_texture : Texture2D

var color : float
var health : float

@abstract func die() -> void
	
@abstract func _init() -> void

func _ready() -> void:
	$Sprite2D.set_texture(sprite_texture)

@abstract func _process(delta: float) -> void
