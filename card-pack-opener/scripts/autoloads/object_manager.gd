extends Node

var objects : Array[Node] = []
var multiplayer_spawner: MultiplayerSpawner
var multiplayer_synchronizer: MultiplayerSynchronizer
var spawnable_objects : Array[NodePath]

func _ready() -> void:
	initialize_multiplayer_spawner()

func add_object(object: Node) -> void:
	add_child(object, true)
	print("added " + str(object.name) + " to " + str(name))
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
		tint_card(new_material, card_data.rarity)
	else:
		pass
	add_object(new_object)
	return new_object

func remove_object(object: Node):
	objects.erase(object)
	object.queue_free()

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

func initialize_multiplayer_spawner() -> void:
	multiplayer_spawner = MultiplayerSpawner.new()
	add_child(multiplayer_spawner)
	multiplayer_spawner.spawn_path = get_path()

	multiplayer_spawner.add_spawnable_scene("uid://bc31isgi5my4t")
	multiplayer_spawner.add_spawnable_scene("uid://d4gyuufxkvyef")
	multiplayer_spawner.add_spawnable_scene("uid://b03pknchr3as8")

	if not multiplayer_spawner.spawned.is_connected(_on_spawner_spawned):
		multiplayer_spawner.spawned.connect(_on_spawner_spawned)

func _on_spawner_spawned(node: Node) -> void:
	print("spawned " + str(node.name))
