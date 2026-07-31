extends Node
class_name PhysicalButtonInteraction

@export var scene_path : String

func _on_press() -> void:
	SceneLoader.load_scene(scene_path)
