class_name EnemyAbility
extends Node

enum Type {CONDITIONAL, CHANCEBASED}

@export var icon : Texture2D

@export var type : Type
@export_range(1,100,1) var weight : int
var accumulated_weight : int = 0

var enemy : Enemy
var target : Node2D

func is_applicapable() -> bool:
	return false

func apply() -> void:
	pass
