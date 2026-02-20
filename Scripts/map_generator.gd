class_name MapGenerator
extends Node

var x_margin : int = 30
var y_margin : int = 25
var map_width: int = 5
var map_height:int = 10
var pos_offset:int = 5
var path_count:int = 3
var map : Array[Array]

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


func generate_new_map() -> Array[Array]:
	map = _generate_grid()
	
	var starting_pos : Array[int] = _randomize_starting_positions()
	
	for column_id in starting_pos:
		var current_column_id = column_id
		for row_id in map_height - 1:
			current_column_id = _create_connection(row_id, current_column_id)
	
	_set_boss_room()
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
	
	for node in map[4]:
		if node.next_nodes.size() > 0:
			node.type = MapNode.Type.SHOP
	
	for row in map:
		for node : MapNode in row:
			if node.next_nodes.size() > 0 and node.type == MapNode.Type.NOT_ASSIGNED:
				node.type = randi_range(1,3)

func _set_boss_room() -> void:
	var boss_node : MapNode = map[map_height-1][floori(map_width*0.5)]
	
	boss_node.type = MapNode.Type.BOSS

func _generate_grid() -> Array[Array]:
	var result : Array[Array] = []
	
	for i in map_height:
		var inner_floor : Array[MapNode] = []
		for j in map_width:
			var new_map_node : MapNode = MapNode.new()
			new_map_node.row = i
			new_map_node.column = j
			new_map_node.next_nodes = []
			new_map_node.position = Vector2(i,j) + Vector2(randf(),randf()) * pos_offset
			inner_floor.append(new_map_node)
		
		result.append(inner_floor)
	
	return result
