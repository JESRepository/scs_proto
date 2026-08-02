extends Node

enum set_name {
	SET1,
}

@onready var sets : Dictionary[set_name, CardSet] = {
	set_name.SET1: await make_set("uid://4ds4aju2jwlj")
}

func make_set(new_set_UID : String) -> CardSet:
	if not Cards.is_node_ready():
		await Cards.ready
	var new_set : CardSet = load(new_set_UID)
	new_set._set_cards()
	new_set.set_pack_texture()
	return new_set
