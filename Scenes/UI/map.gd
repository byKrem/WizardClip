class_name Map
extends Control

var map_generator : MapGenerator

func _ready() -> void:
	map_generator = MapGenerator.new()
	map_generator.generate_new_map()
	
