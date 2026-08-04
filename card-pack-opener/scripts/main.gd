extends Node

@onready var menu_manager := $MenuManager
@onready var multiplayer_spawner := $MultiplayerSpawner

var curr_scene : Node
var curr_enviornment: CustomEnvironment
var player : ProtoController

func _ready() -> void:
	curr_scene = Menus.get_scene(Menus.menu_name.MAIN).instantiate()
	connect_multiplayer_spawner()
	connect_network()
	add_child(curr_scene)
	connect_menu(curr_scene)
	connect_menu_manager()

func _on_proto_controller_player_interaction(collider) -> void:
	var interactable : PhysicalButtonInteraction = collider.get_node_or_null("PhysicalButtonInteraction")
	if interactable == null:
		pass
	else:
		interactable._on_press()

func connect_menu(menu: Node) -> void:
	if menu is MainMenu:
			if not menu.host_pressed.is_connected(_on_host_pressed):
				menu.host_pressed.connect(_on_host_pressed)

func connect_envi(envi: CustomEnvironment) -> void:
	if not envi.button_request.is_connected(_on_main_request):
		envi.button_request.connect(_on_main_request)
	curr_enviornment = envi
	match envi:
		Hub:
			pass

func _on_host_pressed() -> void:
	switch_to_hub()
	Networking.host_lobby()

func switch_to_hub() -> void:
	var new_scene = Environments.get_envi(Environments.envi_name.HUB).instantiate()
	switch_scene(new_scene)
	menu_manager.add_submenu(Menus.menu_name.SPAWN_PACK)

func switch_scene(new_scene: Node) -> void:
	if new_scene is CustomEnvironment:
		connect_envi(new_scene)
	add_child(new_scene)
	curr_scene.queue_free()
	curr_scene = new_scene

func connect_network() -> void:
	Networking.host_created.connect(_on_host_created)
	Networking.joining_lobby.connect(_on_join_lobby)

func connect_player() -> void:
	if not player.player_interaction.is_connected(_on_proto_controller_player_interaction):
		player.player_interaction.connect(_on_proto_controller_player_interaction)

func connect_menu_manager() -> void:
	if not menu_manager.main_request.is_connected(_on_main_request):
		menu_manager.main_request.connect(_on_main_request)

func connect_multiplayer_spawner() -> void:
	multiplayer_spawner.spawn_path = PlayerManager.get_path()
	if not multiplayer_spawner.spawned.is_connected(_on_spawner_spawning):
		multiplayer_spawner.spawned.connect(_on_spawner_spawning)

func _on_main_request(function, arg) -> void:
	match function:
		Menus.functions.LOAD_SUBMENU:
			var target_menu = Menus.menu_name.get(arg[0])
			if target_menu == null:
				push_error("error: menu not found")
			else:
				menu_manager.add_submenu(target_menu)
		Menus.functions.CLEAR_SUBMENUS:
			menu_manager.clear_all_submenus()
		Menus.functions.HIDE_SUBMENUS:
			menu_manager.hide_submenus()
		Menus.functions.CLEAR_NEWEST_SUBMENU:
			menu_manager.clear_newest_submenu()
		Menus.functions.SHOW_SUBMENUS:
			menu_manager.show_submenus()

func _on_host_created() -> void:
	PlayerManager.spawn_player(multiplayer.get_unique_id(), curr_enviornment.get_spawn_point())
	multiplayer.peer_connected.connect(PlayerManager.spawn_player.bind(curr_enviornment.get_spawn_point()))

func _on_join_lobby() -> void:
	switch_to_hub()

func _on_spawner_spawning(node: Node) -> void:
	if node is ProtoController:
		PlayerManager.initialize_player(node, curr_enviornment.get_spawn_point())
