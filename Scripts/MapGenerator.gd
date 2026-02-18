class_name MapGenerator
extends Node

func generate(node_num : int, plate_len : int, path_num : int) -> MapData:
	
	# Randomize positions for MapNodes
	var points : Array[Vector2]
	points.append(Vector2(0, plate_len/2))
	points.append(Vector2(plate_len,plate_len/2))
	
	for i in node_num:
		while true:
			var pos : Vector2 = Vector2(randi()%plate_len,randi()%(plate_len/2))
			
			var in_circle : bool = pos.length() <= plate_len*1.25
			
			if !points.has(pos) and in_circle:
				points.append(pos)
				break
	
	# Array of indexes of points that create a triangle.
	# In this context 0,1,2 indexes - is first triangle
	var triangles : Array[int] = Geometry2D.triangulate_delaunay(points)
	
	var astar = AStar2D.new()
	
	for i in range(triangles.size() / 3):
		var p1 = points[i]
		astar.add_point(i,p1)
		var p2 = points[i + 1]
		astar.add_point(i+1,p1)
		var p3 = points[i + 2]
		astar.add_point(i+2,p1)
		if !astar.are_points_connected(i,i+1):
			astar.connect_points(i,i+1)
		if !astar.are_points_connected(i+1,i+2):
			astar.connect_points(i+1,i+2)
		if !astar.are_points_connected(i+2,i):
			astar.connect_points(i+2,i)
	
	for i in range(path_num):
		var path : Array[int] = astar.get_id_path(0,1)
		if path.size() == 0:
			break
		
		
	
	var data = MapData.new()
	# TODO: Fill data
	return data
