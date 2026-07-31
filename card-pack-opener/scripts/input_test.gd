extends Label

func _process(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		self.text = "pressed"
	else:
		self.text = "nuttin"
