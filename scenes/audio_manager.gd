extends Node

var sanitizer_base_volue : float
var shoot_base_volue : float
var bacteria_base_volue : float
var wall_base_volue : float
var purchase_base_volue : float
var vabnicka_base_volue : float

func _ready() -> void:
	sanitizer_base_volue = $SanitizerStream.volume_linear
	shoot_base_volue = $ShootStream.volume_linear
	bacteria_base_volue = $BacteriaStream.volume_linear
	wall_base_volue = $WallStream.volume_linear
	purchase_base_volue = $PurchaseStream.volume_linear
	vabnicka_base_volue = $VabnickaStream.volume_linear
	SignalManager.volume_change.connect(volume_change)

func volume_change(new_coeff : float) -> void:
	$SanitizerStream.volume_linear = sanitizer_base_volue * new_coeff
	$ShootStream.volume_linear = shoot_base_volue * new_coeff
	$BacteriaStream.volume_linear = bacteria_base_volue * new_coeff
	$WallStream.volume_linear = wall_base_volue * new_coeff
	$PurchaseStream.volume_linear = purchase_base_volue * new_coeff
	$VabnickaStream.volume_linear = vabnicka_base_volue * new_coeff

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
