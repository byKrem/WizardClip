class_name MapNode
extends TextureButton


# Maybe use Dictionary{Type, Array[MapEvent]}
enum Type {
	NOT_ASSIGNED = 0, # Empty node
	SHOP,
	FIGHT,
	EVENT,
	BOSS,
}

var type : Type = Type.NOT_ASSIGNED
var row : int = 0
var column : int = 0
var next_nodes : Array[MapNode]

# Must have some resource
# that should contain
# event that will be executed
# by clicking on this btn
# var event : MapEvent

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	pass
	#event.execute()

func _to_string() -> String:
	return str(type)[0]
