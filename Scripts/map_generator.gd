class_name MapGenerator
extends Node

var x_margin : int = 30
var y_margin : int = 50
var map_width: int = 7
var map_height:int = 10
var pos_offset:int = 10
var path_count:int = 5
var map : Array[Array]
const FIGHT_ROOM_WEIGHT : float = 12.0
const EVENT_ROOM_WEIGHT : float = 5.0
const SHOP_ROOM_WEIGHT : float = 2.5
const MAP_NODE = preload("res://Scenes/UI/map_node.tscn")
# floor 0: [1, 0, 1, 1, 0]
# floor 1: [3, 0, 0, 3, 0]
# floor 2: [1, 0, 1, 3, 0]
# floor 3: [0, 1, 0, 1, 0]
# floor 4: [1, 0, 0, 1, 0]
# floor 5: [3, 3, 0, 1, 0]
# floor 6: [1, 3, 0, 0, 3]
# floor 7: [0, 1, 1, 2, 0]
# floor 8: [3, 0, 2, 0, 0]
# floor 9: [0, 0, 4, 0, 0]

var random_room_type_weights = {
	MapNode.Type.FIGHT: 0.0,
	MapNode.Type.SHOP: 0.0,
	MapNode.Type.EVENT: 0.0
}
var random_room_type_total_weight : float = 0

func generate_new_map() -> Array[Array]:
	map = _generate_grid()
	
	var starting_pos : Array[int] = _randomize_starting_positions()
	
	for column_id in starting_pos:
		var current_column_id = column_id
		for row_id in map_height - 1:
			current_column_id = _create_connection(row_id, current_column_id)
	
	_set_boss_room()
	_setup_random_room_weights()
	_randomize_room_types()
	
	for i in range(map_height):
		print("floor ",i,": ",map[i])
	
	return map

func _randomize_starting_positions() -> Array[int]:
	var result : Array[int]
	var unique_positions_count: int = 0
	
	while unique_positions_count < 3:
		unique_positions_count = 0
		result = []
	
		for i in range(path_count):
			var starting_pos = randi_range(0, map_width-1)
			
			if !result.has(starting_pos):
				unique_positions_count += 1
			
			result.append(starting_pos)
	
	return result

func _create_connection(row_id : int, column_id : int) -> int:
	var next_node : MapNode = null
	var current_node : MapNode = map[row_id][column_id]
	
	while not next_node or !_can_connect_nodes(row_id, column_id, next_node):
		var random_column_id = clampi(randi_range(column_id-1,column_id+1), 0, map_width-1)
		next_node = map[row_id + 1][random_column_id]
	
	current_node.next_nodes.append(next_node)
	
	return next_node.column

func _can_connect_nodes(row_id : int, column_id : int, next_node : MapNode) -> bool:
	var left_node : MapNode
	var right_node : MapNode
	
	if column_id > 0:
		left_node = map[row_id][column_id-1]
	
	if column_id < map_width-1:
		right_node = map[row_id][column_id+1]
	
	if right_node != null and next_node.column > column_id:
		for right_next_node in right_node.next_nodes:
			if right_next_node.column < next_node.column:
				return false
	
	if left_node != null and next_node.column < column_id:
		for left_next_node in left_node.next_nodes:
			if left_next_node.column > next_node.column:
				return false
	
	return true

func _randomize_room_types() -> void:
	for node in map[0]:
		if node.next_nodes.size() > 0:
			node.type = MapNode.Type.FIGHT
	
	for node in map[4]:
		if node.next_nodes.size() > 0:
			node.type = MapNode.Type.SHOP
	
	for row in map:
		for node : MapNode in row:
			if node.next_nodes.size() > 0 and node.type == MapNode.Type.NOT_ASSIGNED:
				_set_room_randomly(node)

func _set_room_randomly(map_node : MapNode) -> void:
	var consecutive_shop : bool = true
	var intended_type
	while consecutive_shop:
		intended_type = _get_random_room_type_by_weight()
		
		var is_shop = intended_type == MapNode.Type.SHOP
		var is_parent_shop = _has_parent_of_type(map_node, MapNode.Type.SHOP)
		
		consecutive_shop = is_parent_shop and is_shop
	
	map_node.type = intended_type

func _has_parent_of_type(map_node : MapNode, target_type : MapNode.Type) -> bool:
	var parents : Array[MapNode]
	
	print("map row: %s \n map column %s" % [map_node.row, map_node.column])
	
	if map_node.column > 0 and map_node.row > 0:
		var parent : MapNode = map[map_node.row-1][map_node.column-1]
		if parent.next_nodes.has(map_node):
			parents.append(parent)
	
	if map_node.row > 0:
		var parent : MapNode = map[map_node.row][map_node.column-1]
		if parent.next_nodes.has(map_node):
			parents.append(parent)
	
	if map_node.column < map_width-1 and map_node.row > 0:
		var parent : MapNode = map[map_node.row+1][map_node.column-1]
		if parent.next_nodes.has(map_node):
			parents.append(parent)
	
	for parent in parents:
		if parent.type == target_type:
			return true
	
	return false

func _get_random_room_type_by_weight() -> MapNode.Type:
	var roll := randf_range(0.0, random_room_type_total_weight)
	
	for type: MapNode.Type in random_room_type_weights:
		if random_room_type_weights[type] > roll:
			return type
	
	return MapNode.Type.FIGHT

func _set_boss_room() -> void:
	var boss_node : MapNode = map[map_height-1][floori(map_width*0.5)]
	
	boss_node.type = MapNode.Type.BOSS
	
	for map_node : MapNode in map[map_height-2]:
		if map_node.next_nodes.size() == 0:
			continue
		map_node.next_nodes.clear()
		map_node.next_nodes.append(boss_node)

func _setup_random_room_weights() -> void:
	random_room_type_weights[MapNode.Type.FIGHT] = FIGHT_ROOM_WEIGHT
	random_room_type_weights[MapNode.Type.SHOP] = FIGHT_ROOM_WEIGHT + SHOP_ROOM_WEIGHT
	random_room_type_weights[MapNode.Type.EVENT] = random_room_type_weights[MapNode.Type.SHOP] + EVENT_ROOM_WEIGHT
	
	random_room_type_total_weight = random_room_type_weights[MapNode.Type.EVENT]

func _generate_grid() -> Array[Array]:
	var result : Array[Array] = []
	
	for i in map_height:
		var inner_floor : Array[MapNode] = []
		for j in map_width:
			var new_map_node : MapNode = MAP_NODE.instantiate()
			new_map_node.row = i
			new_map_node.column = j
			new_map_node.next_nodes = []
			new_map_node.position = Vector2(j*(50+x_margin),i*(50+y_margin)) + Vector2(randf(),randf()) * pos_offset
			inner_floor.append(new_map_node)
		
		result.append(inner_floor)
	
	return result
