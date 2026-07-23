class_name game extends Node2D

const killer_count : int = 4
static var level_killers : Array[killer_enums.names] = [killer_enums.names.sanitizer, killer_enums.names.wall, killer_enums.names.sanitizer, killer_enums.names.sanitizer]

static var selected_item_button : offered_item_button = null

func _ready():
	$KillerSelectionBox.make_items()
