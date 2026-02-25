extends Node2D

var current_turn: int = 0

@onready var player: Player = %Player
var enemies: Array[Enemy]

@onready var clip_1: Clip = $UI/Clip
@onready var clip_2: Clip = $UI/Clip2

@onready var clips: Array[Clip] = [
	clip_1,
	clip_2
]

@export var battle_stats : BattleStats

#TODO: I need a way to transfer data to this scene to load some enemies
# on scene initialization

var selected_clip : Clip
var selected_enemy : Enemy

func start_battle() -> void:
	var node = battle_stats.enemies.instantiate()
	self.add_child(node)
	

func _use_selected_clip() -> void:
	if selected_clip == null or selected_enemy == null:
		return
	
	var abilities = selected_clip.get_abilities()
	var cooldown : int = 0
	
	for ability in abilities:
		if ability is BaseClipAbility:
			ability.apply_effect(player)
			ability.apply_on_enemy(selected_enemy)
			cooldown += ability.weight
	
	selected_clip.cooldown = cooldown


func _on_button_pressed() -> void:
	selected_clip = get_tree().get_nodes_in_group("selected_clip").pop_back()
	selected_enemy = get_tree().get_nodes_in_group("selected_enemy").pop_back()
	
	for clip in clips:
		if clip is Clip:
			clip.cooldown = clampi(clip.cooldown - 1, 0, 999)
	
	_use_selected_clip()
	
	if selected_clip:
		selected_clip.set_selected(false)
		selected_clip = null
	# selected_enemy.set_selected(false)
	selected_enemy = null
