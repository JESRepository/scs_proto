extends Control

@onready var open_pack_button : Button = $BoxContainer/OpenPackButton

signal open_pack_pressed
signal exit_pressed

func _on_open_pack_button_pressed() -> void:
	#open_pack_button.disabled = true
	open_pack_pressed.emit()


func _on_exit_button_pressed() -> void:
	exit_pressed.emit()
