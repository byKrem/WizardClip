class_name EnemyIntentionUI
extends Control

@onready var icon: TextureRect = $Icon
@onready var damage_label: Label = $Icon/DamageLabel

func set_intention(new_intention : EnemyAbility) -> void:
	if new_intention.get("damage") != null:
		damage_label.text = str(new_intention.damage)
		damage_label.show()
	else:
		damage_label.hide()
	
	icon.texture = new_intention.icon
