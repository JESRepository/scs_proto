extends Node

var players : Array[ProtoController] = []

func get_player_global_position() -> Vector3:
	var new_position : Vector3
	if players.is_empty():
		push_error("error: no players in PlayerManager")
		return new_position
	else:
		new_position = players[0].global_position
		return new_position

func get_menu_anchor_pos() -> Vector3:
	return players[0].menu_anchor.global_position

func add_to_players(new_player) -> void:
	if players.has(new_player) == null:
		pass
	else:
		players.append(new_player)

func capture_mouse() -> void:
	players[0].capture_mouse()

func get_rotation() -> Vector3:
	return players[0].rotation
