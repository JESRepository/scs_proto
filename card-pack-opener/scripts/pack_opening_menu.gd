class_name PackOpeningMenu
extends Submenu

@onready var open_pack_button : Button = $BoxContainer/OpenPackButton
@onready var pack_opening : PackOpening = $PackOpening
@onready var exit_button : Button = $ExitButton

func _ready() -> void:
	connect_pack_opening()
	pack_opening.set_camera()

func initialize_spatial_menu() -> void:
	pack_opening.create_pack_mesh()

func _on_open_pack_button_pressed() -> void:
	open_pack_button.visible = false
	pack_opening.open_pack()

func _on_exit_button_pressed() -> void:
	pack_opening.remove_all_models()
	main_request.emit(Menus.functions.SHOW_SUBMENUS, [])
	main_request.emit(Menus.functions.CLEAR_NEWEST_SUBMENU, [])

func connect_pack_opening() -> void:
	if not pack_opening.show_open_button.is_connected(_on_show_open_button):
		pack_opening.show_open_button.connect(_on_show_open_button)
	if not exit_button.pressed.is_connected(_on_exit_button_pressed):
		exit_button.pressed.connect(_on_exit_button_pressed)

func _on_show_open_button() -> void:
	open_pack_button.visible = true
