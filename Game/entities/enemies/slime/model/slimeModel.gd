extends Node2D


func play_walk():
	%AnimationPlayer.play("walk",true)


func play_hurt():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("walk")

func play_idle():
	%AnimationPlayer.play("idle",true)
