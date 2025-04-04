extends KinematicBody2D

var speed = 500
var velocity = Vector2()
var gravity = 5 # Aceleración de gravedad
var max_vel = 1000 # Velocidad máxima permitida
var moving = false
var puntos = 0
var multis = 1
var total = 0
var Divisor = load("res://scenes/characters/BolaM.tscn")
var mini = 0
var mini_gen = 0


func _physics_process(delta):
	var label1 = get_parent().get_node("multi/Label")
	var label2 = get_parent().get_node("puntos/Label")
	var label3 = get_parent().get_node("total/Label")
	
	label1.text = str(multis)
	label2.text = str(puntos)
	label3.text = str(total)
	
	if not moving and mini == mini_gen:
		total += puntos * multis
		puntos = 0
		multis = 1
		mini = 0
		mini_gen = 0
		look_at(get_global_mouse_position())
		if Input.is_action_just_pressed("Click-IZ"):
			velocity = Vector2(speed, 0).rotated(rotation)
			moving = true
	
	if moving == true:
		velocity.y += gravity
		
		# Limitar la velocidad máxima
		if velocity.length() > max_vel:
			velocity = velocity.normalized() * max_vel
		
		var collision = move_and_collide(velocity * delta)
		if collision:
			var colider = collision.get_collider()
			if colider.is_in_group("meta"):
				moving = false
				position = Vector2(634, 194)
				colider.call("hit")
			elif colider.is_in_group("puntos"):
				var normal = collision.normal
				var angle = normal.angle()
				
				velocity = velocity.bounce(normal) * 0.8  # Reducir velocidad tras impacto
				
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))
				
				puntos += 5
				colider.call("hit")
			elif colider.is_in_group("multi"):
				var normal = collision.normal
				var angle = normal.angle()
				
				velocity = velocity.bounce(normal) * 0.8  # Reducir velocidad tras impacto
				
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))
				
				multis += 1
				colider.call("hit")
			elif colider.is_in_group("empuje"):
				var normal = collision.normal
				var angle = normal.angle()
				
				velocity = velocity.bounce(normal) * 1.8  # Aumentar velocidad tras impacto
				
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))
				
				colider.call("hit")
			elif colider.is_in_group("restaurar"):
				var normal = collision.normal
				var angle = normal.angle()
				
				velocity = velocity.bounce(normal) * 1.8  # Aumentar velocidad tras impacto
				
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))
				
				get_parent().call("restaurar")
				colider.call("hit")
			elif colider.is_in_group("divisor"):
				var normal = collision.normal
				var angle = normal.angle()
				
				velocity = velocity.bounce(normal) * 1.8  # Aumentar velocidad tras impacto
				
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))
				
				var div = Divisor.instance()
				
				div.position = self.position + Vector2(5, 0)
				div.velocity = Vector2(-velocity.x, velocity.y)
				
				get_parent().add_child(div)
				mini_gen += 1
				colider.call("hit")
			else:
				var normal = collision.normal
				var angle = normal.angle()
				
				velocity = velocity.bounce(normal) * 0.8  # Reducir velocidad tras impacto
				
				if abs(angle) > deg2rad(75) and abs(angle) < deg2rad(105):
					velocity = velocity.rotated(deg2rad(10))


func s_puntos():
	puntos += 5

func s_multi():
	multis += 1

func comprobacion():
	mini += 1
