class_name BattleStats
extends Resource

@export_range(0, 2) var battle_tier: int
@export_range(0.0, 10.0) var weight: float
@export var enemies : PackedScene

var accumulated_weight: float = 0.0
