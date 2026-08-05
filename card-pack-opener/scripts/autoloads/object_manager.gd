extends Node

var objects : Array[Node] = []

func add_object(object: Node) -> void:
	add_child(object)
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
	add_child(new_object)
	objects.append(new_object)
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
