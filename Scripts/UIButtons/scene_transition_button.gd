class_name SceneTransitionButton
extends Button

@export_file("*.tscn") var scene_file : String

func _ready() -> void:
	self.pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if scene_file.is_empty():
		printerr("scene_file was empty. There is nowhere to transfer")
		return
	
	get_tree().change_scene_to_file.call_deferred(scene_file)
