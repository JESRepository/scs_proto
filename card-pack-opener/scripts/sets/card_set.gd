class_name CardSet
extends Resource

var all_cards : Array[Card]

var commons : Array[Card]
var rares : Array[Card]
var ultras : Array[Card]
var secrets : Array[Card]

func get_random_card(rarity: Rarity.rarity = Rarity.rarity.NONE):
	var selected_card : Card
	match rarity:
		Rarity.rarity.NONE:
			selected_card = all_cards.pick_random()
		Rarity.rarity.COMMON:
			selected_card = commons.pick_random()
		Rarity.rarity.RARE:
			selected_card = rares.pick_random()
		Rarity.rarity.ULTRA:
			selected_card = ultras.pick_random()
		Rarity.rarity.SECRET:
			selected_card = secrets.pick_random()
	selected_card = selected_card.duplicate(true)
	return selected_card


func _safe_set_cards() -> void:
	if not Cards.is_node_ready():
		await Cards.ready
	_set_cards()

func _set_cards() -> void:
	pass

func get_all_card_names():
	if all_cards.size() == 0 or all_cards == null:
		return ("ERROR: no cards in set")
	else:
		var names : Array
		for n in all_cards:
			names.append(n.card_name)
		return names
		
