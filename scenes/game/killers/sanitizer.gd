class_name sanitizer extends Area2D

static var sanitizer_size : float = 200.0

func _ready() -> void:
	$CollisionShape2D.shape.radius = sanitizer_size
	print("Made at ", position)


func _on_duration_timer_timeout() -> void:
	var parent = get_parent()
	parent.remove_child($".")
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	print("Body: ", body.position, "entered the sanitizer arr")
	var body_parent = body.get_parent()
	body_parent.remove_child(body)
	body.queue_free()
