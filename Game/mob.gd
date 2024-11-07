extends CharacterBody2D
class_name Mob

@export var enemy_stats: EnemyStats : set = set_enemy_stats

@onready var player = get_node("/root/Game/Player")
	
enum currentAnimation {IDLE,WALK,HURT}
	
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * enemy_stats.speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		play_animation("WALK")
	else:
		play_animation("IDLE")
		
func set_enemy_stats(value: EnemyStats) -> void:
	enemy_stats = value.create_instance()
	
	#if not stats.stats_changed.is_connected(update_stats):    This is to connect any signals
		#stats.stats_changed.connect(update_stats)
	
func play_animation(animationToPlay: String):
	pass
	
func get_damage() -> float:
	return enemy_stats.damage
	
func take_damage() -> void:
	enemy_stats.current_health -= 1
	play_animation("HURT")
	if enemy_stats.current_health == 0:
		die()
		
func die() -> void:
	queue_free()
	const SMOKE_SCENE = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_SCENE.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
