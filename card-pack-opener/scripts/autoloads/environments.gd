extends Node

enum envi_name {
	HUB,
}

var enviornments : Dictionary[envi_name,PackedScene] = {
	envi_name.HUB:load("uid://cyqpwxueprtjx")
}

func get_envi(new_name: envi_name) -> PackedScene:
	var new_envi = enviornments.get(new_name)
	return new_envi
