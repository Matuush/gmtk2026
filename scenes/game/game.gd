extends Node2D

var AMOEBA_LIMIT : int = 20

var my_time : float = 0.0
var enemies : Array = []
var window_size : Vector2 = DisplayServer.window_get_size()
@export var amoeba_scene : PackedScene

func _physics_process(delta: float) -> void:
	my_time += delta
	#print(my_time)
	#
	
	#if my_time > 2.0:
		#remove_child($Game)
	#position.x += 100 * delta
	pass


func _on_spawn_timer_timeout() -> void:
	if enemies.size() < AMOEBA_LIMIT:
		var new_amoeba = amoeba_scene.instantiate()
		
		enemies.push_back(new_amoeba)
		#print(new_amoeba.position)
		add_child(new_amoeba)
