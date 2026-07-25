@abstract class_name killer extends Node2D

var is_hovering : bool

@export var icon : Texture2D
@export var upgrade_texture_one : Texture2D 
@export var upgrade_texture_two : Texture2D 

@abstract func _on_place() -> void

@abstract func _on_hover() -> void

@abstract func _on_stop_hover() -> void

@abstract func on_upgrade_one() -> void

@abstract func on_upgrade_two() -> void

@abstract func get_upgrade_one_description(phase : int) -> String

@abstract func get_upgrade_two_description(phase : int) -> String

@abstract func get_item_cost(phase : int) -> int
 
