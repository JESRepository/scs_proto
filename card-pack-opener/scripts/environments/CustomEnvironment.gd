class_name CustomEnvironment
extends Node3D

@onready var spawn_point = set_spawn_point()

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

func set_spawn_point():
	if get_node_or_null("SpawnPoint") == null:
		return null
	else:
		return get_node("SpawnPoint")

func get_spawn_point() -> Vector3:
	var new_pos := Vector3(0,0,0)
	if spawn_point != null:
		new_pos = spawn_point.global_position
	return new_pos
