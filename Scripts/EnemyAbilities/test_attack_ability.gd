extends EnemyAbility

@export var damage : int = 1

func apply() -> void:
	target.health_component.take_damage(damage)
