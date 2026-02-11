class_name AttackAbility
extends BaseClipAbility

@export var value : int = 2

# TODO: Make base Enemy node?
func apply_on_enemy(enemy : Enemy) -> void:
	# Maybe Smth like this:
	# enemy.health_component.take_damage(value)
	pass
