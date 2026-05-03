class_name Enemy
extends Node

@onready var defence_component: DefenceComponent = $DefenceComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var ability_picker: EnemyAbilityPicker = $EnemyAbilityPicker
@onready var hp_label: Label = $HPLabel

var intended_ability: EnemyAbility

func _ready() -> void:
	health_component.health_run_out.connect(_on_health_run_out)
	EventBus.turn_start.connect(_pick_ability)
	EventBus.turn_end.connect(_use_intended_ability)
	health_component.health_changed.connect(_update_ui)

func _update_ui(old_hp, new_hp) -> void:
	hp_label.text = "HP: " + str(new_hp)

func _pick_ability() -> void:
	intended_ability = ability_picker.pick_ability()

func _use_intended_ability() -> void:
	intended_ability.apply()

func _on_health_run_out() -> void:
	EventBus.enemy_died.emit()
	self.queue_free.call_deferred()
