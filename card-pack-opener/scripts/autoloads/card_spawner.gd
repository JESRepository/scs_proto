extends Node

@onready var card_mesh = preload("uid://d4gyuufxkvyef")

func spawn_card_mesh(card_data: Card) -> CardMesh:
	var new_mesh : CardMesh = card_mesh.instantiate()
	var new_material = StandardMaterial3D.new()
	var new_texture = load("res://assets/card_textures/Card" + str(card_data.texture))
	new_material.albedo_texture = new_texture
	new_mesh.material_override = new_material
	tint_card(new_material, card_data.rarity)
	return new_mesh

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
