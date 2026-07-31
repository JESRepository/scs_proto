extends Node

func _on_proto_controller_player_interaction(collider) -> void:
	var interactable : PhysicalButtonInteraction = collider.get_node_or_null("PhysicalButtonInteraction")
	if interactable == null:
		pass
	else:
		interactable._on_press()
