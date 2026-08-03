extends Node

@onready var player_scene = preload("uid://bs72ogkvdd7d6")
@onready var menu_manager : MenuManager = $MenuManager

var curr_scene : Node
var player : ProtoController

func _ready() -> void:
	curr_scene = Menus.get_scene(Menus.menu_name.MAIN).instantiate()
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
			if not menu.is_connected("start_pressed", _on_main_menu_start_pressed):
				menu.connect("start_pressed", _on_main_menu_start_pressed)

func connect_envi(envi: CustomEnvironment) -> void:
	if not envi.button_request.is_connected(_on_main_request):
		envi.button_request.connect(_on_main_request)
	match envi:
		Hub:
			pass

func _on_main_menu_start_pressed() -> void:
	var new_scene = Environments.get_envi(Environments.envi_name.HUB).instantiate()
	switch_scene(new_scene)
	spawn_player()
	menu_manager.add_submenu(Menus.menu_name.SPAWN_PACK)

func switch_scene(new_scene: Node) -> void:
	if new_scene is CustomEnvironment:
		connect_envi(new_scene)
	add_child(new_scene)
	curr_scene.queue_free()
	curr_scene = new_scene

func spawn_player() -> void:
	player = player_scene.instantiate()
	add_child(player)
	connect_player()

func connect_player() -> void:
	if not player.player_interaction.is_connected(_on_proto_controller_player_interaction):
		player.player_interaction.connect(_on_proto_controller_player_interaction)

func connect_menu_manager() -> void:
	if not menu_manager.main_request.is_connected(_on_main_request):
		menu_manager.main_request.connect(_on_main_request)

func _on_main_request(function, arg) -> void:
	match function:
		Menus.functions.LOAD_SUBMENU:
			print(Menus.menu_name)
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
