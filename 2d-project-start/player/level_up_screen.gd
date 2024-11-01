extends Node2D


func _on_skip_level_up_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main.tscn")
