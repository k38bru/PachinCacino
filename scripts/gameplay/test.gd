extends Node2D

var puntos_scene = load("res://scenes/objects/BloquePuntos.tscn")
var multi_scene = load("res://scenes/objects/BloqueMulti.tscn")
var empuje_scene = load("res://scenes/objects/BloqueEmpuje.tscn")
var restaurar_scene = load("res://scenes/objects/BloqueRestaurar.tscn")
var divisor_scene = load("res://scenes/objects/BloqueDivisor.tscn")

var filas = 15  # Cantidad de filas
var columnas = 38  # Cantidad de columnas
var espaciado = 20  # Espaciado entre los bloques

func _ready():
	crear_bloques()

func crear_bloques():
	for x in range(columnas):
		for y in range(filas):
			var bloque
			var probabilidad = randf()

			if probabilidad < 0.70:
				bloque = puntos_scene.instance()
			elif probabilidad < 0.80:
				bloque = multi_scene.instance()
			elif probabilidad < 0.95:
				bloque = empuje_scene.instance()
			elif probabilidad < 0.985:
				bloque = restaurar_scene.instance()
			else:
				bloque = divisor_scene.instance()

			bloque.position = Vector2(x * espaciado + 245, y * espaciado + 300)
			add_child(bloque)

func restaurar():
	for bloque in get_children():
		if bloque.has_method("restaurar"):
			bloque.restaurar()
