extends KinematicBody2D

var speed = 500
var velocity = Vector2()
var gravity = 5 # Aceleración de gravedad
var max_vel = 1000 # Velocidad máxima permitida


func _physics_process(delta):
	var bola = get_parent().get_node("Bola")
	
	velocity.y += gravity
	
	# Limitar la velocidad máxima
	if velocity.length() > max_vel:
		velocity = velocity.normalized() * max_vel
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var colider = collision.get_collider()
		if colider.is_in_group("meta"):
			colider.call("hit")
			bola.call("comprobacion")
			queue_free()
		elif colider.is_in_group("puntos"):
			var normal = collision.normal
			var angle = normal.angle()
			
			# Rebote con reducción de velocidad tras impacto
			velocity = velocity.bounce(normal) * 0.8  # Se reduce un 20% de velocidad
			
			# Corrección en ángulos diagonales
			if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
				velocity = velocity.rotated(deg2rad(10))
			
			bola.call("s_puntos")
			colider.call("hit")
		elif colider.is_in_group("multi"):
			var normal = collision.normal
			var angle = normal.angle()
			
			# Rebote con reducción de velocidad tras impacto
			velocity = velocity.bounce(normal) * 0.8  # Se reduce un 20% de velocidad
			
			# Corrección en ángulos diagonales
			if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
				velocity = velocity.rotated(deg2rad(10))
			
			bola.call("s_multi")
			colider.call("hit")
		elif colider.is_in_group("empuje"):
			var normal = collision.normal
			var angle = normal.angle()
			
			# Rebote con incremento de velocidad tras impacto
			velocity = velocity.bounce(normal) * 1.8
			
			# Corrección en ángulos diagonales
			if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
				velocity = velocity.rotated(deg2rad(10))
			
			colider.call("hit")
		elif colider.is_in_group("restaurar"):
			var normal = collision.normal
			var angle = normal.angle()
			
			# Rebote con incremento de velocidad tras impacto
			velocity = velocity.bounce(normal) * 1.8
			
			# Corrección en ángulos diagonales
			if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
				velocity = velocity.rotated(deg2rad(10))
			
			get_parent().call("restaurar")
			colider.call("hit")
		elif colider.is_in_group("divisor"):
			var normal = collision.normal
			var angle = normal.angle()
			
			# Rebote con incremento de velocidad tras impacto
			velocity = velocity.bounce(normal) * 1.8
			
			# Corrección en ángulos diagonales
			if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
				velocity = velocity.rotated(deg2rad(10))
			
			colider.call("hit")
		else:
			var normal = collision.normal
			var angle = normal.angle()
			
			# Rebote con reducción de velocidad tras impacto
			velocity = velocity.bounce(normal) * 0.8  # Se reduce un 20% de velocidad
			
			# Corrección en ángulos diagonales
			if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
				velocity = velocity.rotated(deg2rad(10))
