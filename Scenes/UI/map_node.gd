class_name MapNode
extends TextureButton

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

func _to_string() -> String:
	return str(type)[0]
