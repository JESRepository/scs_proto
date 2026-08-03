class_name MainMenu
extends Control

signal host_pressed

@onready var host_button = $VBoxContainer/HostButton

func _ready() -> void:
	if not host_button.is_connected("pressed", _on_host_pressed):
		host_button.connect("pressed",_on_host_pressed)

func _on_host_pressed() -> void:
	host_pressed.emit()
