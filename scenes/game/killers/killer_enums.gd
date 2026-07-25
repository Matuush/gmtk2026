class_name killer_enums

#probably should store all this in the scene but i dont want to

enum names {sanitizer, wall, vabnicka, shooter}

#const icon_dictionary : Dictionary[names, Texture2D] = {
	#names.sanitizer : preload("res://assets/game/killers/sanitizer_icon.png"),
	#names.wall : preload("res://assets/game/killers/wall_icon.png"),
	#names.shooter : preload("res://assets/game/killers/gun_icon.png")
#}

const scene_dictionary : Dictionary[names, PackedScene] = {
	names.sanitizer : preload("res://scenes/game/killers/sanitizer.tscn"),
	names.wall : preload("res://scenes/game/killers/wall.tscn"),
	names.vabnicka : preload("res://scenes/game/killers/vabnicka.tscn"),
	names.shooter : preload("res://scenes/game/killers/shooter.tscn")
}


const description_dictionary : Dictionary[names, String] = {
	names.sanitizer : "[b]Sanitizer[/b]:\nDamages all enemies in a short area",
	names.wall : "[b]Wall[/b]:\nBuilds a... uh.. wall",
	names.vabnicka : "[b]Vabnicka[/b]:\nVabs the enemies in",
	names.shooter : "[b]Fart monkey[/b] (patent pending):\nPeriodically shoots a projectile at enemies"
}

static var cooldown_dictionary :  Dictionary[names, float] = {
	names.sanitizer : 1.0,
	names.wall : 2.0,
	names.vabnicka : 2.0,
	names.shooter : 1.0
}
