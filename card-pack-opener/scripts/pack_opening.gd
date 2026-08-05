class_name PackOpening
extends Node3D

@onready var card_anchor : Node3D = $Marker3D
@onready var camera : Camera3D = $Camera3D

signal show_open_button

func _enter_tree() -> void:
	set_multiplayer_authority(multiplayer.get_unique_id())

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if not ObjectManager.card_gone.is_connected(_on_card_gone):
		ObjectManager.card_gone.connect(_on_card_gone)
	if not ObjectManager.pack_opened.is_connected(_on_pack_opened):
		ObjectManager.pack_opened.connect(_on_pack_opened)

func initialize_anchor() -> void:
	ObjectManager.create_anchor(card_anchor)

func create_pack_mesh() -> void:
	ObjectManager.create_pack_mesh()

func open_pack() -> void:
	var new_pack : Pack = load("uid://cixyyp5htaarn").duplicate()
	new_pack.set_card_set(Sets.set_name.SET1)
	new_pack.fill_pack()
	new_pack.open_pack()
	pack_opening_sequence()
	ObjectManager.card_manager.append_pack(new_pack)

func pack_opening_sequence() -> void:
	var pack_mesh : PackMesh = ObjectManager.get_pack_mesh()
	pack_mesh.open_pack()

func _on_pack_opened() -> void:
	ObjectManager.set_pack_mesh(null)
	var packs : Array[Pack] = ObjectManager.get_packs()
	# error here is because in an RPC call, custom objects are converted to EncodedObjectAsID to prevent ACE
	ObjectManager.card_manager.spawn_cards.rpc_id(1, multiplayer.get_unique_id(), packs)

func _on_card_gone(index: int) -> void:
	var card_meshes : Array[CardMesh] = ObjectManager.get_card_meshes()
	if index != ObjectManager.get_packs().back().pack_cards.size() - 1:
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
		ObjectManager.clear_card_meshes()
		show_open_button.emit()
		ObjectManager.card_manager.create_pack_mesh.rpc_id(1)

func set_camera() -> void:
	camera.make_current()

func remove_all_nodes() -> void:
	ObjectManager.card_manager.remove_all_nodes.rpc_id(1)
