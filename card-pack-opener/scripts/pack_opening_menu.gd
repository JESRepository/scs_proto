extends Control

@onready var open_pack_button : Button = $BoxContainer/OpenPackButton
signal open_pack_pressed

func _on_open_pack_button_pressed() -> void:
	#open_pack_button.disabled = true
	open_pack_pressed.emit()
