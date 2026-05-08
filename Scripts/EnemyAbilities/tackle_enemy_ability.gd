extends EnemyAbility

@export var damage : int = 1

func apply() -> void:
	var affected_damage = enemy.modifier_handler.affect_type(Modifier.ModifierType.OUTCOME_DAMAGE, damage)
	
	target.health_component.take_damage(affected_damage)
