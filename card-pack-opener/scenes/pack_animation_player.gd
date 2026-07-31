extends AnimationPlayer

func pack_opening_sequence() -> void:
	play("pack_open")
	get_tree().create_timer(get_section_end_time()).timeout.connect(_on_pack_open_finish)

func _on_pack_open_finish() -> void:
	play("show_card")
