class_name DefenceAbility
extends BaseClipAbility

@export var value : int = 5

# TODO: Make Player node
func apply_effect(player : Player) -> void:
	player.defence_component.defence += value
