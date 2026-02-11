class_name BaseClipAbility
extends Resource

@export var texture : Texture2D = null
@export var name : String = "BaseAbility"
@export var weight : int = 0

# TODO: Make Player node
func apply_effect(player : Player) -> void:
	pass

# TODO: Make base Enemy node?
func apply_on_enemy(enemy : Enemy) -> void:
	pass
