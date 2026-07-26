extends Node

func play_sanitizer_sound() -> void:
	$SanitizerStream.play()
	
func play_industrial_build_sound() -> void:
	$WallStream.play()

func play_shoot_sound() -> void:
	$ShootStream.play()

func play_bacteria_death_sound() -> void:
	$BacteriaStream.play()

func play_vabnicka_sound() -> void:
	$VabnickaStream.play()
	$VabnickaStream.seek(0.81)

func play_purchase_sound() -> void:
	$PurchaseStream.play()
