class_name EnemyStats
extends Resource


@export var art: Texture

@export_group("Enemy Stats")
@export var max_health := 1
@export var speed := 1.0
@export var damage := 1
@export var defense := 1

var current_health := max_health

func create_instance() -> Resource:
	var instance: EnemyStats = self.duplicate()
	instance.current_health = max_health
	return instance
