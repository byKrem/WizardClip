class_name PowerOfYouth
extends Status

# Decrese incoming damage by 50%

func apply_status(_target: Node) -> void:
	if _target.modifier_handler.has_mod_source(self):
		return
	
	var mod_val : PercentageModifierValue = PercentageModifierValue.new()
	mod_val.set_value(-0.5)
	var new_mod = Modifier.create_new_mod(self, Modifier.ModifierType.INCOME_DAMAGE, mod_val)
	_target.modifier_handler.add_mod(new_mod)
