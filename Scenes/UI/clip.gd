extends Panel
class_name Clip

signal selection_toggled(selection: bool)

@onready var ability_inventory: AbilityInventory = $AbilityInventory
@onready var label: Label = $Label


# TODO: If in battle state lock drag'n'drop for ability dices
# And make drag'n'drop for entire clip (Selected clip -> Selected Enemy)

# TODO: Create resource strategy for abilities modifiers
var clip_effect
var selected = false
@export var group_name = "selected"

func _ready() -> void:
	gui_input.connect(_gui_input)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("left_click"):
			set_selected(!selected)
			accept_event()

func set_selected(value: bool):
	selected = value
	if selected:
		get_tree().call_group(group_name, set_selected.get_method(), false)
		add_to_group(group_name)
	else:
		remove_from_group(group_name)
		
	label.text = "Selected: " + str(selected)
	selection_toggled.emit(value)

func get_abilities() -> Array[BaseClipAbility]:
	var abilities = ability_inventory.get_abilities()
	
	# TODO: If I want to make abilities that applies their effect on other
	# abilities, I can check for them first
	
	for ability in abilities:
		if ability is BaseClipAbility:
			# TODO: Make stategies for abilities modifiers
			pass
	
	return abilities
