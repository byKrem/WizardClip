class_name StatusHandler
extends GridContainer

@onready var parent: Node = $".."

const STATUS_UI = preload("res://Scenes/UI/status_ui.tscn")

func _ready() -> void:
	EventBus.turn_end.connect(_apply_statuses)

func add_status(status : Status) -> void:
	assert(status != null, "Status effect is missing")
	
	for child_status : StatusUI in get_children():
		if child_status.status.id == status.id:
			if status.stack_type == Status.StackType.DURATION:
				child_status.status.duration += status.duration
			elif status.stack_type == status.StackType.INTENCITY:
				child_status.status.intencity += status.intencity
			
			return
	
	var new_status = STATUS_UI.instantiate()
	status.status_expired.connect(_remove_status)
	new_status.status = status
	if status.force_apply == true:
		status.apply_status(parent)
	self.add_child(new_status)

func _apply_statuses() -> void:
	for child_status : StatusUI in get_children():
		# If status stack_type is Intencity it can expire after it's effect
		child_status.status.apply_status(parent)
		# If status stack_type is Duration it can expire after this
		if child_status.status.can_expire:
			child_status.status.duration -= 1

func _remove_status(expired_status : Status) -> void:
	for child_status : StatusUI in get_children():
		if child_status.status.id == expired_status.id:
			child_status.queue_free()
