extends Panel
class_name AbilityDice

@export var ClipAbility : BaseClipAbility
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel

func _ready() -> void:
	_update_resource(ClipAbility)

func _update_resource(new_clip_ability : BaseClipAbility) -> void:
	if new_clip_ability == null:
		rich_text_label.clear()
		texture_rect.texture = null
		return
	
	ClipAbility = new_clip_ability
	$VBoxContainer.show()
	
	rich_text_label.text = new_clip_ability.name
	if new_clip_ability.texture != null:
		texture_rect.texture = new_clip_ability.texture

func _make_preview() -> Control:
	var preview_node = $VBoxContainer.duplicate()
	
	$VBoxContainer.hide()
	
	return preview_node

func _get_drag_data(at_position: Vector2) -> Variant:
	var data = ClipAbility
	
	ClipAbility = null
	
	set_drag_preview(_make_preview())
	
	return data

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	# In this context [ClipAbility] is the cell where I want to drop smth.
	# And the [data] is from the cell I took them off
	
	if ClipAbility != null:
		return false
	
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is BaseClipAbility:
		_update_resource(data)
