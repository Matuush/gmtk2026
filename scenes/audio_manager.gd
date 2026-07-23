extends Node

func play_sanitizer_sound() -> void:
	$SanitizerStream.play()
	
func play_wall_sound() -> void:
	$WallStream.play()

func play_shoot_sound() -> void:
	$ShootStream.play()

func play_bacteria_death_sound() -> void:
	$BacteriaStream.play()
