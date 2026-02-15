extends Area2D
class_name SelectionArea2D

signal selection_toggled(selection: bool)

@onready var parent: Node = $".."

@export var group_name = "selected"

var selected: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		set_selected(!selected)

func set_selected(value: bool):
	selected = value
	if selected:
		get_tree().call_group(group_name, set_selected.get_method(), false)
		parent.add_to_group(group_name)
	else:
		parent.remove_from_group(group_name)
		
	selection_toggled.emit(value)
