class_name shooter_bullet extends RigidBody2D

func leave_scene() -> void:
	var parent = get_parent()
	if parent != null:
		parent.call_deferred("remove_child", $".")
	queue_free()

func _on_body_entered(body: Node) -> void:
	if is_instance_of(body, killer):
		return
	elif is_instance_of(body, organism):
		body.die()
	elif is_instance_of(body, shooter_bullet ):
		pass
	else:
		pass
	leave_scene()


func _on_despawn_timer_timeout() -> void:
	leave_scene()
