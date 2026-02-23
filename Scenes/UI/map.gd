class_name Map
extends Control

@onready var control: Control = $ScrollContainer/Control

var map_generator : MapGenerator
var current_pos_on_map : MapNode
var map : Array[Array] # Array of Array of MapNodes

#TODO: Make MapNodes outside of player reach inactive
# Player reach is his current row_pos + 1
# Nodes that greater than row_pos+1 or lesser must be inactive

func _ready() -> void:
	if map.is_empty():
		map_generator = MapGenerator.new()
		map = map_generator.generate_new_map()
	
	# grid_container.columns = map[0].size()
	
	
	for nodes in map:
		for node in nodes:
			control.add_child(node)
	
