class_name StatusHandler
extends GridContainer

@onready var parent: Node = $".."

const STATUS_UI = preload("res://Scenes/UI/status_ui.tscn")

func _ready() -> void:
	EventBus.turn_end.connect(_apply_statuses)

func add_status(status : Status) -> void:
	for child_status : StatusUI in get_children():
		if child_status.status.id == status.id:
			if status.stack_type == Status.StackType.DURATION:
				child_status.status.duration += status.duration
			elif status.stack_type == status.StackType.INTENCITY:
				child_status.status.intencity += status.intencity
			
			return
	
	var new_status = STATUS_UI.instantiate()
	new_status.status = status
	self.add_child(new_status)

func _apply_statuses() -> void:
	for child_status : StatusUI in get_children():
		child_status.status.apply_status(parent)
		if child_status.status.can_expire:
			child_status.status.duration -= 1
		
		if child_status.status.stack_type == Status.StackType.DURATION and child_status.status.duration <= 0:
			child_status.queue_free()
			
		if child_status.status.stack_type == Status.StackType.INTENCITY and child_status.status.intencity == 0:
			child_status.queue_free()
