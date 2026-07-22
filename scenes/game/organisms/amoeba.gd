class_name amoeba extends RigidBody2D

var VELOCITY_CHANGE_LIMIT : float = .5

func _ready() -> void:
	print("have been made")

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	linear_velocity += Vector2(
		randf_range(-VELOCITY_CHANGE_LIMIT, VELOCITY_CHANGE_LIMIT),
		randf_range(-VELOCITY_CHANGE_LIMIT, VELOCITY_CHANGE_LIMIT)
	)
	move_and_collide(linear_velocity)
	
