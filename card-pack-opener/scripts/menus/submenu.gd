class_name Submenu
extends Control

@export var spatial_anchor: Node3D
@export var freezes_player: bool = true

var is_newest : bool:
	get:
		return is_newest
	set(value):
		is_newest = value
		disable_submenu(value)

func disable_submenu(value: bool) -> void:
	if value:
		process_mode = ProcessMode.PROCESS_MODE_INHERIT
		print("submenu enabled")
	else:
		process_mode = ProcessMode.PROCESS_MODE_DISABLED
		print("submenu disabled")
