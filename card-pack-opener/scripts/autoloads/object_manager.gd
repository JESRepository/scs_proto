extends Node

@onready var multiplayer_spawner := $MultiplayerSpawner
@onready var card_manager := $CardManager

signal card_gone(index: int)
signal pack_opened()

var multiplayer_synchronizer: MultiplayerSynchronizer
var objects : Array[Node] = []
var spawnable_objects : Array[NodePath]


func _ready() -> void:
	initialize_multiplayer_spawner()
	connect_card_manager()

func initialize_multiplayer_spawner() -> void:
	if not multiplayer_spawner.spawned.is_connected(_on_spawner_spawned):
		multiplayer_spawner.spawned.connect(_on_spawner_spawned)

func connect_card_manager() -> void:
	if not card_manager.pack_opened.is_connected(_on_pack_opened):
		card_manager.pack_opened.connect(_on_pack_opened)
	if not card_manager.card_gone.is_connected(_on_card_gone):
		card_manager.card_gone.connect(_on_card_gone)


func add_object(object: Node) -> void:
	add_child(object, true)
	#print("added " + str(object.name) + " to " + str(name))
	objects.append(object)

func set_new_parent(parent: Node, child: Node) -> void:
	var curr_parent = child.get_parent()
	curr_parent.remove_child(child)
	parent.add_child(child)

func spawn_object(object: PackedScene, args: Array):
	var new_object : Node
	new_object = object.instantiate()
	if new_object is CardMesh:
		var card_data = args[0]
		var new_material = StandardMaterial3D.new()
		var new_texture = load("res://assets/card_textures/Card" + str(card_data.texture))
		new_material.albedo_texture = new_texture
		new_object.material_override = new_material
		card_manager.tint_card(new_material, card_data.rarity)
	else:
		pass
	add_object(new_object)
	return new_object

func create_anchor(new_anchor: Node3D) -> void:
	card_manager.create_anchor(new_anchor)

func clear_card_meshes() -> void:
	card_manager.card_meshes.clear()

func get_card_meshes() -> Array[CardMesh]:
	return card_manager.get_card_meshes()

func remove_object(object: Node):
	objects.erase(object)
	object.queue_free()

func append_pack(new_pack: Pack) -> void:
	card_manager.append_pack(new_pack)

func get_packs() -> Array[Pack]:
	return card_manager.get_packs()

func create_pack_mesh() -> void:
	card_manager.create_pack_mesh()

func get_pack_mesh() -> PackMesh:
	return card_manager.get_pack_mesh()

func set_pack_mesh(new_mesh) -> void:
	card_manager.set_pack_mesh(new_mesh)

func _on_spawner_spawned(node: Node) -> void:
	print("spawned " + str(node.name))

func _on_pack_opened() -> void:
	pack_opened.emit()

func _on_card_gone(index: int) -> void:
	card_gone.emit(index)
