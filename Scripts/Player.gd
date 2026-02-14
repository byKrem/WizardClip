class_name Player
extends Node2D

@onready var health_component: HealthComponent = $HealthComponent
## TODO: Fill class

func _ready() -> void:
	health_component.health_run_out.connect(_die)

func _die() -> void:
	self.queue_free.call_deferred()
