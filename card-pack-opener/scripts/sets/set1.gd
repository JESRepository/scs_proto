extends CardSet

func _set_cards() -> void:
	all_cards = add_all()

	commons = add_range(1,30)
	
	rares = add_range(31,40)
	
	ultras = [
		add_by_index(41)
	]
