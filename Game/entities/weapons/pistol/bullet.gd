extends Area2D

@export var projectile_stats: Projectile

var total_travelled_distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * projectile_stats.speed * delta

	total_travelled_distance += projectile_stats.speed * delta
	if total_travelled_distance > projectile_stats.range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
