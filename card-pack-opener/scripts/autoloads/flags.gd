extends Node

var _are_pack_cards_moving : bool = false
var player_in_frozen_submenu: bool = false
var freeze_player : bool:
	get:
		return freeze_player
	set(value):
		if not player_in_frozen_submenu:
			freeze_player = value
		else:
			freeze_player = true
		if freeze_player == false:
			PlayerManager.capture_mouse()
