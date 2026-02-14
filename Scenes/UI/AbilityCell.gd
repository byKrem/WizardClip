extends Panel
class_name AbilityDice

@export var ClipAbility : BaseClipAbility
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel
@onready var preview_data: Control = $VBoxContainer

func _ready() -> void:
	update_resource(ClipAbility)

func update_resource(new_clip_ability : BaseClipAbility) -> void:
	if new_clip_ability == null:
		ClipAbility = null
		rich_text_label.clear()
		texture_rect.texture = null
		return
	
	ClipAbility = new_clip_ability
	preview_data.show()
	
	rich_text_label.text = new_clip_ability.name
	if new_clip_ability.texture != null:	
		texture_rect.texture = new_clip_ability.texture

func _make_preview() -> Control:
	var preview = preview_data.duplicate()
	
	preview_data.hide()
	
	return preview

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(_make_preview())
	
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	# In this context [ClipAbility] is the cell where I want to drop smth.
	# And the [data] is from the cell I took them off
	
	if ClipAbility != null:
		return false
	
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is AbilityDice:
		update_resource(data.ClipAbility)
		data.update_resource(null)
