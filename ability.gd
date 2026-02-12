extends Node

@export var ClipAbility : BaseClipAbility
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel

func _ready() -> void:
	if ClipAbility == null:
		printerr("ClipAbility missing")
		return
	
	rich_text_label.text = ClipAbility.name
	if ClipAbility.texture != null:
		texture_rect.texture = ClipAbility.texture
