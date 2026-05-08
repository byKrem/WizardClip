class_name AttackAbility
extends BaseClipAbility

@export var value : int = 2

func apply_on_enemy(enemy : Enemy) -> void:
	enemy.health_component.take_damage(value)
