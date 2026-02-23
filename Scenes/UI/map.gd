class_name Map
extends Control

@onready var control: Control = $ScrollContainer/Control
@onready var scroll_container: ScrollContainer = $ScrollContainer

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
	
	for nodes in map:
		for node in nodes:
			control.add_child(node)
	
	var content_width : int = 0
	for node : MapNode in map[0]:
		content_width += node.size.x
		content_width += map_generator.x_margin
	
	var content_heigth : int = 0
	for i in map.size():
		content_heigth += map[i][0].size.y
		content_heigth += map_generator.y_margin
	
	control.custom_minimum_size = Vector2(content_width,content_heigth)
	scroll_container.custom_minimum_size = Vector2(content_width,0)
	scroll_container.position.x = (control.position - control.size/2).x + content_width/2
