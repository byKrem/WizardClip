class_name Modifier
extends Node

enum ModifierType {OUTCOME_DAMAGE, INCOME_DAMAGE}

var source : Status
var type : ModifierType
var value : ModifierValue

static func create_new_mod(source : Status, mod_type : ModifierType, mod_value : ModifierValue) -> Modifier:
	var new_mod : Modifier = new()
	new_mod.source = source
	new_mod.type = mod_type
	new_mod.value = mod_value
	return new_mod;
