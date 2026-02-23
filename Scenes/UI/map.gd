class_name Map
extends Control

@onready var control: Control = $ScrollContainer/Control
@onready var scroll_container: ScrollContainer = $ScrollContainer

var map_generator : MapGenerator
var current_pos_on_map : MapNode
var map : Array[Array] # Array of Array of MapNodes

func _ready() -> void:
	_visualize_map()
	_place_contents()
	
	EventBus.map_node_pressed.connect(_on_node_pressed)
	
	if current_pos_on_map == null:
		for map_node : MapNode in map[0]:
			map_node.set_can_reach(true)
	else:
		current_pos_on_map.set_can_reach(false)
		for next_node : MapNode in current_pos_on_map.next_nodes:
			next_node.set_can_reach(true)

func _on_node_pressed(node : MapNode) -> void:
	if node == null or node == current_pos_on_map:
		return
	
	current_pos_on_map.set_can_reach(false)
	current_pos_on_map = node
	
	for next_node : MapNode in node.next_nodes:
		next_node.set_can_reach(true)

func _visualize_map() -> void:
	if map.is_empty():
		map_generator = MapGenerator.new()
		map = map_generator.generate_new_map()
	
	for nodes in map:
		for node in nodes:
			control.add_child(node)

func _place_contents() -> void:
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
