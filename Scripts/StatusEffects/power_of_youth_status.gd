class_name PowerOfYouth
extends Status

# Decrese incoming damage by 50%

func apply_status(_target: Node) -> void:
	# this is shit
	_target.health_component.in_damage_mods.append(-0.5)
