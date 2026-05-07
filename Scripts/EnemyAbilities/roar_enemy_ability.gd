class_name RoarEnemyAbility
extends EnemyAbility

@export var status_effect : Status

func apply() -> void:
	enemy.status_handler.add_status(status_effect)
