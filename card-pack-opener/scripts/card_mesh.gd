class_name CardMesh
extends MeshInstance3D

@onready var static_body : StaticBody3D = $StaticBody3D
@onready var collision_shape : CollisionShape3D = $StaticBody3D/CollisionShape3D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var pack_index : int = -1
var rarity : Rarity.rarity = Rarity.rarity.NONE

signal card_gone(index: int)

func _ready() -> void:
	static_body.process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(0.5).timeout
	static_body.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_static_body_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action("interact") and event.is_released() and Flags._are_pack_cards_moving == false:
		Flags._are_pack_cards_moving = true
		static_body.process_mode = Node.PROCESS_MODE_DISABLED
		animation_player.play("slide_up")
		await get_tree().create_timer(animation_player.get_section_end_time() + 0.25).timeout
		card_gone.emit(pack_index)
		Flags._are_pack_cards_moving = false

func set_rarity(new_rarity: Rarity.rarity) -> void:
	rarity = new_rarity
	set_color()

func set_color() -> void:
	var new_color : Color = Color.FUCHSIA
	match rarity:
		Rarity.rarity.COMMON:
			new_color = Color.WHITE
		Rarity.rarity.RARE:
			new_color = Color.MEDIUM_BLUE
		Rarity.rarity.ULTRA:
			new_color = Color.RED
		Rarity.rarity.SECRET:
			new_color = Color.GOLD
	material_override.albedo_color = new_color
