class_name ModifierHandler
extends Node

func affect_type(mod_type : Modifier.ModifierType, value : float) -> int:
	var flat_mod : int = 0
	var percentage_mod : float = 0.0
	
	for mod : Modifier in get_children():
		if mod.type == mod_type:
			if mod.value is FlatModifierValue:
				flat_mod += mod.value.get_value()
			elif mod.value is PercentageModifierValue:
				percentage_mod += mod.value.get_value()
	
	return floori((value + flat_mod) * (1 + percentage_mod))

func has_mod_source(source_status : Status) -> bool:
	for mod : Modifier in get_children(): # O(N)
		if mod.source.id == source_status.id:
			return true
	
	return false

func add_mod(mod : Modifier) -> void:
	if has_mod_source(mod.source):
		return
	
	mod.source.status_expired.connect(_remove_mod)
	mod.source.status_changed.connect(_updage_mod)
	add_child(mod)

func _updage_mod(source_status : Status) -> void:
	if source_status.stack_type != Status.StackType.INTENCITY:
		return
	
	for mod : Modifier in get_children():
		if mod.source.id == source_status.id:
			mod.value.set_value(source_status.intencity)

func _remove_mod(source_status : Status) -> void:
	for mod : Modifier in get_children():
		if mod.source.id == source_status.id:
			mod.queue_free()
