extends KinematicBody2D

func hit():
	if self.is_in_group("restaurar"):
		queue_free()
	$AnimatedSprite2D.play("roto")
	$CollisionShape2D.disabled = true

func restaurar():
	$AnimatedSprite2D.play("default")  # Cambiar a la animación original
	$CollisionShape2D.disabled = false  # Volver a activar la colisión
