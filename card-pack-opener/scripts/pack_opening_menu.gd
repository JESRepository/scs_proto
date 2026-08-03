class_name PackOpeningMenu
extends Submenu

@onready var open_pack_button : Button = $BoxContainer/OpenPackButton
@onready var pack_opening : PackOpening = $PackOpening

signal exit_pressed

func _ready() -> void:
	connect_pack_opening()
	pack_opening.set_camera()

func _on_open_pack_button_pressed() -> void:
	open_pack_button.visible = false
	pack_opening.open_pack()

func _on_exit_button_pressed() -> void:
	exit_pressed.emit()

func connect_pack_opening() -> void:
	if not pack_opening.show_open_button.is_connected(_on_show_open_button):
		pack_opening.show_open_button.connect(_on_show_open_button)

func _on_show_open_button() -> void:
	open_pack_button.visible = true
