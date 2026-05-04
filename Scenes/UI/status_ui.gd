class_name StatusUI
extends Control

@export var status : Status

@onready var texture_rect: TextureRect = $TextureRect
@onready var duration: Label = $TextureRect/Duration
@onready var intensity: Label = $TextureRect/Intensity

func _ready() -> void:
	status.status_changed.connect(update_ui)
	update_ui(status)

func update_ui(status : Status) -> void:
	if status == null:
		return
	
	texture_rect.texture = status.sprite
	duration.text = str(status.duration)
	intensity.text = str(status.intencity)
	
	self.tooltip_text = status.description
	
	if status.stack_type == Status.StackType.DURATION:
		duration.show()
	elif status.stack_type == Status.StackType.INTENCITY:
		intensity.show()
