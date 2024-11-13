class_name ExperienceStats
extends Resource

@export var ammount := 1
@export var size := 1
@export var speed := 1


func create_instance() -> Resource:
	var instance: ExperienceStats = self.duplicate()
	return instance
