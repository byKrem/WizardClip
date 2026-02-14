extends Node2D

var current_turn: int = 0

var player: Player
var enemies: Array[Enemy]

var selected_clip : Clip
var selected_enemy : Enemy

func _use_selected_clip() -> void:
	var abilities = selected_clip.get_abilities()
	
	for ability in abilities:
		if ability is BaseClipAbility:
			ability.apply_effect(player)
			ability.apply_on_enemy(selected_enemy)
