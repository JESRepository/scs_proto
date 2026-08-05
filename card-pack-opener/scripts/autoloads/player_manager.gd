extends Node

@onready var player_scene = preload("uid://bs72ogkvdd7d6")

var players : Dictionary[String, ProtoController] = {}

func _ready() -> void:
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func spawn_player(peer_id: int, spawn_point: Vector3) -> void:
	var new_player := player_scene.instantiate() as ProtoController
	new_player.name = str(peer_id)
	add_child(new_player)
	initialize_player(new_player, spawn_point)

func initialize_player(player: ProtoController, spawn_point: Vector3) -> void:
	player.position = spawn_point
	for other in players:
		player.add_collision_exception_with(players[other])
	players.set(player.name, player)

func get_position(peer_id: int) -> Vector3:
	return players[str(peer_id)].global_position

func get_menu_anchor_pos(peer_id: int) -> Vector3:
	return players[str(peer_id)].menu_anchor.global_position

func add_to_players(new_player) -> void:
	if players.has(new_player.name):
		pass
	else:
		players.set(new_player.name ,new_player)

func capture_mouse(peer_id: int) -> void:
	if players.is_empty():
		pass
	else:
		players[str(peer_id)].capture_mouse()

func get_rotation(peer_id: int) -> Vector3:
	return players[str(peer_id)].global_rotation

func get_quaternion(peer_id: int) -> Quaternion:
	return players[str(peer_id)].quaternion

func get_player(peer_id: int) -> ProtoController:
	return players[str(peer_id)]

func _on_peer_disconnected(peer_id: int) -> void:
	var disconnected_player = get_node_or_null(str(peer_id))
	if disconnected_player == null:
		print("error: player " + str(peer_id) + " does not exist")
	else:
		players.erase(disconnected_player)
		disconnected_player.queue_free()
