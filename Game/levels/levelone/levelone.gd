extends Node2D

signal change_to_level_up

func spawn_mob():
	const SLIME_SCENE = preload("res://entities/enemies/slime/slime.tscn")
	var new_mob = SLIME_SCENE.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func _on_player_leveled_up() -> void:
	emit_signal("change_to_level_up")
