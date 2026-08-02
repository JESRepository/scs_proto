extends Node

@onready var json_data = JsonLoader.load_json("res://data/csvjson.json")
@onready var cards : Dictionary[String, Card] = import_cards()

func import_cards() -> Dictionary[String, Card]:
	var new_cards : Dictionary[String, Card]
	for n in json_data:
		var curr_card = Card.new()
		curr_card.card_name = n.get("Name")
		curr_card.texture = n.get("Texture")
		curr_card.index = n.get("Index")
		new_cards.set(curr_card.card_name, curr_card)
	return new_cards

func get_by_index(index: int):
	var all_keys : Array[Card] = cards.values()
	for curr_card in all_keys:
		if curr_card.index == index:
			return curr_card
