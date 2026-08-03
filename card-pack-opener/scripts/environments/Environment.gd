class_name CustomEnvironment
extends Node3D

signal button_request(function, args)

func _ready() -> void:
	if has_button_manager():
		connect_button_manager($ButtonManager)

func connect_button_manager(button_manager: ButtonManager) -> void:
	if not button_manager.button_request.is_connected(_on_button_request):
		button_manager.button_request.connect(_on_button_request)

func _on_button_request(function, args) -> void:
	button_request.emit(function, args)

func has_button_manager() -> bool:
	var result = false
	var children = get_children()
	for n in children:
		if n is ButtonManager:
			result = true
			break
	return result
