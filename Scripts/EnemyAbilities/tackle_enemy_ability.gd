extends EnemyAbility

@export var damage : int = 1

func apply() -> void:
	var affected_damage : int = enemy.affect_outcome_damage(damage)
	target.health_component.take_damage(affected_damage)
