extends Node

func load_json(path: String) -> Array:
	var file_string = FileAccess.get_file_as_string(path)
	var json_data
	if file_string != null:
		json_data = JSON.parse_string(file_string)
	else:
		push_warning("JSON load failed")
	if json_data == null:
		push_error("JSON loaded as empty")
	return json_data
