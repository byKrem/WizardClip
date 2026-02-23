class_name EnemyMapEvent
extends BaseMapEvent

# Somehow get an array of all posible enemies events resources
var enemy_events_pool : EnemyEventsPool
const BATTLE_SCREEN = preload("res://Scenes/GameScreens/battle_screen.tscn")

func execute():
	if enemy_events_pool == null:
		enemy_events_pool = EnemyEventsPool.new()
	
	# Resource for battle screen
	var enemies = enemy_events_pool.get_random_battle()
	
	var screen = BATTLE_SCREEN.instantiate()
	screen.enemies = enemies
	return screen


func is_valid() -> bool:
	return true
