extends MarginContainer

# In context of [AbilityCell] entity this variable is [AbilityCell] itself
# So it can be showed or hided
var data_backup

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_BEGIN:
		data_backup = get_viewport().gui_get_drag_data()
	if what == NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_backup != null:
				data_backup.preview_data.show()
				data_backup = null
