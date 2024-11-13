extends CharacterBody2D
class_name Mob

@export var enemy_stats: EnemyStats : set = set_enemy_stats
@export var experience_stats: ExperienceStats

@onready var player = get_node("/root/levelOneManager/LevelOne/Player") #This needs to be changed to just be the player
	
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
	const EXPERIENCE_SCENE = preload("res://experienceNugget.tscn")
	var smoke = SMOKE_SCENE.instantiate()
	var experience = EXPERIENCE_SCENE.instantiate()
	experience.stats = experience_stats
	get_parent().add_child(smoke)
	get_parent().add_child(experience)
	smoke.global_position = global_position
	experience.global_position = global_position
