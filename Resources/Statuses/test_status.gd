class_name TestStatus
extends Status

func apply_status(_target: Node) -> void:
	if _target is Enemy:
		_target.health_component.take_damage(99)
	
