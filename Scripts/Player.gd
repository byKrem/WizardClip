class_name Player
extends Node2D

@onready var defence_component: DefenceComponent = $DefenceComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hp_label: Label = $HPLabel

func _ready() -> void:
	health_component.health_run_out.connect(_die)
	health_component.health_changed.connect(_update_ui)

func _update_ui(old_hp, new_hp) -> void:
	hp_label.text = "HP: " + str(new_hp)

func _die() -> void:
	self.queue_free.call_deferred()
