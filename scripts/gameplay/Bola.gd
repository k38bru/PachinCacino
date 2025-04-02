extends KinematicBody2D

var speed = 500
var velocity = Vector2()
var gravity = 5 # Aceleración de gravedad
var moving = false
var puntos = 0
var multis = 1
var total = 0

func _physics_process(delta):
	var label1 = get_parent().get_node("multi/Label")
	var label2 = get_parent().get_node("puntos/Label")
	var label3 = get_parent().get_node("total/Label")
	
	label1.text = str(multis)
	label2.text = str(puntos)
	label3.text = str(total)
	
	if not moving:
		look_at(get_global_mouse_position())
		if Input.is_action_just_pressed("Click-IZ"):
			velocity = Vector2(speed, 0).rotated(rotation)
			moving = true
	
	if moving == true:
		velocity.y += gravity
		
		var collision = move_and_collide(velocity * delta)
		if collision:
			var colider = collision.get_collider()
			if colider.is_in_group("meta"):
				total += puntos * multis
				puntos = 0
				multis = 1
				moving = false
				position = Vector2(634, 194)
				colider.call("hit")
			elif colider.is_in_group("puntos"):
				var normal = collision.normal
				var angle = normal.angle()
				
				# Rebote con reducción de velocidad tras impacto
				velocity = velocity.bounce(normal) * 0.8  # Se reduce un 20% de velocidad
				
				# Corrección en ángulos diagonales
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))
				
				puntos += 5
				colider.call("hit")
			elif colider.is_in_group("multi"):
				var normal = collision.normal
				var angle = normal.angle()
				
				# Rebote con reducción de velocidad tras impacto
				velocity = velocity.bounce(normal) * 0.8  # Se reduce un 20% de velocidad
				
				# Corrección en ángulos diagonales
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))
				
				multis += 1
				colider.call("hit")
			else:
				var normal = collision.normal
				var angle = normal.angle()
				
				# Rebote con reducción de velocidad tras impacto
				velocity = velocity.bounce(normal) * 0.8  # Se reduce un 20% de velocidad
				
				# Corrección en ángulos diagonales
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))
