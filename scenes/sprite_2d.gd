extends Sprite2D

const move_speed : float = 200.0
const gravity_speed : float = 50.0

func _process(_delta : float):
	if Input.is_action_pressed("ui_up"):
		position.y -= _delta * move_speed 
	else:
		position.y += _delta * gravity_speed
