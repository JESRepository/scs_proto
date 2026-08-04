class_name MenuManager
extends Node

signal main_request(function: Menus.functions, arg: Array)

var curr_submenus : Array[Control] = []

func add_submenu(new_menu_name: Menus.menu_name) -> void:
	var new_menu : Submenu = Menus.menus.get(new_menu_name).instantiate()
	connect_submenu(new_menu)
	add_child(new_menu)
	if new_menu.is_in_group("spatial_menu"):
		new_menu.spatial_anchor.global_position = get_spatial_menu_pos()
		new_menu.spatial_anchor.rotation.y = PlayerManager.get_rotation().y
	curr_submenus.append(new_menu)
	set_freeze_flag()

func connect_submenu(curr_submenu: Submenu) -> void:
	if not curr_submenu.main_request.is_connected(_on_main_request):
			curr_submenu.main_request.connect(_on_main_request)


func clear_newest_submenu() -> void:
	var newest_submenu = curr_submenus.pop_back()
	newest_submenu.queue_free()
	set_freeze_flag()

func get_spatial_menu_pos() -> Vector3:
	var new_coords = PlayerManager.get_menu_anchor_pos()
	return new_coords

func set_freeze_flag() -> void:
	var new_freeze_value = false
	for n in curr_submenus:
		var curr_menu : Submenu = n
		if curr_menu.freezes_player:
			new_freeze_value = true
			break
	Flags.player_in_frozen_submenu = new_freeze_value
	Flags.freeze_player = new_freeze_value

func clear_all_submenus() -> void:
	for n in curr_submenus:
		clear_newest_submenu()

func hide_submenus() -> void:
	for n in curr_submenus:
		var curr_menu : Submenu = n
		curr_menu.visible = false
		curr_menu.set_process(false)

func show_submenus() -> void:
	for n in curr_submenus:
		var curr_menu : Submenu = n
		curr_menu.set_process(true)
		curr_menu.visible = true
	var last_submenu : Submenu = curr_submenus.back()

func _on_main_request(function, args) -> void:
	main_request.emit(function, args)
