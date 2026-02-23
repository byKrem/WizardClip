class_name EnemyEventsPool
extends Node

var _possible_events_dir = "res://Resources/Events/Enemies/"
var _possible_events : PackedStringArray

func get_random_battle() -> Resource:
	if _possible_events.size() == 0:
		_possible_events = ResourceLoader.list_directory(_possible_events_dir)
	
	return ResourceLoader.load(_possible_events[randi_range(0,_possible_events.size()-1)])
