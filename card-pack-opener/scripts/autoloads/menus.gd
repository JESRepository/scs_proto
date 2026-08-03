extends Node

enum functions {
	LOAD_SUBMENU,
	CLEAR_SUBMENUS,
	HIDE_SUBMENUS,
	CLEAR_NEWEST_SUBMENU,
	SHOW_SUBMENUS,
}

enum menu_name {
	MAIN,
	PACK_OPEN,
	SPAWN_PACK,
}

var menus : Dictionary[menu_name, PackedScene] = {
	menu_name.MAIN:preload("uid://80l1l2ss86is"),
	menu_name.PACK_OPEN:load("uid://biurtdes2n8ni"),
	menu_name.SPAWN_PACK:load("uid://dbxewlui20p0j"),
}

func get_scene(new_name: menu_name) -> PackedScene:
	var new_menu : PackedScene = menus.get(new_name)
	return new_menu
