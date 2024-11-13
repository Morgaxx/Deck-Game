class_name ExperienceNugget
extends Area2D

@export var stats: ExperienceStats : set = set_experience_stats

var isActivated:= false
var recipient: Player

func _process(delta: float) -> void:
	if isActivated:
		look_at(recipient.global_position)
		var direction = Vector2.RIGHT.rotated(rotation)
		position += direction * stats.speed * delta
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(3) and not isActivated:
		recipient = area.get_parent()
		isActivated = true
	print(area.get_collision_layer)
	print(area.get_collision_layer_value(1))
	
	print(recipient == area.get_parent())
	
	print(isActivated)
	if area.get_collision_layer_value(1) and isActivated and recipient == area.get_parent():
		recipient.gain_experience(stats.ammount)
		queue_free()
		
		
	print("Body entered")
	
func set_experience_stats(value: ExperienceStats) -> void:
	stats = value.create_instance()
