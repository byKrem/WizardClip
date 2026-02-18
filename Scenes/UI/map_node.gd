class_name MapNode
extends TextureButton

enum MapTypeEnum {
	Battle,
	Event,
	Boss,
}

@export var node_type : MapTypeEnum

var lvl = 0
# TODO: Make resource type for this variable
var map_resource
var is_pressed : bool = false

func _draw() -> void:
	draw_circle(Vector2.ZERO, 4, Color.WHITE_SMOKE)
	
	var margin = 10
	var line = position - (position+Vector2(200,200))
	var normal = line.normalized()
	line -= margin * normal
	draw_line(normal * margin, line, Color.WHITE, 2, true)

func _ready() -> void:
	#self.texture_normal = map_resource.texture_normal
	#if is_pressed == true:
		#self.texture_normal = map_resource.texture_pressed_disabled
	#self.texture_pressed= map_resource.texture_pressed
	#self.texture_hover = map_resource.texture_hover
	#self.texture_disabled = map_resource.texture_disabled
	#self.pressed.connect(_on_pressed)
	pass

func _on_pressed() -> void:
	# TODO: Open resource event. It can be a battle or a simple dialog window
	# I think it must be a PackedScene and nothing else, so it can be easily
	# showed on player screen
	is_pressed = true
	self.disabled = true
	pass
