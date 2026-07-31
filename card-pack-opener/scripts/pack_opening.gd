extends Node3D

var packs : Array[Pack]

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_pack_opening_menu_open_pack_pressed() -> void:
	var new_pack : Pack = load("uid://cixyyp5htaarn").duplicate()
	new_pack.set_card_set(Sets.set_name.SET1)
	new_pack.fill_pack()
	new_pack.open_pack()
	packs.append(new_pack)
