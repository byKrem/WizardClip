class_name DefenceComponent
extends Node

signal defence_lost(old_val: int, new_val: int)
signal defence_gain(old_val: int, new_val: int)
signal defence_changed(old_val: int, new_val: int)

var defence : int = 0

func apply_defence(incoming_damage : int) -> int:
	var result_damage = incoming_damage
	
	result_damage = clampi(incoming_damage-defence, 0, 999)
	defence = clampi(defence-incoming_damage, 0, 999)
	
	return result_damage

func add_defence(value : int) -> void:
	defence += value
