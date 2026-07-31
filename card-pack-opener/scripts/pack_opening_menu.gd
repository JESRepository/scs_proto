class_name PackOpeningMenu
extends Control

@onready var open_pack_button : Button = $BoxContainer/OpenPackButton

signal open_pack_pressed
signal exit_pressed

func _on_open_pack_button_pressed() -> void:
	open_pack_button.visible = false
	open_pack_pressed.emit()


func _on_exit_button_pressed() -> void:
	exit_pressed.emit()

func show_open_pack_button() -> void:
	open_pack_button.visible = true
