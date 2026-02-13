extends MarginContainer

# In context of AbilityCell this variable is BaseClipAbility
var data_backup

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_BEGIN:
		data_backup = get_viewport().gui_get_drag_data()
	if what == NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			pass
