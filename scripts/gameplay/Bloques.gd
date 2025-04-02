extends KinematicBody2D


func hit():
	$AnimatedSprite2D.play("roto")
	$CollisionShape2D.disabled = true
