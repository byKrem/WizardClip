extends Node2D

var current_turn: int = 0

@onready var player: Player = %Player

@onready var clip_1: Clip = $UI/Clip
@onready var clip_2: Clip = $UI/Clip2

@onready var clips: Array[Clip] = [
	clip_1,
	clip_2
]

@export var battle_stats : BattleStats

var enemies_subnode : Node

var selected_clip : Clip
var selected_enemy : Enemy

func _ready() -> void:
	EventBus.enemy_died.connect(_on_enemy_died)

func _on_enemy_died() -> void:
	if enemies_subnode.get_child_count() - 1 <= 0:
		print("Victory!")

func start_battle() -> void:
	var node = battle_stats.enemies.instantiate()
	
	enemies_subnode = node
	
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
	# Group stays unchanged. There I do pop from Array that I get from func.
	# There is no ref to group itself.
	# TODO: I NEED to clear selected_enemy group
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
