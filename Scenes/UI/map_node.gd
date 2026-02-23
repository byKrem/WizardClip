class_name MapNode
extends TextureButton


enum Type {
	NOT_ASSIGNED = 0, # Empty node
	SHOP,
	FIGHT,
	EVENT,
	BOSS,
}

const TYPE_ICONS = {
	MapNode.Type.NOT_ASSIGNED : null,
	MapNode.Type.SHOP : preload("res://Assets/Images/ShopEventIcon.png"),
	MapNode.Type.FIGHT : preload("res://Assets/Images/EnemyEventIcon.png"),
	MapNode.Type.EVENT : preload("res://Assets/Images/RandomEventIcon.png"),
	MapNode.Type.BOSS : preload("res://Assets/Images/BossEventIcon.png"),
}

@onready var event_icon: TextureRect = $EventIcon

var type : Type = Type.NOT_ASSIGNED
var row : int = 0
var column : int = 0
var next_nodes : Array[MapNode]
var event : BaseMapEvent
var node_in_player_reach : bool = false

func _ready() -> void:
	event_icon.texture = TYPE_ICONS[type]
	if type == Type.NOT_ASSIGNED:
		self.texture_normal = null
	
	self.pressed.connect(_on_pressed)

func set_can_reach(value : bool) -> void:
	node_in_player_reach = value
	self.disabled = !value

func _on_pressed() -> void:
	if event == null || !event.is_valid():
		printerr("Event is null")
		return
	
	if !node_in_player_reach:
		return
	
	EventBus.map_node_pressed.emit(self)
	event.execute()

func _draw() -> void:
	for next_node in next_nodes:
		var line = self.position.distance_to(next_node.position)
		line = line * self.position.direction_to(next_node.position)
		line += next_node.size/2
		var color = Color.GRAY
		draw_dashed_line(self.size/2, line, color, 2, 5, true)

func _to_string() -> String:
	return str(type)[0]
