class_name Enemy
extends Node

@onready var defence_component: DefenceComponent = $DefenceComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hp_label: Label = $HPLabel
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $SelectionArea2D/CollisionShape2D
@onready var status_handler: StatusHandler = $StatusHandler
@onready var enemy_intention: EnemyIntentionUI = $EnemyIntention

@export var stats : EnemyStats

var out_flat_damage : Array[int]
var out_percentage_damage : Array[float]

var intended_ability: EnemyAbility
var ability_picker: EnemyAbilityPicker

func _ready() -> void:
	health_component.max_health = stats.max_health
	health_component._set_health_value(stats.max_health)
	sprite_2d.texture = stats.sprite
	var new_collition_shape = RectangleShape2D.new()
	new_collition_shape.size = sprite_2d.texture.get_size()
	collision_shape_2d.shape = new_collition_shape
	
	if stats.enemy_ai != null:
		var picker = stats.enemy_ai.instantiate()
		add_child(picker)
		ability_picker = picker
		ability_picker.enemy = self
	
	health_component.health_run_out.connect(_on_health_run_out)
	EventBus.turn_start.connect(_pick_ability)
	EventBus.turn_end.connect(_use_intended_ability)
	health_component.health_changed.connect(_update_ui)
	

func _update_ui(old_hp, new_hp) -> void:
	hp_label.text = "HP: " + str(new_hp)

func _pick_ability() -> void:
	intended_ability = ability_picker.pick_ability()
	enemy_intention.set_intention(intended_ability)

func _use_intended_ability() -> void:
	intended_ability.apply()

func affect_outcome_damage(damage : int) -> int:
	for flat_mod in out_flat_damage:
		damage += flat_mod
	
	var total_percantage : float  = 0.0
	for percantage_mod in out_percentage_damage:
		total_percantage += percantage_mod
	
	return damage * (1.0 + total_percantage)

func _on_health_run_out() -> void:
	EventBus.enemy_died.emit()
	self.queue_free.call_deferred()
