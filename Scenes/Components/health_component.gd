class_name HealthComponent
extends Node

signal health_run_out()
signal health_lost(old_val: int, new_val: int)
signal health_gain(old_val: int, new_val: int)
signal health_changed(old_val: int, new_val: int)
signal overheal(value : int)

@export_category("Health Value")
@export var max_health : int = 5

var _current_health : int = 5

func _ready() -> void:
	_current_health = max_health

func take_damage(damage : int):
	_set_health_value(_current_health - damage)

func heal_health(value : int):
	_set_health_value(_current_health + value)

func _set_health_value(new_value : int):
	if new_value == _current_health:
		return
	
	var old_value = _current_health
	_current_health = clampi(new_value, 0, max_health)
	
	var health_difference = new_value - old_value
	
	if health_difference < 0:
		health_lost.emit(old_value, new_value)
	else:
		health_gain.emit(old_value, new_value)
		if new_value > max_health:
			overheal.emit(new_value - max_health)
	
	health_changed.emit(old_value, _current_health)
	if _current_health <= 0:
		health_run_out.emit()
	
