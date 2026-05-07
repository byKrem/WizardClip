class_name AttackAbility
extends BaseClipAbility

@export var value : int = 2
@export var status_effect : Status

func apply_on_enemy(enemy : Enemy) -> void:
	enemy.health_component.take_damage(value)
	enemy.status_handler.add_status(status_effect)
