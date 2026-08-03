extends Node

enum phys_button_func {
	LOAD_SUBMENU,
}

enum menu_name {
	MAIN,
	PACK_OPEN,
}

var menus : Dictionary[menu_name, PackedScene] = {
	menu_name.MAIN:preload("uid://80l1l2ss86is"),
	menu_name.PACK_OPEN:load("uid://biurtdes2n8ni"),
}

func get_scene(new_name: menu_name) -> PackedScene:
	var new_menu : PackedScene = menus.get(new_name)
	return new_menu
