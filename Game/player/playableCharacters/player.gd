extends CharacterBody2D

var health = 100.0
var nearby_enemies: Array[Node2D] = []
var exp = 0

signal health_depleted

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
		
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if(body.has_method("get_damage")):
		nearby_enemies.append(body)

func _on_hurt_box_body_exited(body: Node2D) -> void:
	nearby_enemies.erase(body)

func take_damage(damage, delta) -> void:
	health -= damage * delta
	%HealthBar.value = health
	%HappyBooModel.play_hurt_animation()
	if health <= 0:
		health_depleted.emit()
