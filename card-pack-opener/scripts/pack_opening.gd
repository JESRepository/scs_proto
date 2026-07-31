extends Node3D

@onready var pack = preload("uid://boddd6sflubsw")

var packs : Array[Pack]

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_pack_opening_menu_open_pack_pressed() -> void:
	var new_pack = pack.instantiate()
	add_child(new_pack)
	packs.append(new_pack)
