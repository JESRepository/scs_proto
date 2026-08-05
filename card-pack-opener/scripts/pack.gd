class_name Pack
extends Resource

var card_set : CardSet
var pack_cards : Array[Card]
var rarity_chances : Dictionary[Rarity.rarity, int] = {
	#int is equal to % chance of rarity appearing in rarity slot
	Rarity.rarity.ULTRA:10,
	Rarity.rarity.SECRET:1,
}

func set_card_set(new_card_set: Sets.set_name)-> void:
	card_set = Sets.sets[new_card_set]

func fill_pack():
	create_commons(6)
	create_rares(1)

func create_commons(amount: int):
	for n in amount:
		pack_cards.append(_create_card(Rarity.rarity.COMMON))

func create_rares(amount: int):
	for n in amount:
		var rare_card_chance = randi() % 100 + 1
		var card_rarity = Rarity.rarity.RARE
		if rare_card_chance < rarity_chances[Rarity.rarity.ULTRA]:
			card_rarity = Rarity.rarity.ULTRA
		if rare_card_chance == rarity_chances[Rarity.rarity.SECRET]:
			card_rarity = Rarity.rarity.SECRET
		pack_cards.append(_create_card(card_rarity))

func _create_card(card_rarity):
	var new_card : Card
	match card_rarity:
		Rarity.rarity.COMMON:
			new_card = card_set.get_random_card(Rarity.rarity.COMMON)
		Rarity.rarity.RARE:
			new_card = card_set.get_random_card(Rarity.rarity.RARE)
		Rarity.rarity.ULTRA:
			new_card = card_set.get_random_card(Rarity.rarity.ULTRA)
		Rarity.rarity.SECRET:
			new_card = card_set.get_random_card(Rarity.rarity.SECRET)
	new_card.rarity = card_rarity
	return new_card

func open_pack() -> void:
	pass
