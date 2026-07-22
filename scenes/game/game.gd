extends Node2D

var my_time : float = 0.0
var enemies : Array = []
var window_size : Vector2 = DisplayServer.window_get_size()
@export var amoeba_scene : PackedScene

func _physics_process(delta: float) -> void:
	my_time += delta
	#print(my_time)
	var new_amoeba = amoeba_scene.instantiate()
	new_amoeba.position.x = randf_range(0, window_size.x)
	new_amoeba.position.y = randf_range(0, window_size.y)
	#new_amoeba.position.x = randf_range(0, 10)
	#new_amoeba.position.y = randf_range(0, 10)
	print(new_amoeba.position)
	add_child(new_amoeba)
	#
	#enemies.push_back(new_amoeba)
	
	#if my_time > 2.0:
		#remove_child($Game)
	#position.x += 100 * delta
	pass
