class_name PackMesh
extends MeshInstance3D

signal pack_opened

@onready var animation_player = $AnimationPlayer

func open_pack():
	animation_player.play("pack_open")
	await get_tree().create_timer(animation_player.get_section_end_time()).timeout
	pack_opened.emit()
	queue_free()
