class_name Card
extends Resource

@export var card_name : String
@export var rarity : Rarity.rarity

func setup(new_name: String) -> void:
	card_name = new_name
