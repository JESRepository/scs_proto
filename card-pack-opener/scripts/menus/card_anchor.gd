class_name CardAnchor
extends Node3D

func _ready() -> void:
	set_multiplayer_authority(multiplayer.get_unique_id())
