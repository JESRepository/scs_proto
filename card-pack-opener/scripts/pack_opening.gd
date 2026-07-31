extends Node3D

@onready var pack_mesh = $PackMesh
@onready var card_mesh = preload("uid://d4gyuufxkvyef")
@onready var card_anchor = $CardAnchor

var packs : Array[Pack]

const CARD_SPAWN_TIMER: float = 0.1
const CARD_SPAWN_SPACING: float = 0.02

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_pack_opening_menu_open_pack_pressed() -> void:
	var new_pack : Pack = load("uid://cixyyp5htaarn").duplicate()
	new_pack.set_card_set(Sets.set_name.SET1)
	new_pack.fill_pack()
	new_pack.open_pack()
	pack_opening_sequence()
	packs.append(new_pack)

func _on_pack_opening_menu_exit_pressed() -> void:
	SceneLoader.load_scene("uid://ciwvjo5q0h5cj")


func pack_opening_sequence() -> void:
	pack_mesh.open_pack()


func _on_pack_mesh_pack_opened() -> void:
	spawn_cards()

func spawn_cards() -> void:
	var z_offset : float = 0.0
	for cards in packs.back().pack_cards:
		var new_card = card_mesh.instantiate()
		add_child(new_card)
		new_card.position.x = card_anchor.position.x + z_offset
		new_card.position.y = card_anchor.position.y 
		new_card.position.z = card_anchor.position.z - z_offset
		z_offset += CARD_SPAWN_SPACING
		await get_tree().create_timer(CARD_SPAWN_TIMER).timeout
