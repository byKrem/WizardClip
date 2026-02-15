extends Node2D

var current_turn: int = 0

@onready var player: Player = %Player
var enemies: Array[Enemy]

var selected_clip : Clip
var selected_enemy : Enemy

func _use_selected_clip() -> void:
	var abilities = selected_clip.get_abilities()
	
	for ability in abilities:
		if ability is BaseClipAbility:
			ability.apply_effect(player)
			ability.apply_on_enemy(selected_enemy)


func _on_button_pressed() -> void:
	selected_clip = get_tree().get_nodes_in_group("selected_clip").pop_back()
	selected_enemy = get_tree().get_nodes_in_group("selected_enemy").pop_back()
	
	if selected_clip == null or selected_enemy == null:
		return
	
	_use_selected_clip()
