extends CharacterBody2D
class_name Mob

const MAX_HEALTH = 3
var current_health = MAX_HEALTH
var damage = 5.0

@onready var player = get_node("/root/Game/Player")
	
	
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
	
	if velocity.length() > 0.0:
		%Slime.play_walk()
	else:
		%Slime.play_idle()
		
func get_damage() -> float:
	return damage
	
func take_damage() -> void:
	current_health -= 1
	%Slime.play_hurt()
	if current_health == 0:
		die()
		
func die() -> void:
	queue_free()
	const SMOKE_SCENE = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_SCENE.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
