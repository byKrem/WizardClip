extends Panel
class_name Clip

@onready var ability_inventory: AbilityInventory = $AbilityInventory

# TODO: If in battle state lock drag'n'drop for ability dices
# And make drag'n'drop for entire clip (Selected clip -> Selected Enemy)

# TODO: Create resource strategy for abilities modifiers
var clip_effect

func get_abilities() -> Array[BaseClipAbility]:
	var abilities = ability_inventory.get_abilities()
	
	# TODO: If I want to make abilities that applies their effect on other
	# abilities, I can check for them first
	
	for ability in abilities:
		if ability is BaseClipAbility:
			# TODO: Make stategies for abilities modifiers
			pass
	
	return abilities
