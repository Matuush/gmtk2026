class_name shooter_bullet extends RigidBody2D

func leave_scene() -> void:
	var parent = get_parent()
	if parent != null:
		parent.call_deferred("remove_child", $".")
	queue_free()

func _on_body_entered(body: Node) -> void:
	print("Detected collision with!")
	if is_instance_of(body, killer):
		print("Killer, returnigng")
		return
	elif is_instance_of(body, organism):
		print("organism, returnigng")
		body.die()
	elif is_instance_of(body, shooter_bullet ):
		print("Bullet")
	else:
		print("Secret 3rd thing")


func _on_despawn_timer_timeout() -> void:
	leave_scene()
