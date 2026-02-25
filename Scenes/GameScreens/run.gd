extends Node

const BATTLE_SCREEN = preload("res://Scenes/GameScreens/battle_screen.tscn")
@onready var map: Map = $Map

func _ready() -> void:
	EventBus.map_node_pressed.connect(_on_map_node_pressed)

func _on_map_node_pressed(map_node : MapNode) -> void:
	if map_node.type == MapNode.Type.FIGHT:
		var battle_screen = BATTLE_SCREEN.instantiate()
		battle_screen.battle_stats = map_node.battle_stats
		self.add_child(battle_screen)
		map.hide()
		battle_screen.start_battle()
