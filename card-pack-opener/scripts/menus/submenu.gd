class_name Submenu
extends Control

@export var spatial_anchor: Node3D
@export var freezes_player: bool = true

signal main_request(function: Menus.functions, args: Array)
