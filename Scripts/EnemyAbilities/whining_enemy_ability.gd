extends EnemyAbility

@export var self_status : Status
@export var target_status : Status

func is_applicapable() -> bool:
	if enemy.intended_ability == null:
		return false
	
	return enemy.intended_ability is RoarEnemyAbility

func apply() -> void:
	target.status_handler.add_status(target_status)
	enemy.status_handler.add_status(self_status)
