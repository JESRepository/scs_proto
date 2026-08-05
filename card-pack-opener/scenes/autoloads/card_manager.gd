class_name CardManager
extends Node

@onready var anchor : CardAnchor

signal card_gone(index: int)
signal pack_opened()

const CARD_SPAWN_TIMER: float = 0.1
const CARD_SPAWN_SPACING: float = 0.02

var pack_mesh_template = preload("uid://bc31isgi5my4t")
var card_mesh_template = preload("uid://d4gyuufxkvyef")

var packs : Array[Pack] = []
var card_meshes : Array[CardMesh] = []
var pack_mesh
var temp_anchor : CardAnchor

func initialize_pack(new_pack_mesh: PackMesh) -> void:
	new_pack_mesh.global_position = anchor.global_position
	new_pack_mesh.global_rotation = anchor.global_rotation

func initialize_card(card_mesh: CardMesh, _peer_id: int) -> void:
	card_mesh.rotation.x = PI/2

func initialize_anchor() -> void:
	create_anchor.rpc_id(1)

func tint_card(material: StandardMaterial3D, rarity: Rarity.rarity) -> void:
	var tint_color : Color = Color.TRANSPARENT
	match rarity:
		Rarity.rarity.RARE:
			tint_color = Color.LIGHT_SKY_BLUE
		Rarity.rarity.ULTRA:
			tint_color = Color.LIGHT_CORAL
		Rarity.rarity.SECRET:
			tint_color = Color.GOLD
	material.albedo_color = tint_color

@rpc("any_peer", "call_local", "reliable")
func spawn_cards(peer_id: int, new_packs: Array[Pack]) -> void:
	print("received call from " + str(peer_id))
	var curr_pack = new_packs.back()
	var current_index : int = 0
	var offset = Vector3(0,0,0)
	var offset_vector = Vector3(CARD_SPAWN_SPACING, 0, CARD_SPAWN_SPACING * -1)
	for cards in curr_pack.pack_cards:
		var new_card : CardMesh = ObjectManager.spawn_object(card_mesh_template,[curr_pack.pack_cards[current_index]])
		initialize_card(new_card, multiplayer.get_unique_id())
		ObjectManager.set_new_parent(anchor, new_card)
		card_meshes.append(new_card)
		if not new_card.card_gone.is_connected(_on_card_gone):
			new_card.card_gone.connect(_on_card_gone)
		
		if current_index != 0:
			new_card.collision_shape.disabled = true
		
		new_card.position += offset
		offset += offset_vector
		new_card.pack_index = current_index
		await get_tree().create_timer(CARD_SPAWN_TIMER).timeout
		current_index += 1

@rpc("any_peer", "call_local", "reliable")
func create_anchor(card_anchor: Node3D) -> void:
	anchor = CardAnchor.new()
	ObjectManager.add_object(anchor)
	anchor.global_position = card_anchor.global_position
	anchor.quaternion = PlayerManager.get_quaternion(multiplayer.get_unique_id())

@rpc("any_peer", "call_local", "reliable")
func remove_all_nodes() -> void:
	for n in card_meshes:
		ObjectManager.remove_object(n)
	card_meshes.clear()
	if pack_mesh != null:
		ObjectManager.remove_object(pack_mesh)
		pack_mesh = null
	if anchor != null:
		ObjectManager.remove_object(anchor)
		anchor = null

@rpc("any_peer", "call_local", "reliable")
func create_pack_mesh() -> void:
	pack_mesh = ObjectManager.spawn_object(pack_mesh_template, [])
	initialize_pack(pack_mesh)
	if not pack_mesh.pack_opened.is_connected(_on_pack_opened):
		pack_mesh.pack_opened.connect(_on_pack_opened)
	
	var new_material = StandardMaterial3D.new()
	new_material.albedo_texture = Sets.sets[Sets.set_name.SET1].pack_texture
	pack_mesh.material_override = new_material

func get_card_meshes() -> Array[CardMesh]:
	return card_meshes

func append_pack(new_pack: Pack) -> void:
	Networking.rpc_message.rpc_id(1,multiplayer.get_unique_id() ,"appending pack")
	packs.append(new_pack)

func get_packs() -> Array[Pack]:
	Networking.rpc_message.rpc_id(1, multiplayer.get_unique_id() ,"returning packs " + str(packs))
	return packs

func _on_card_gone(index: int):
	card_gone.emit(index)

func _on_pack_opened() -> void:
	pack_opened.emit()

func get_pack_mesh() -> PackMesh:
	return pack_mesh

func set_pack_mesh(new_mesh):
	pack_mesh = new_mesh
