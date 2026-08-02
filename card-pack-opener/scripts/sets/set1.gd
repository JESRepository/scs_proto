extends CardSet

func _set_cards() -> void:
	all_cards = add_all()

	commons = add_range(1,25)
	
	rares = add_range(26,30)
	
	ultras = add_range(31,40)
	
	secrets = [
		add_by_index(41)
	]
