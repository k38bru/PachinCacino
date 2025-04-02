extends Node2D

var puntos_scene = load("res://scenes/objects/BloquePuntos.tscn")
var multi_scene = load("res://scenes/objects/BloqueMulti.tscn")

var filas = 15  # Cantidad de filas
var columnas = 38  # Cantidad de columnas
var espaciado = 20  # Espaciado entre los bloques

func _ready():
	for x in range(columnas):
		for y in range(filas):
			var bloque
			if randf() < 0.8:  # 80%
				bloque = puntos_scene.instance()
			else:
				bloque = multi_scene.instance()
			
			bloque.position = Vector2(x * espaciado + 245, y * espaciado + 300)  # Distribuir en cuadrado
			add_child(bloque)
