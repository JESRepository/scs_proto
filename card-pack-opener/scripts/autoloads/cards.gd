extends Node

@onready var card = preload("uid://bpbhkqigsrubv")

@onready var cards : Dictionary[String, Card] = {
	"Card1": make_card("Card1"),
	"Card2": make_card("Card2"),
	"Card3": make_card("Card3"),
	"Card4": make_card("Card4"),
	"Card5": make_card("Card5"),
	"Card6": make_card("Card6"),
	"Card7": make_card("Card7"),
	"Card8": make_card("Card8"),
	"Card9": make_card("Card9"),
}

func make_card(new_name) -> Card:
	var new_card = card.duplicate()
	new_card.setup(new_name)
	return new_card
