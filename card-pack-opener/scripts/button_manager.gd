class_name ButtonManager
extends Node

signal button_request

func _ready() -> void:
	for n in get_tree().get_nodes_in_group("physical_buttons"):
		connect_button(n)

func connect_button(new_button: PhysicalButtonInteraction) -> void:
	if not new_button.pressed.is_connected(_on_pressed):
		new_button.pressed.connect(_on_pressed)

func _on_pressed(function, args) -> void:
	button_request.emit(function, args)
