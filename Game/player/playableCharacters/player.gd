class_name Player
extends CharacterBody2D

var level = 1
var maximumHealth = 100.0
var currentHealth = maximumHealth
var nearby_enemies: Array[Node2D] = []
var currentExperience = 0
var maxExperience = 1

signal health_depleted
signal leveled_up

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide() #This applies delta, no need to apply it elsewhere.

	if velocity.length() > 0.0:
		%HappyBooModel.play_walk_animation()
	else:
		%HappyBooModel.play_idle_animation()
		
	for enemy: Node2D in nearby_enemies:
		take_damage(enemy.get_damage(),delta)

func _ready() -> void:
	%HealthBar.max_value = maximumHealth
	%ExperienceBar.max_value = maxExperience
			
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if(body.has_method("get_damage")):
		nearby_enemies.append(body)

func _on_hurt_box_body_exited(body: Node2D) -> void:
	nearby_enemies.erase(body)

func gain_experience(experience: int) -> void:
	currentExperience += experience
	if currentExperience >= maxExperience:
		currentExperience = currentExperience - maxExperience
		maxExperience = maxExperience*2
		%ExperienceBar.max_value = maxExperience
		emit_signal("leveled_up")
	%ExperienceBar.value = currentExperience
		
func take_damage(damage, delta) -> void:
	currentHealth -= damage * delta
	%HealthBar.value = currentHealth
	%HappyBooModel.play_hurt_animation()
	if currentHealth <= 0:
		health_depleted.emit()
