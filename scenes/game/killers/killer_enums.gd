class_name killer_enums

#probably should store all this in the scene but i dont want to

enum names {sanitizer, wall}

const icon_dictionary : Dictionary[names, Texture2D] = {
	names.sanitizer : preload("res://assets/game/killers/sanitizer_icon.png"),
	names.wall : preload("res://assets/game/killers/wall_icon.png")
}

const scene_dictionary : Dictionary[names, PackedScene] = {
	names.sanitizer : preload("res://scenes/game/killers/sanitizer.tscn"),
	names.wall : preload("res://scenes/game/killers/wall.tscn")
}

static var cooldown_dictionary :  Dictionary[names, float] = {
	names.sanitizer : 1.0,
	names.wall : 2.0
}
