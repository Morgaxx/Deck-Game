extends Mob


func play_animation(animationToPlay: String) -> void:
	match (animationToPlay):
		"WALK":
			%Slime.play_walk()
		"IDLE":
			%Slime.play_idle()
		"HURT":
			%Slime.play_hurt()
