class_name shooter_bullet extends RigidBody2D

func leave_scene() -> void:
	var parent = get_parent()
	if parent != null:
		parent.call_deferred("remove_child", $".")
	queue_free()

func _on_body_entered(body: Node) -> void:
	print("Detected collision with!")
	if is_instance_of(body, killer) and not is_instance_of(body, wall):
		print("Some killer other than wall, returning")
		return
	elif is_instance_of(body, organism):
		body.die()
	leave_scene()


func _on_despawn_timer_timeout() -> void:
	leave_scene()
