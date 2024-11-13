extends Node2D

signal change_scene_to_level

func _on_skip_level_up_pressed() -> void:
	emit_signal("change_scene_to_level")
