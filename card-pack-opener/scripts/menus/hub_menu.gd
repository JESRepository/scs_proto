class_name SpawnPackMenu
extends Submenu

@onready var spawn_pack_button : Button = $SpawnPackButton



func _ready() -> void:
	if not spawn_pack_button.pressed.is_connected(_on_spawn_pack_pressed):
		spawn_pack_button.pressed.connect(_on_spawn_pack_pressed)

func _on_spawn_pack_pressed() -> void:
	print("clicked")
	main_request.emit(Menus.functions.HIDE_SUBMENUS, [])
	main_request.emit(Menus.functions.LOAD_SUBMENU, ["PACK_OPEN"])
