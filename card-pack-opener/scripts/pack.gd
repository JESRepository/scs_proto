class_name Pack
extends Node

var cards : Array[Card]
var blank_card = preload("uid://c7ne5xqc7eby6")

enum rarity {
	COMMON,
	RARE,
	ULTRA,
	SECRET,
}


func _ready() -> void:
	_create_pack_data()
	var card_names : Array[String]
	for n in cards:
		card_names.append(n.name)
	print(card_names)

func _create_pack_data():
	for n in 6:
		cards.append(_create_card(rarity.COMMON))
	var rare_card_chance = randi() % 100 + 1
	var card_rarity = rarity.RARE
	if rare_card_chance > 90:
		card_rarity = rarity.ULTRA
	if rare_card_chance == 100:
		card_rarity = rarity.SECRET
	cards.append(_create_card(card_rarity))

func _create_card(card_rarity):
	var new_card : Card = blank_card.instantiate()
	var card_name = "unnamed"
	self.add_child(new_card)
	match card_rarity:
		rarity.COMMON:
			card_name = "Common" + str(randi() % 20)
		rarity.RARE:
			card_name = "Rare"
		rarity.ULTRA:
			card_name = "Ultra"
		rarity.SECRET:
			card_name = "Secret"
	new_card.card_name = card_name
	new_card.name = card_name
	return new_card
