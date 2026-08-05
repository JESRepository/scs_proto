class_name PackOpening
extends Node3D

@onready var card_anchor : Node3D = $CardAnchor
@onready var camera : Camera3D = $Camera3D

signal show_open_button

var pack_mesh_template = preload("uid://bc31isgi5my4t")
var pack_mesh : PackMesh
var card_mesh_template = preload("uid://d4gyuufxkvyef")

var packs : Array[Pack]
var card_meshes : Array[CardMesh]

const CARD_SPAWN_TIMER: float = 0.1
const CARD_SPAWN_SPACING: float = 0.02

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func open_pack() -> void:
	var new_pack : Pack = load("uid://cixyyp5htaarn").duplicate()
	new_pack.set_card_set(Sets.set_name.SET1)
	new_pack.fill_pack()
	new_pack.open_pack()
	pack_opening_sequence()
	packs.append(new_pack)

func pack_opening_sequence() -> void:
	pack_mesh.open_pack()

func _on_pack_mesh_pack_opened() -> void:
	pack_mesh = null
	spawn_cards()

func spawn_cards() -> void:
	var curr_pack = packs.back()
	var current_index : int = 0
	var anchor = create_anchor()
	var offset = Vector3(0,0,0)
	var offset_vector = Vector3(CARD_SPAWN_SPACING, 0, CARD_SPAWN_SPACING * -1)
	for cards in curr_pack.pack_cards:
		var new_card : CardMesh = ObjectManager.spawn_object(card_mesh_template,[curr_pack.pack_cards[current_index]])
		initialize_card(new_card)
		card_meshes.append(new_card)
		ObjectManager.set_new_parent(anchor, new_card)
		if not new_card.card_gone.is_connected(_on_card_gone):
			new_card.card_gone.connect(_on_card_gone)
		
		if current_index != 0:
			new_card.collision_shape.disabled = true
		
		
		new_card.position += offset
		offset += offset_vector
		new_card.pack_index = current_index
		await get_tree().create_timer(CARD_SPAWN_TIMER).timeout
		current_index += 1

func create_anchor() -> Node3D:
	var anchor = card_anchor.duplicate()
	ObjectManager.add_object(anchor)
	anchor.global_position = card_anchor.global_position
	anchor.quaternion = PlayerManager.get_quaternion(multiplayer.get_unique_id())
	return anchor

func create_pack_mesh() -> void:
	pack_mesh = ObjectManager.spawn_object(pack_mesh_template, [])
	initialize_pack(pack_mesh)
	if not pack_mesh.pack_opened.is_connected(_on_pack_mesh_pack_opened):
		pack_mesh.pack_opened.connect(_on_pack_mesh_pack_opened)
	
	var new_material = StandardMaterial3D.new()
	new_material.albedo_texture = Sets.sets[Sets.set_name.SET1].pack_texture
	pack_mesh.material_override = new_material

func initialize_card(card_mesh: CardMesh) -> void:
	card_mesh.rotation.x = PI/2

func initialize_pack(new_pack_mesh: PackMesh) -> void:
	new_pack_mesh.global_position = card_anchor.global_position
	new_pack_mesh.global_rotation = card_anchor.global_rotation

func _on_card_gone(index: int) -> void:
	if index != packs.back().pack_cards.size() - 1:
		var move_index = index
		for n in range(index, card_meshes.size()-1):
			var target = card_meshes[move_index]
			var next_card = card_meshes[move_index + 1]
			var tween = get_tree().create_tween()
			tween.tween_property(next_card, "position", target.position, 0.1)
			move_index += 1
		card_meshes[index+1].collision_shape.disabled = false
	else:
		for card in card_meshes:
			ObjectManager.remove_object(card)
		card_meshes.clear()
		show_open_button.emit()
		create_pack_mesh()

func set_camera() -> void:
	camera.make_current()

func remove_all_models() -> void:
	for n in card_meshes:
		ObjectManager.remove_object(n)
	card_meshes.clear()
	if pack_mesh != null:
		ObjectManager.remove_object(pack_mesh)
		pack_mesh = null
