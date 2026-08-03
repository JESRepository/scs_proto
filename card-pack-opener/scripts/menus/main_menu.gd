class_name MainMenu
extends Control

signal start_pressed

@onready var start_button = $VBoxContainer/StartButton

func _ready() -> void:
	if not start_button.is_connected("pressed", _on_start_pressed):
		start_button.connect("pressed",_on_start_pressed)

func _on_start_pressed() -> void:
	start_pressed.emit()
