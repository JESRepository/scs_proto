extends Node

@onready var player_scene = preload("uid://bs72ogkvdd7d6")

var players : Array[ProtoController] = []

func spawn_player(peer_id: int, spawn_point: Vector3) -> void:
	var new_player := player_scene.instantiate() as ProtoController
	new_player.name = str(peer_id)
	add_child(new_player)
	initialize_player(new_player, spawn_point)

func initialize_player(player: ProtoController, spawn_point: Vector3) -> void:
	player.position = spawn_point
	for other in players:
		player.add_collision_exception_with(other)
	players.append(player)

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
		print(new_player)

func capture_mouse() -> void:
	if players.is_empty():
		pass
	else:
		players[0].capture_mouse()

func get_rotation() -> Vector3:
	return players[0].rotation
