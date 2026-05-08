class_name Status
extends Resource

signal status_changed(status : Status)
signal status_expired(status : Status)

enum StackType {NONE, DURATION, INTENCITY}

@export_category("Status data")
@export var id : String
@export var sprite : Texture2D
@export var duration : int : set = set_duration
@export var intencity : int : set = set_intencity
@export var stack_type : StackType
@export var can_expire : bool
@export var force_apply : bool
@export_multiline var description : String

func set_duration(new_val : int):
	duration = new_val
	status_changed.emit(self)
	if duration <= 0 and stack_type == StackType.DURATION:
		status_expired.emit(self)

func set_intencity(new_val : int):
	intencity = new_val
	status_changed.emit(self)
	if intencity == 0 and stack_type == StackType.INTENCITY:
		status_expired.emit(self)

func apply_status(_target: Node) -> void:
	pass # override this for every status effect
