class_name Enemy
extends Node

@onready var defence_component: DefenceComponent = $DefenceComponent
@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	health_component.health_run_out.connect(_on_health_run_out)

func _on_health_run_out() -> void:
	EventBus.enemy_died.emit()
	self.queue_free.call_deferred()
