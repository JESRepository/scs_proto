extends Node
class_name PhysicalButtonInteraction

signal pressed(function, args)

@export var selected_function : Menus.phys_button_func
@export var args : Array

func _on_press() -> void:
	pressed.emit(selected_function, args)
