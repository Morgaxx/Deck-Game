extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LevelOne.visible = true
	%TestLevelUpScreen.visible = false
	%TestLevelUpScreen.get_child(0).visible = false # Removing this fixes the instant _on_drop_point_detector_area_entered
	get_tree().paused = false


func _on_level_one_change_to_level_up() -> void:
	await get_tree().create_timer(1.0).timeout #TODO: Does this also delete it when the timer is over?
	get_tree().paused = true
	%LevelOne.visible = false
	%TestLevelUpScreen.visible = true
	%TestLevelUpScreen.get_child(0).visible = true

func _on_level_up_screen_change_scene_to_level() -> void:
	get_tree().paused = false
	%LevelOne.visible = true
	%TestLevelUpScreen.visible = false
	%TestLevelUpScreen.get_child(0).visible = false


func _on_skip_level_up_pressed() -> void:
	_on_level_one_change_to_level_up()
