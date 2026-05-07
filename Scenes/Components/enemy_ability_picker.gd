class_name EnemyAbilityPicker
extends Node

var enemy : Enemy

var total_weight : int = 0

func _ready() -> void:
	set_weights()

func set_weights() -> void:
	var weight_value : int = 0
	
	for ability : EnemyAbility in get_children():
		if ability != null and ability.type == EnemyAbility.Type.CHANCEBASED:
			weight_value += ability.weight
			ability.accumulated_weight = weight_value
	
	total_weight = weight_value

func pick_ability() -> EnemyAbility:
	var ability = pick_conditional()
	if ability != null:
		return ability
	
	ability = pick_chancebased()
	if ability != null:
		return ability
	
	return null

func pick_conditional() -> EnemyAbility:
	for ability : EnemyAbility in get_children():
		if ability != null and ability.type == EnemyAbility.Type.CONDITIONAL:
			ability.target = get_tree().get_nodes_in_group("player").pop_back()
			ability.enemy = enemy
			if ability.is_applicapable():
				return ability
	
	return null
	
func pick_chancebased() -> EnemyAbility:
	var roll = randi_range(0, total_weight)
	
	for ability : EnemyAbility in get_children():
		if ability != null and ability.type == EnemyAbility.Type.CHANCEBASED:
			ability.target = get_tree().get_nodes_in_group("player").pop_back()
			ability.enemy = enemy
			if roll <= ability.accumulated_weight:
				return ability
	
	return null
